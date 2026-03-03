<div align="center">
  <h1>MVrc 🖤</h1>
  <p>
    <b>Minimal & Approachable Vim9 Configuration</b>
  </p>
  <img controls src="docs/demo.gif" title="MVrc Demo" />
</div>

<br>

MVrc is a Vim configuration built with one goal:

Make Vim feel simple, clean, and welcoming again.

No plugin managers.
No dependency chaos.
No “why did my editor break today?”

Just Vim. The way it should feel.

---

## 🚀 Getting Started

### ① Make sure you have Vim 9.x

```
vim --version
```

Confirm that your Vim version is 9.x.

If not… it might be time for an upgrade.

---

### ② Paste MVrc into your config file

#### macOS / Linux

```
~/.vimrc
```

#### Windows

```
~/vimfiles/_vimrc
```

Copy and paste the MVrc content into that file.

---

### ③ Restart Vim

That’s it.

No plugin installation.
No setup scripts.
No ritual sacrifices.

---

## Why MVrc Exists

Trying to build the “perfect Vim setup” often leads to:

* Endless plugin searching
* Dependency issues
* Broken configs after updates
* A config so complex you’re afraid to touch it

And eventually… giving up.

So here’s a radical idea:

What if everything worked using only standard Vim9script?

MVrc was born from that idea.

---

## ✨ Concept

* Simple
* Understandable
* Beginner-friendly
* Plugin-free
* Modern and visually consistent

MVrc is not trying to be “the ultimate Vim setup.”

It’s trying to be:

A Vim setup you can actually enjoy using.

---

## 🧩 Features

### 🎨 Modern Dark Theme

A unified dark color scheme across:

* Statusline
* Popup menus
* File tree
* Editor area

Clean. Calm. Focused.

---

### 🌿 Git Branch Display

* Shows current branch
* Handles detached HEAD
* Auto-updates on save and movement

Because context matters.

---

### 🌲 File Tree (Using Vim’s Built-in netrw)

Open:

```
\e
```

* Opens on the left
* No line numbers
* No banner
* Styled to match the theme

Close:

```
\x
```

This is not a toggle.
You open it intentionally. You close it intentionally.

Minimalism includes intention.

---

### 🤖 ChatGPT Integration

MVrc includes lightweight integration to open ChatGPT in your browser.

No heavy plugins. Just practical help.

---

#### ① Send selected code

1. Enter visual mode:

```
v
```

2. Select your code
3. Press:

```
\g
```

Your selected code is sent with a helpful template asking for:

* Explanation
* Improvements
* Possible bugs

Your browser opens automatically.

---

#### ② Send a direct prompt

```
:Chat <your question>
```

Example:

```
:Chat How can I optimize this algorithm?
```

---

#### ③ Send selected range via command

Select text in visual mode, then:

```
:ChatGPT
```

---

#### Requirements

* python3 installed
* Internet connection

---

### 🪟 Window Management

#### Split to the right

```
\ + Right Arrow
```

#### Open terminal below

```
\t
```

Opens with 12 lines.

#### Save and close

```
\x
```

If the file isn’t saved, it saves automatically.

---

### 🧠 Smart Completion

* `<Tab>` → completion or indent (context-aware)
* `<S-Tab>` → move backward
* `<CR>` → confirm popup selection

Simple. Predictable.

---

## Basic Vim Controls

MVrc assumes standard Vim basics.

---

### Modes

Insert mode:

```
i
```

Return to normal mode:

```
Esc
```

Visual mode:

```
v
```

---

### Save and Quit

Save:

```
:w
```

Quit:

```
:q
```

Save and quit:

```
:wq
```

Quit without saving:

```
:q!
```

---

### Move Between Splits

```
Ctrl + w + ←
Ctrl + w + →
Ctrl + w + ↑
Ctrl + w + ↓
```

---

## ⌨️ MVrc Keymaps

| Key              | Action                      |
| ---------------- | --------------------------- |
| `\e`             | Open file tree              |
| `\g`             | Send selection to ChatGPT   |
| `:Chat <prompt>` | Send direct prompt          |
| `\t`             | Open terminal               |
| `\x`             | Save and close              |
| `\ + →`          | Split right                 |
| `\y`             | Copy to system clipboard    |
| `\p`             | Paste from system clipboard |

---

## 🛠 Requirements

* Vim 9.x
* git
* python3

---

## 🤍 MVrc Is Not the Final Form

This isn’t a “maxed-out” Vim setup.

It’s a foundation.

A clean starting point.

Something you can understand, modify, and grow without fear.

---

If you’re tired of complexity…

If you just want Vim to feel good again…

MVrc might be your reset button.
