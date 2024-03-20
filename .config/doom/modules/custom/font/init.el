;;; custom/font/init.el -*- lexical-binding: t; -*-

(if (and (modulep! :ui treemacs) (modulep! +san-francisco))
    (eval
     (let ((DEFAULT_FONT "San Francisco Display"))
       `(use-package! treemacs
          :custom
          (hl-line-mode 1)
          (hide-mode-line-mode 1)
          (mode-line-format nil)

          :custom-face
          (custom-treemacs-face
           ((t (:family ,DEFAULT_FONT
                :foreground-color nil))))

          (treemacs-root-face
           ((t (:family ,DEFAULT_FONT
                :height 1.1
                :weight book
                :underline nil))))

          (treemacs-file-face
           ((t :family ,DEFAULT_FONT)))

          (treemacs-directory-face
           ((t (:family ,DEFAULT_FONT))))

          (treemacs-hl-line-face
           ((t (:inherit hl-line))))

          ))))
