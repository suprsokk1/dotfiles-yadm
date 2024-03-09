;;; custom/babel/init.el -*- lexical-binding: t; -*-

(when (modulep! +args)
  (after! org
    (setq org-babel-default-header-args
          (quote ((:session . "none") (:results . "replace drawer") (:exports . "code")
                  (:cache . "no") (:noweb . "yes") (:hlines . "no") (:tangle . "no")))

          org-babel-default-header-args:sh
          (quote ((:session . "none") (:results . "replace drawer") (:exports . "code")
                  (:cache . "no") (:noweb . "yes") (:hlines . "no") (:tangle . "no"))))))

(when (modulep! +ansi)
  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi))
