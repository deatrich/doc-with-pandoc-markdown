" Add vim syntax file enabling highlighting in 'console' input/output sessions 
" Language: Markdown (modified)
" Maintainer: Denice Deatrich <denice.deatrich at gmail.com>
" Filenames: *.md
" Last Change: 2023-07-03

" Install in: ~/.vim/syntax/

" This works because vim's markdown syntax file already enables other
"  code syntax-highlighting PROVIDED THAT you add 'console' to the
"  list of filetypes to be highlighted in markdown.  So edit
"  your ~/.vimrc file and minimally add this:
"  let g:markdown_fenced_languages = ['console']
" See:  https://github.com/tpope/vim-markdown
" For a list of some 700 'languages', also for other fenced code hints, see:
"  https://coderwall.com/p/ftqcla/markdown-with-fenced-code-blocks-in-vim
" On Ubuntu 22.04 there are 646 syntax files for different 'languages'

if exists("b:current_syntax")
  finish
endif

" Match console output regular expression and label them internally
syn match consoleUserPrompt '^$ .*$'
syn match consoleRootPrompt '^# .*$'
syn match consoleComment '^\/\/ .*$'

" Assign labelled lines and apply the named style to the matched lines
hi def link consoleComment Comment
hi def link consoleUserPrompt markdownID
hi def link consoleRootPrompt htmlTagName

