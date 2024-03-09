;;; custom/modus/init.el -*- lexical-binding: t; -*-
(setq  doom-theme 'modus-vivendi)

(after! modus-themes
  (cond
   ((modulep! +tinted)
    (setq modus-themes-to-toggle (quote (modus-operandi-tinted modus-vivendi-tinted))))
   ((modulep! +deuteranopia)
    (setq modus-themes-to-toggle (quote (modus-operandi-deuteranopia modus-vivendi-deuteranopia))))
   ((modulep! +tritanopia)
    (setq modus-themes-to-toggle (quote (modus-operandi-tritanopia modus-vivendi-tritanopia))))
   (t (setq modus-themes-to-toggle (quote (modus-operandi modus-vivendi))))))
