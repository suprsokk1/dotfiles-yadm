;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-
(doom! :completion
       company
       vertico

       :ui
       ;; (modeline +light)
       modeline
       (popup +defaults)
       ;; (vc-gutter +diff-hl +pretty)
       (vc-gutter +pretty)
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

       :custom
       (autostart +treemacs)
       (babel +args +ansi +tmux)
       (bindings +default)
       ;; (modus +tinted +ubuntu)
       ;; (modus +tinted +ubuntu)
       (font +san-francisco)
       ;; (modus +tinted)
       (modus +tinted +iosevka)
       ;; (modus +deuteranopia)
       ;; (modus +tritanopia)
       (vterm +tmux)
       bindings
       mmm
       modus
       org
       rainbow
       sway
       systemd
       )
