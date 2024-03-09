;;; custom/rainbow/init.el -*- lexical-binding: t; -*-



(if (modulep! +delimiters)
    (cond
     ((modulep! +python)
      (add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable)))
  (t (add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable))
 )
