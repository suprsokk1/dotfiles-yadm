;;; custom/vterm/init.el -*- lexical-binding: t; -*-

(when (modulep! +tmux)
  (after! vterm
    (setq vterm-shell "/bin/tmux")))
