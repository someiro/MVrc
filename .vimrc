vim9script

# ==================================================
# Minimal Modern Vim9 Configuration
# Plugin-free / Copy & Paste Ready
# ==================================================

# ==================================================
# 1. Core Settings
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

if has('termguicolors')
  set termguicolors
endif

set background=dark

set title
set titlestring=%f

set clipboard=unnamedplus


# ==================================================
# 2. Search
# ==================================================

set ignorecase
set smartcase
set incsearch
set hlsearch


# ==================================================
# 3. Completion + Smart Tab
# ==================================================

set completeopt=menuone,noselect
set pumheight=10

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
# 4. Theme (Modern Dark)
# ==================================================

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

highlight link netrwDir        Directory
highlight link netrwClassify   Type
highlight link netrwSymLink    Identifier
highlight link netrwExe        Statement
highlight link netrwComment    Comment
highlight link netrwTreeBar    LineNr

highlight netrwDir      guifg=#60a5fa gui=bold
highlight netrwTreeBar  guifg=#4b5563

# ==================================================
# 5. Statusline
# ==================================================

set laststatus=2
set statusline=%#StatusLineGit#%{GitBranch()}%#StatusLine#\ %f\ %=%l:%c

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
# 6. Git Branch (Detached-safe)
# ==================================================

var git_branch = ''

def UpdateGitBranch()
  if !executable('git')
    git_branch = ''
    return
  endif

  var inside = trim(system('git rev-parse --is-inside-work-tree'))
  if v:shell_error != 0 || inside !=# 'true'
    git_branch = ''
    return
  endif

  var branch = trim(system('git rev-parse --abbrev-ref HEAD'))

  if v:shell_error != 0
    git_branch = ''
    return
  endif

  if branch ==# 'HEAD'
    git_branch = '[detached]'
  else
    git_branch = '[' .. branch .. ']'
  endif
enddef

def g:GitBranch(): string
  return git_branch
enddef


# ==================================================
# 7. ChatGPT Integration
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
  elseif has('win32') || has('win64')
    system('start "" ' .. escaped)
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
    echo "Opening ChatGPT 🤖"
  endif
enddef

def ChatGPTQuery(first: number, last: number)
  var start = first == 0 ? line("'<") : first
  var end_  = last  == 0 ? line("'>") : last
  var code  = join(getline(start, end_), "\n")

  EncodeAndOpen(
    join(chatgpt_prompt, "\n") ..
    "\n\n```" .. &filetype .. "\n" ..
    code ..
    "\n```"
  )
enddef

def CallChatCommand(prompt: string)
  EncodeAndOpen(prompt)
enddef


# ==================================================
# 8. Utility Commands
# ==================================================

def g:OpenBottomTerminal()
  botright split
  resize 12
  terminal ++curwin
  echo "Terminal ready 🚀"
enddef

nnoremap <leader>t :call OpenBottomTerminal()<CR>

nnoremap <Leader>y "+yy
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P


# ==================================================
# 9. Window Management
# ==================================================

# Always split to the right
def SplitRight()
  rightbelow vsplit
  echo "Split created → 🪟"
enddef

command! SplitRight call SplitRight()
nnoremap <leader><Right> <Cmd>SplitRight<CR>

# Save and close current window safely
def g:SaveAndClose()
  if winnr('$') == 1
    echo "Nothing to close 🙂"
    return
  endif

  if &modified
    write
  endif

  close
  echo "Closed ✨"
enddef

nnoremap <leader>x <Cmd>call g:SaveAndClose()<CR>


# ==================================================
# 10. Autocommands
# ==================================================

augroup MVrc
  autocmd!
  autocmd BufEnter,DirChanged * UpdateGitBranch()
  autocmd InsertEnter,InsertLeave,ModeChanged * UpdateStatusline()
  autocmd BufWritePost * UpdateGitBranch()
augroup END

UpdateStatusline()
UpdateGitBranch()


# ==================================================
# 11. File Tree (Built-in netrw)
# ==================================================

g:netrw_banner = 0
g:netrw_liststyle = 3       
g:netrw_browse_split = 4    
g:netrw_altv = 1
g:netrw_winsize = 40

def g:ToggleFileTree()
  leftabove vsplit
  vertical resize 40
  Explore
  setlocal nonumber norelativenumber
  echo "File tree opened 🌲"
enddef

nnoremap <leader>e <Cmd>:call ToggleFileTree()<CR>
