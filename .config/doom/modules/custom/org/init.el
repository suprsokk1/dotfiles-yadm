;;; custom/org/init.el -*- lexical-binding: t; -*-
(when (modulep! +orgzly)
  (message "TODO +orgzly"))

(after! org
  (setq org-log-state-notes-into-drawer t))
