;;; config.el --- Description -*- lexical-binding: t; -*-

(when (modulep! +header-format)
  (setq header-line-format (quote (:eval (-header-title-format)))))

(when (modulep! +frame-format)
  (setq frame-title-format (quote (:eval (-frame-title-format)))))

(when (modulep! +frame-format)
  (after! consult
    (setq!
     consult-buffer-sources (quote
                             (consult--source-recent-file
                              consult--source-hidden-buffer
                              consult--source-modified-buffer
                              consult--source-buffer
                              consult--source-file-register
                              consult--source-bookmark
                              consult--source-project-buffer-hidden
                              consult--source-project-recent-file-hidden)))))

(when (modulep! +modus-vivendi)
  (after! modus-themes
    (modus-themes-select 'modus-vivendi)))

(when (modulep! +modus-operandi)
  (after! modus-themes
    (modus-themes-select 'modus-operandi)))

(setq! -generic-advice:buffer-save:is-file
       (quote (make-symbolic-link (buffer-file-name)
               (HOME "emacs.buffer-save") t)))

;; (rx ?# ?< (+ (not ?>)))

(after! company
  )

(map! :mode messages "M-RET" :desc "TODO" (cmd! ))
(map! :map sh-mode-map "M-RET" (cmd! (if (string-match (rx "/___" (+ upper) "__") (buffer-file-name))
                                         ;; TODO
                                         )))

(advice-add '+lookup/definition :around #'advice:after:+lookup/definition)
(advice-add 'save-buffer :around '-generic-advice)
(advice-add 'python-shell-send-file :around '-generic-advice)

;; (setenv "PYENV_HOME" )
;; (advice-remove 'save-buffer #'-generic-advice)
;; (save-buffer)
;; (advice-add '-header-title-format :around #')
;; (advice-add '-frame-title-format :around #')
;;; config.el ends here
