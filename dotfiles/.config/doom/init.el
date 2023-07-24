;;; init.el -*- lexical-binding: t; -*-
;; (setq $fonts '())
(set (quote NOERROR) t)
(set (quote query-all-font-backends) t)

(doom!  :completion
        company
        vertico

        :ui
        doom
        hl-todo
        modeline
        ;; indent-guides
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

;; (set (quote UID) (string-to-number (string-trim-right (shell-command-to-string "id -u"))))
;; (set (quote HOME) (getenv "HOME"))
;; (set (quote PATH) (mapconcat #'princ
;;                              (list "/usr/bin"
;;                                    "/usr/sbin"
;;                                    "/bin"{
;;                                    "/sbin"
;;                                    "/usr/local/bin/"
;;                                    "/usr/local/sbin/") ":"))
;; (setq %h HOME %p PATH %u UID)

;; (set (quote XDG_RUNTIME_DIR) (or (getenv "XDG_RUNTIME_DIR")
;;                                  (format "/run/user/" %d)))
;; (set (quote XDG_CONFIG_DIR) (or (getenv "XDG_CONFIG_DIR")
;;                                 (format "%s/.config" HOME)))

;; (setenv "PATH" (mapconcat  #'princ (list
;;                                     (format "%s/shims" HOME)
;;                                     (format "%s/go/bin" HOME)
;;                                     PATH
;;                                     (format "%s/.cargo/bin" HOME)
;;                                     (format "%s/.local/bin" HOME)
;;                                     (format "/home/linuxbrew/.linuxbrew" HOME))  ":"))
