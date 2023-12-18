;;; init.el -*- lexical-binding: t; -*-
;; (setq $fonts '())
(set (quote NOERROR) t)
(set (quote query-all-font-backends) t)

(doom! :completion
       company
       vertico

       :ui
       emoji
       ;; indent-guides
       hl-todo
       treemacs
       zen
       ;; (modeline +light)
       modeline
       (ligatures +extra +fira +iosevka)
       (popup +defaults)

       :editor
       multiple-cursors
       file-templates
       fold
       format                           ; auto format
       snippets

       ;; (evil +everywhere)

       :emacs
       dired
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
       direnv
       editorconfig
       lookup
       tmux
       debugger
       (eval +overlay)
       (docker +lsp)
       (lsp +eglot +peek)

       :lang
       data
       emacs-lisp
       yaml
       ;; (org +roam2)
       (org +roam2 +pretty)
       ;; (python +lsp +pyenv +pyright +tree-sitter)
       (python +lsp +pyenv)
       (sh +lsp)
       (go +lsp)
       (cc +lsp)
       (rust +lsp)

       :config
       (default +bindings))
