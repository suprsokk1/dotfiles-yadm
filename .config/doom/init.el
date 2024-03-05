;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-
(doom! :completion
       company
       vertico

       :ui
       (modeline +light)
       (popup +defaults)
       emoji
       hl-todo
       treemacs
       zen

       :editor
       multiple-cursors
       file-templates
       fold
       format
       snippets

       :emacs
       (dired +icons)
       undo
       vc

       :checkers
       syntax

       :term
       vterm

       :tools
       (docker +lsp +custom)
       (eval +overlay)
       (lsp +eglot)
       ;; direnv
       ansible
       debugger
       editorconfig
       lookup
       magit
       tmux

       :lang
       (org +roam2 +pretty +pomodoro)
       (python +lsp +pyright)
       (rust +lsp)
       (sh +lsp)
       cc
       data
       emacs-lisp
       go
       ruby
       yaml

       :config
       (default +bindings)

       :development
       (experimental +modus-operandi)

       )

       ;; (org +roam2 +pretty +pomodoro +contacts)
       ;; (org +roam2 +pretty +pomodoro +gnuplot)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present +dragndrop)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present +dragndrop +jupyther)
       ;; (python +lsp +pyenv +pyright +tree-sitter)
       ;; (lsp +eglot +peek)
       ;; (spell +flyspell)
       ;; modeline
       ;; (ligatures +extra +fira +iosevka)
       ;; indent-guides
