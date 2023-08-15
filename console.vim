" Vim syntax file enabling highlighting in 'console' input/output sessions 
" Language: Console
" Maintainer: Denice Deatrich <denice.deatrich at gmail.com>
" Filenames: *.console
" Last Change: 2023-08-14

" 'Console' is a contrived specfication for input/output at the Linux/UNIX
" command-line.  It is useful for teaching purposes.
" Install in: ~/.vim/syntax/

" In a markdown editing session 'console' fenced code blocks are syntax-
"  highlighted because vim's 'markdown' syntax file already enables other
"  code syntax-highlighting PROVIDED THAT you add 'console' to the list
"  of filetypes to be highlighted in markdown.
" So edit your ~/.vimrc file and minimally add this:
"  let g:markdown_fenced_languages = ['console']
" See:  https://github.com/tpope/vim-markdown
"
" For a pointer to Linguist (some 700 'languages'), and also for other
" fenced code hints) see:
"  https://coderwall.com/p/ftqcla/markdown-with-fenced-code-blocks-in-vim
"
" See your local vim installation to see all current official syntax files:
" $ vi
" :echo $VIMRUNTIME    (my system says:  /usr/share/vim/vim82)
" so look in /usr/share/vim/vim82/syntax/

if exists("b:current_syntax")
  finish
endif


"----------------------- syntax matching ------------------------
" Labels: consoleUserPrompt, consoleRootPrompt, consoleComment
" mysql, virsh or other future commands with their own 'shell':
" Labels: consoleMysql, consoleVirsh

syn region consoleUserPrompt start=/^$ / skip=/\\$/ excludenl end=/$/

syn region consoleRootPrompt start=/^# / skip=/\\$/ excludenl end=/$/


" Not heavily tested...  Note that some mysql command types do not need to end
"  in a semi-colon, but it also doesn't hurt to use one.
syn region consoleMysql start=/^mysql> / end=/;$/

syn region consoleVirsh start=/^virsh # / end=/$/

syn match consoleComment '^\/\/ .*$'

"------------------- set the style colors -----------------------
if &background == "dark"
  hi cUser ctermfg=lightgreen term=bold cterm=bold gui=bold guifg=green
  hi cSuper ctermfg=lightred term=bold cterm=bold gui=bold guifg=red
  hi cOther ctermfg=magenta term=bold cterm=bold gui=bold guifg=purple1
  hi cComment ctermfg=lightblue term=bold,italic cterm=bold,italic gui=bold,italic guifg=SlateBlue
else
  hi cUser ctermfg=green term=bold cterm=bold gui=bold guifg=seagreen
  hi cSuper ctermfg=red term=bold cterm=bold gui=bold guifg=darkred
  hi cOther ctermfg=magenta term=bold cterm=bold gui=bold guifg=purple1
  hi cComment ctermfg=blue term=bold,italic cterm=bold,italic gui=bold,italic guifg=blue
endif

"------------------- link labels to styles ----------------------
hi! link consoleUserPrompt cUser
hi! link consoleRootPrompt cSuper
hi! link consoleMysql cOther
hi! link consoleVirsh cOther
hi! link consoleComment cComment

let b:current_syntax = "console"

