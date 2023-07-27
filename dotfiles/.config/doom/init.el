;;; init.el -*- lexical-binding: t; -*-
;; (setq $fonts '())
(set (quote NOERROR) t)
(set (quote query-all-font-backends) t)

(doom! :completion
       company
       vertico

       :ui
       doom
       hl-todo
       modeline
       ;; indent-guides
       treemacs
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
       (spell +flyspell)

       :term
       vterm

       :tools
       lsp
       magit
       direnv
       editorconfig
       lookup
       ansible
       (eval +overlay)
       (docker +lsp)

       :lang
       data
       emacs-lisp
       yaml
       (org +roam2)
       (dart +flutter)
       (python +lsp +pyenv +pipenv)
       (sh +lsp)
       (go +lsp)
       (cc +lsp)

       :config
       (default +bindings))
