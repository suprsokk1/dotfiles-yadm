;;; conf.d/_dired.el -*- lexical-binding: t; -*-

;; TODO integrated in DOOM
;; (use-package! treemacs-icons-dired
;;   :after dired
;;   :hook (dired-mode . treemacs-icons-dired-enable-once))


(map!
 "H-SPC /" #'dired-jump
 "s-SPC /" #'dired-jump
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


;; (setq-hook! ()
;; )

;; TODO override
;; (dired-maybe-insert-subdir)

;; (defmacro %string (&rest BODY)
;;   `(mapconcat
;;     (quote symbol-name)
;;     (quote (,@BODY)) " "))

;; (use-package! dired
;;   :custom
;;   ($dired-custom-enabled nil)
;;   ;; (dired-listing-switches (%string -af --group-directories-first --no-group))
;;   ;; (default:dired-listing-switches (%string -af)
;;   :config

;;    ;; (-dired-listing-switches
;;    ;;  (concat "--ignore=*."
;;    ;;          (%string --block-size=1
;;    ;;                   --group-directories-first
;;    ;;                   --human-readable
;;    ;;                   --numeric-uid-gid
;;    ;;                   --ignore-backups
;;    ;;                   --color=never
;;    ;;                   --no-group)
;;    ;;          (mapconcat (quote symbol-name)
;;    ;;                     (quote (zip gz)) " --ignore=*."))))


;;   (use-package! treemacs-icons-dired
;;     :hook (dired-mode . treemacs-icons-dired-enable-once))


;;   (map!
;;    "."   #'self-insert-command
;;    "H-." #'dired-jump
;;    "s-." #'dired-jump

;;    (:map dired-mode-map
;;          "/"   #'dired-mark-files-regexp
;;          (:prefix "h"
;;                   "h" (cmd! (dired "~")))

;;          (:prefix ","
;;                   ","   #'dired-unmark-all-marks)
;;          "."   #'dired-up-directory
;;          "["   #'dired-prev-marked-file
;;          "]"   #'dired-next-marked-file
;;          "~"   (cmd! dired "~")
;;          "r"   #'dired-do-rename-regexp
;;          "s-." #'dired-jump)))
