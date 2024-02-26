;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-
(doom! :completion
       company
       vertico

       :ui
       emoji
       ;; indent-guides
       hl-todo
       treemacs
       zen
       (modeline +light)
       ;; modeline
       ;; (ligatures +extra +fira +iosevka)
       (popup +defaults)

       :editor
       multiple-cursors
       file-templates
       fold
       format                           ; auto format
       snippets
       ;; (evil +everywhere)

       :emacs
       (dired +icons)
       undo
       vc

       :checkers
       syntax
       ;; (spell +flyspell)

       :term
       vterm

       :tools
       ansible
       magit
       ;; direnv
       editorconfig
       lookup
       tmux
       debugger
       (eval +overlay)
       (docker +lsp)
       ;; (lsp +eglot +peek)
       (lsp +eglot)

       :lang
       data
       emacs-lisp
       yaml
       ;; rest
       ;; rst
       ;; (org +roam2)

       (org +roam2 +pretty +pomodoro)

       ;; (org +roam2 +pretty +pomodoro +contacts)
       ;; (org +roam2 +pretty +pomodoro +gnuplot)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present +dragndrop)
       ;; (org +roam2 +pretty +pomodoro +gnuplot +pandoc +hugo +present +dragndrop +jupyther)
       ;; (python +lsp +pyenv +pyright +tree-sitter)

       (python +lsp +pyright)
       (sh +lsp)
       (go +lsp)
       (cc +lsp)
       (ruby +lsp)
       (rust +lsp)

       :config
       (default +bindings))
