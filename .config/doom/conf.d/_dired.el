;;; conf.d/_dired.el -*- lexical-binding: t; -*-

(defmacro %string (&rest BODY)
  `(mapconcat (quote symbol-name) (quote (,@BODY)) " "))

(use-package! dired
  :custom
  (-dired-ignore-extension
   (concat "--ignore=*."
           (mapconcat (quote symbol-name)
                      (quote (zip gz)) " --ignore=*.")))
  (-dired-longopts
   (%string --block-size=1
            --group-directories-first
            --human-readable
            --numeric-uid-gid
            --ignore-backups
            --color=never
            --no-group))

   (dired-listing-switches
    (concat -dired-ignore-extensions -dired-longopts))
  )

(use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t)
