;;; init.el -*- lexical-binding: t; -*-
;; (setq $fonts '())
(set (quote NOERROR) t)
(set (quote query-all-font-backends) t)

(doom! :completion
       company
       vertico

       :ui
       hl-todo
       modeline
       treemacs
       zen
       (popup +defaults)

       :editor
       multiple-cursors
       file-templates
       fold snippets
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
       (eval +overlay)
       (docker +lsp)
       (lsp +eglot +peek)

       :lang
       data
       emacs-lisp
       yaml

       (org +roam2)
       (dart +flutter)
       (python +lsp +pyenv +pyright +tree-sitter)
       (sh +lsp)
       (go +lsp)
       (nim +lsp)
       (cc +lsp)
       (rust +lsp)

       :config
       (default +bindings))
