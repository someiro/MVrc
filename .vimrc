vim9script

# ==================================================
# 基本設定
# ==================================================

set number
set relativenumber
set cursorline

set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2

syntax on
set termguicolors
set background=dark

# ==================================================
# 検索
# ==================================================

set ignorecase
set smartcase
set incsearch
set hlsearch

# ==================================================
# 補完
# ==================================================

set completeopt=menuone,noselect
set pumheight=10

# ==================================================
# Smart Tab
# ==================================================

def SmartTab(): string
  var coln = col('.') - 1
  if coln <= 0 || getline('.')[0 : coln - 1] =~ '^\s*$'
    return "\<Tab>"
  endif
  return "\<C-n>"
enddef

def SmartSTab(): string
  return "\<C-p>"
enddef

inoremap <expr> <Tab>   SmartTab()
inoremap <expr> <S-Tab> SmartSTab()
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

# ==================================================
# Theme
# ==================================================

highlight clear
syntax reset

highlight Normal        guifg=#e5e7eb guibg=#0f1115
highlight LineNr        guifg=#4b5563 guibg=#0f1115

highlight CursorLine    guibg=#0b1220
highlight CursorLineNr  guifg=#93c5fd guibg=#0b1220

highlight Comment       guifg=#6b7280 gui=italic

highlight Keyword       guifg=#60a5fa
highlight Statement     guifg=#60a5fa
highlight Type          guifg=#38bdf8

highlight String        guifg=#34d399
highlight Constant      guifg=#34d399
highlight Number        guifg=#34d399

highlight Function      guifg=#a78bfa
highlight Identifier    guifg=#e5e7eb

highlight Search        guifg=#0f1115 guibg=#facc15
highlight IncSearch     guifg=#0f1115 guibg=#fde047

highlight Visual        guibg=#1f2937
highlight Error         guifg=#fecaca guibg=#7f1d1d
highlight ErrorMsg      guifg=#fecaca guibg=#7f1d1d

highlight Pmenu         guifg=#e5e7eb guibg=#1f2937
highlight PmenuSel      guifg=#0f1115 guibg=#34d399
highlight PmenuSbar     guibg=#111827
highlight PmenuThumb    guibg=#4b5563


# ==================================================
# Statusline
# ==================================================

set laststatus=2
set statusline=%#StatusLineGit#%{GitBranch()}%#StatusLine#%=%l:%c

highlight StatusLine        guifg=#e5e7eb guibg=#111827
highlight StatusLineNC      guifg=#6b7280 guibg=#0f1115
highlight StatusLineGit     guifg=#34d399 guibg=#111827 gui=bold

highlight StatusLineNormal  guifg=#e5e7eb guibg=#111827 gui=bold
highlight StatusLineInsert  guifg=#0f1115 guibg=#60a5fa gui=bold
highlight StatusLineVisual  guifg=#0f1115 guibg=#a78bfa gui=bold

def UpdateStatusline()
  var m = mode()

  if m =~# '^[iR]'
    highlight! link StatusLine StatusLineInsert
  elseif m =~# '^[vV\x16]'
    highlight! link StatusLine StatusLineVisual
  else
    highlight! link StatusLine StatusLineNormal
  endif
enddef


# ==================================================
# Git Branch
# ==================================================

var git_branch = ''

def UpdateGitBranch()
  if !executable('git')
    git_branch = ''
    return
  endif

  var inside = trim(system('git rev-parse --is-inside-work-tree 2>/dev/null'))
  if v:shell_error != 0 || inside !=# 'true'
    git_branch = ''
    return
  endif

  var branch = trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))
  if v:shell_error != 0 || branch ==# ''
    git_branch = ''
    return
  endif

  git_branch = '[' .. branch .. ']'
enddef

def g:GitBranch(): string
  return git_branch
enddef


# ==================================================
# ChatGPT Integration
# ==================================================

xnoremap <silent> <leader>g :ChatGPT<CR>

command -range ChatGPT ChatGPTQuery(<line1>, <line2>)
command -nargs=+ Chat CallChatCommand(<q-args>)

var chatgpt_prompt = [
  '以下のコードについて、',
  '1. 何をしているコードかの解説',
  '2. 改善できる点',
  '3. バグや危険な箇所の可能性',
  'を教えてください。',
]

def OpenBrowser(url: string)
  var escaped = shellescape(url)
  if has('mac')
    system('open ' .. escaped)
  elseif has('unix') && executable('xdg-open')
    system('xdg-open ' .. escaped)
  endif
enddef

def EncodeAndOpen(text: string)
  if !executable('python3')
    echoerr 'ChatGPT feature requires python3'
    return
  endif

  var encoded = system(
    'python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.stdin.read()))"',
    text
  )
  if v:shell_error == 0
    OpenBrowser('https://chat.openai.com/?q=' .. trim(encoded))
  endif
enddef

def ChatGPTQuery(first: number, last: number)
  var start = first == 0 ? line("'<") : first
  var end_  = last  == 0 ? line("'>") : last
  var code  = join(getline(start, end_), "\n")
  EncodeAndOpen(join(chatgpt_prompt, "\n") .. "\n\n```" .. &filetype .. "\n" .. code .. "\n```")
enddef

def CallChatCommand(prompt: string)
  EncodeAndOpen(prompt)
enddef

# ==================================================
# UI
# ==================================================

set title
set titlestring=%f


# ==================================================
# Autocommands
# ==================================================

augroup MVrc
  autocmd!
  autocmd BufEnter,DirChanged * UpdateGitBranch()
  autocmd BufWritePost * UpdateGitBranch()
  autocmd InsertEnter,InsertLeave,ModeChanged * UpdateStatusline()
augroup END

UpdateStatusline()


# ==================================================
# Auto Save on Normal Mode
# ==================================================

def AutoSave()
  if &modifiable && bufname('%') !=# '' && &buftype ==# ''
    silent write
    echo 'Saved ✨'
  endif
enddef

#autocmd InsertLeave * AutoSave()
#autocmd ModeChanged [vV\x16]*:* AutoSave()


def g:OpenBottomTerminal()
  botright split
  resize 12
  terminal ++curwin
  echo 'Terminal ready 🚀'
enddef

nnoremap <leader>t :call OpenBottomTerminal()<CR>


# ==================================================
# Horizontal Split (Right only)
# ==================================================

def SplitRight()
  wincmd v
  wincmd l
enddef

command! SplitRight call SplitRight()
nnoremap <leader><Right> <Cmd>SplitRight<CR>

def g:SaveAndClose()
  if winnr('$') == 1
    echo 'Nothing to close 🙂'
    return
  endif

  if &modified
    write
  endif

  close
  echo 'Closed ✨'
enddef

nnoremap <leader>x <Cmd>call g:SaveAndClose()<CR>


# ==================================================
# Undo / Redo
# ==================================================

nnoremap <leader>u u
nnoremap <leader>r <C-r>


