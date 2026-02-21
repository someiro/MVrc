# Vim9 Vibe Coding vimrc 🚀

This is pure Vibe Coding.

A Vim9 Script vimrc written by someone who just vibes with Vim – no formal Vim scripting experience required.  
The main goal: make Vim feel good and fun to use, with ChatGPT integration for code exploration.

---

## ✨ Features

- ✅ Vim9 Script only
- 🎨 Dark theme with visually clear syntax highlighting
- ⌨️ Smart Tab completion (auto-indent or complete based on context)
- 🤖 ChatGPT integration
  - Send visual-selected code directly to ChatGPT in the browser
- 🧠 Minimalistic settings optimized for "just feels right"

---

## 🧩 What It Does

### 🔹 Basic Settings
- Line numbers / Relative numbers
- Highlight current line
- Statusline with file info
- Autoindent, smartindent, tabs, and search behavior

### 🔹 Appearance
- Dark background
- Easy-on-the-eyes syntax colors
- Comments, keywords, functions, and strings highlighted clearly

### 🔹 Smart Tab
```vim
Tab       → indent or completion
Shift+Tab → previous completion
Enter     → confirm completion or newline
```

### 🔹 ChatGPT Integration

Select code in visual mode

Press `<leader>g`

Your browser opens ChatGPT

The following prompt is automatically included:

Please review the following code:
1. Explain what this code does
2. Suggest improvements
3. Highlight bugs or potential risks

### 🛠 Requirements

- Vim 9.0+
- vim9script enabled
- python3 installed
- Supported OS:
  - macOS (open)
  - Linux (xdg-open)
  - Windows (cmd /c start)

> **❌ Note :** Not compatible with Neovim (Vim9 Script required)

### 📦 How to Use

1. Clone this repository
2. Copy the contents into ~/.vimrc (or your preferred config path)
3. Launch Vim
4. Enjoy vibecoding ✨

### ⚠️ Cautions

- This vimrc is experimental and written purely by vibe
- Not optimized for robustness or large-scale use
- ChatGPT URL may break if the service changes
- Use at your own risk

### 🤍 Why It Exists

- To explore Vim through experimentation
- To mix coding with a sense of fun
- To make starting Vim less intimidating for beginners

### 📜 License

MIT — freely vibe with it.

### 🌀 Final Note

This is not a perfect vimrc.  
It works, it feels good, and it’s fun — that’s enough.
  
Happy Vibecoding 🧠✨
