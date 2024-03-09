;; -*- no-byte-compile: t; -*-
;;; custom/babel/packages.el

(when (modulep! +tmux)
  (package! ob-tmux))
