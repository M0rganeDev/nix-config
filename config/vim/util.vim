"	----------------------------------------------
"			Replace command (s/ / /g wrapper)
"	----------------------------------------------

function! ReplaceString(old, new)
    let l:old = escape(a:old, '\')
    let l:new = escape(a:new, '\')
    
	if empty(matchstr(join(getline(1, '$'), "\n"), l:old))
		echo "\r"
        echo "String not found"
    else
        execute '%s/' . l:old . '/' . l:new . '/g'
    endif
endfunction

function! PromptReplaceString()
    let l:old = input('Enter the old string: ')
    let l:new = input('Enter the new string: ')
    call ReplaceString(l:old, l:new)
endfunction

command! Replace call PromptReplaceString()

function UnFuckUpVim()
	execute ':colorscheme blue'
	execute ':colorscheme PaperColor'
	execute ':NERDTree'
endfunction

function SearchFiles()
	if empty (system('git rev-parse'))
		execute ':GFiles'
	else
		execute ':Files'
	endif
endfunction



command! SearchFzfFiles call SearchFiles()

" autoclose vim if NerdTree is the last opened buffer
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" dont open stuff in NerdTree's buffer
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" show hidden files
let NERDTreeShowHidden=1

" git util

function! IsGitRepo()
	return empty(system('git rev-parse'))
endfunction

function! PrepareCommit()
	if IsGitRepo()
		call system('git add .')
	endif
endfunction


function! AskUserForMessage()
	if IsGitRepo()
		" Open a new buffer in a vertical split (you can change this to horizontal split or other layout)
		execute 'vsplit'
		setlocal buftype=acwrite
		setlocal bufhidden=hide  " Hide buffer when closed, instead of wiping it out
		setlocal noswapfile
		setlocal modifiable

		" Set buffer name to indicate it's for commit message
		call setbufvar('%', '&filetype', 'gitcommit')
		call setbufvar('%', '&bufname', '[GIT COMMIT MESSAGE]')

		" Write instructions in the buffer
		call setline(1, 'Please enter your commit message below, save and close this buffer to continue:')
		call append(1, '')

		" Add the commit message and close the buffer when done
		autocmd BufWritePost <buffer> call WriteCommitMessage()
	endif
endfunction

function! WriteCommitMessage()
	" Read lines from the buffer (skipping the first instruction line)
	let message = join(getline(2, '$'), "\n")

	" If the message is not empty, commit with the message
	if !empty(message)
		call system('git commit -m "' . message . '"')
		echo "Commit message saved and committed."
	else
		echo "Commit message was empty, commit aborted."
	endif

	" Instead of closing the buffer, just hide it
	bwipeout
endfunction

function! PushToRemote()
	if IsGitRepo()
		let branch = system('git rev-parse --abbrev-ref HEAD')
		let remotes = split(system('git remote'), "\n")
		if empty(remotes)
			echo "No remotes found."
			return
		endif

		let choice = input("Choose remote to push to (or 'all' to push to all): ", remotes[0])

		if choice == 'all'
			for remote in remotes
				if !empty(remote)
					call system('git push ' . remote . ' ' . branch)
				endif
			endfor
		else
			if index(remotes, choice) != -1
				call system('git push ' . choice . ' ' . branch)
			else
				echo "Invalid remote."
			endif
		endif
	endif
endfunction

function! CommitAndPush()
	if IsGitRepo()
		call PrepareCommit()
		call AskUserForMessage()
		call PushToRemote()
	endif
endfunction

command! PushToRepo call CommitAndPush()
