;;; conf.d/_dired.el -*- lexical-binding: t; -*-

(defmacro %string (&rest BODY)
  `(mapconcat (quote symbol-name) (quote (,@BODY)) " "))

(use-package! dired
  :init
  (setq  -dired-ignore-extension
         (concat "--ignore=*."
                 (mapconcat (quote symbol-name)
                            (quote (zip gz)) " --ignore=*."))
         -dired-longopts
         (%string --block-size=1
                  --group-directories-first
                  --human-readable
                  --numeric-uid-gid
                  --ignore-backups
                  --color=never
                  --no-group))
  :custom
   (dired-listing-switches
    (concat -dired-ignore-extensions -dired-longopts)))

(use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t)

(map!
 "."     #'self-insert-command
 "H-."   #'dired-jump
 "H-."   #'dired-jump

 (:map dired-mode-map
       "/"   #'dired-mark-files-regexp
       (:prefix "h"
                "h" (cmd! (dired "~")))

       (:prefix ","
                ","   #'dired-unmark-all-marks)
       "."   #'dired-up-directory
       "["   #'dired-prev-marked-file
       "]"   #'dired-next-marked-file
       "~"   (cmd! dired "~")
       "r"   #'dired-do-rename-regexp
       "s-." #'dired-jump))
