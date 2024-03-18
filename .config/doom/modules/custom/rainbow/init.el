;;; custom/rainbow/init.el -*- lexical-binding: t; -*-

(if (modulep! +delimiters)
    (cond
     ((modulep! +elisp)
      (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode-enable))
     ((modulep! +python)
      (add-hook 'python-mode-hook 'rainbow-delimiters-mode-enable)))
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable))
