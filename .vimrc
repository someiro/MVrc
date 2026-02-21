vim9script

# ==============================
# 基本設定
# ==============================

set number
set relativenumber
set cursorline

set laststatus=2
set statusline=%f\ %m%r%h%w\ [%{&filetype}]\ %=%l:%c

syntax on
set termguicolors

set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2

set ignorecase
set smartcase
set incsearch
set hlsearch

# ==============================
# 見た目
# ==============================

set background=dark

highlight clear
syntax reset

highlight Normal        guifg=#e5e7eb guibg=#0f1115
highlight LineNr        guifg=#4b5563 guibg=#0f1115
highlight CursorLineNr  guifg=#9ca3af guibg=#111827
highlight CursorLine    guibg=#111827
highlight Comment       guifg=#6b7280 gui=italic

highlight Keyword       guifg=#60a5fa
highlight Statement     guifg=#60a5fa
highlight Type          guifg=#38bdf8

highlight String        guifg=#34d399
highlight Constant      guifg=#34d399
highlight Number        guifg=#34d399

highlight Function      guifg=#a78bfa
highlight Identifier    guifg=#e5e7eb

highlight StatusLine    guifg=#e5e7eb guibg=#111827
highlight StatusLineNC  guifg=#6b7280 guibg=#0f1115
highlight VertSplit     guifg=#1f2933 guibg=#0f1115

highlight Search        guifg=#0f1115 guibg=#facc15
highlight IncSearch     guifg=#0f1115 guibg=#fde047

highlight Error         guifg=#fecaca guibg=#7f1d1d
highlight ErrorMsg      guifg=#fecaca guibg=#7f1d1d
highlight Visual        guibg=#1f2937

# ==============================
# 補完
# ==============================

set completeopt=menuone,noselect
set pumheight=10

highlight Pmenu      guifg=#e5e7eb guibg=#1f2937
highlight PmenuSel   guifg=#0f1115 guibg=#34d399
highlight PmenuSbar  guibg=#111827
highlight PmenuThumb guibg=#4b5563

# ==============================
# Smart Tab
# ==============================

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

# ==============================
# ChatGPT 連携
# ==============================

xnoremap <silent> <leader>g :ChatGPT<CR>

command -range ChatGPT ChatGPTQuery(<line1>, <line2>)

var chatgpt_prompt = [
  '以下のコードについて、',
  '1. 何をしているコードかの解説',
  '2. 改善できる点',
  '3. バグや危険な箇所の可能性',
  'を教えてください。',
]

def ChatGPTQuery(first: number, last: number)
  if first == 0 && last == 0
    if index(['v', 'V', "\<C-v>"], mode()) == -1
      echoerr 'Visual選択がありません'
      return
    endif
  endif

  var start = first == 0 ? line("'<") : first
  var end_  = last  == 0 ? line("'>") : last

  var selected = join(getline(start, end_), "\n")

  if empty(trim(selected))
    echoerr '選択範囲が空です'
    return
  endif

  if strlen(selected) > 4000
    echoerr 'コードが長すぎます'
    return
  endif

  var ft = empty(&filetype) ? 'text' : &filetype

  var text =
        join(chatgpt_prompt, "\n") .. "\n\n" ..
        "```" .. ft .. "\n" ..
        selected .. "\n```"

  if !executable('python3')
    echoerr 'python3 が見つかりません'
    return
  endif

  var encoded = system(
        'python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.stdin.read()))"',
        text
      )

  if v:shell_error != 0
    echoerr 'URLエンコードに失敗しました'
    return
  endif

  var url = 'https://chat.openai.com/?q=' .. trim(encoded)
  OpenBrowser(url)

  echo 'ChatGPTをプロンプト付きで開きました 🚀'
enddef

def OpenBrowser(url: string)
  var escaped = shellescape(url)

  if has('mac')
    system('open ' .. escaped)
  elseif has('unix')
    if executable('xdg-open')
      system('xdg-open ' .. escaped)
    else
      echoerr 'xdg-open が見つかりません'
    endif
  elseif has('win32') || has('win64')
    system('cmd /c start "" ' .. escaped)
  else
    echoerr '未対応のOSです'
  endif
enddef

# ==============================
# ChatGPT Command Mode (:Chat)
# ==============================

command -nargs=+ Chat CallChatCommand(<q-args>)

def CallChatCommand(prompt: string)
  if empty(trim(prompt))
    echoerr 'Prompt is empty'
    return
  endif

  if !executable('python3')
    echoerr 'python3 が見つかりません'
    return
  endif

  var encoded = system(
        'python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.stdin.read()))"',
        prompt
      )

  if v:shell_error != 0
    echoerr 'URLエンコードに失敗しました'
    return
  endif

  var url = 'https://chat.openai.com/?q=' .. trim(encoded)
  OpenBrowser(url)

  echo 'ChatGPTをプロンプト付きで開きました 🚀'
enddef