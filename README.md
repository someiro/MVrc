<div align="center">
<h1>🖤 MVrc</h1>
<p>Modern Vim Configuration</p><br>
<video controls src="https://github.com/someiro/MVrc/raw/refs/heads/main/docs/demo.mp4" title="MVrc Demo" width="320" height="240"></video>
</div>


This configuration was created through experimentation and intuition — pure Vibe Coding.

A Vim9 Script vimrc written by someone who just vibes with Vim – no formal Vim scripting experience required.  
The main goal: make Vim feel good and fun to use, with ChatGPT integration for code exploration.

---

## 🇯🇵 日本語版

For Japanese readers, see the [Japanese README](docs/README_ja.md) 🇯🇵

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

#### Visual Mode (Code Review)

1. Select code in visual mode
2. Press `<leader>g`
3. Your browser opens ChatGPT

The following prompt is automatically included:

- Explain what this code does
- Suggest improvements
- Highlight bugs or potential risks

#### Command Mode (Free Prompt)

You can also send any question directly using a Vim command.

Example:

```
:Chat Explain closures in simple terms
```

This opens ChatGPT in your browser with the prompt already filled in.


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
