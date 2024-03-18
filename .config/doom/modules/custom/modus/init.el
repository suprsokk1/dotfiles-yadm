;;; custom/modus/init.el -*- lexical-binding: t; -*-
;; 0 = thin
;; 1 = ultralight
;; 2 = ultra-light
;; 3 = extralight
;; 4 = extra-light
;; 5 = light
;; 6 = semilight
;; 7 = semi-light
;; 8 = demilight
;; 9 = normal
;; : = regular
;; ; = book
;; < = medium
;; = = semibold
;; > = semi-bold
;; ? = demibold
;; @ = demi-bold
;; A = bold
;; B = extrabold
;; C = extra-bold
;; D = ultrabold
;; E = ultra-bold
;; F = heavy
;; G = black
;; H = ultra-heavy
;; I = ultraheavy

(setq  doom-theme 'modus-vivendi

       modus-themes-headings
       '((1 . (variable-pitch 1.5))
         (2 . (semibold))
         (t . t))    ; default style for all other levels

       ;; Make line numbers less intense
       modus-themes-common-palette-overrides
       '((fg-line-number-inactive "gray50")
         (fg-line-number-active fg-main)
         (bg-line-number-inactive unspecified)
         (bg-line-number-active unspecified)))

(cond
   ((modulep! +iosevka)

    ;; Main typeface
    (set-face-attribute 'default nil
                        :family "Iosevka Mono"
                        :height 110)

    ;; Proportionately spaced typeface
    (set-face-attribute 'variable-pitch nil
                        :family "Iosevka"
                        :height 1.0)

    ;; Monospaced typeface
    (set-face-attribute 'fixed-pitch nil
                        :family "Iosevka Mono"
                        :height 1.5))

   ((modulep! +ubuntu)

    ;; Main typeface
    (set-face-attribute 'default nil
                        :family "Ubuntu Mono"
                        :height 110)

    ;; Proportionately spaced typeface
    (set-face-attribute 'variable-pitch nil
                        :family "Ubuntu"
                        :height 1.0)

    ;; Monospaced typeface
    (set-face-attribute 'fixed-pitch nil
                        :family "Ubuntu Mono"
                        :height 1.5))

   ((modulep! +dejavu)

    ;; Main typeface
    (set-face-attribute 'default nil
                        :family "DejaVu Sans Mono"
                        :height 110)

    ;; Proportionately spaced typeface
    (set-face-attribute 'variable-pitch nil
                        :family "DejaVu Serif"
                        :height 1.0)

    ;; Monospaced typeface
    (set-face-attribute 'fixed-pitch nil
                        :family "DejaVu Sans Mono"
                        :height 1.5))
   (t ))


(after! modus-themes
  (cond
   ((modulep! +tinted)
    (setq modus-themes-to-toggle (quote (modus-operandi-tinted modus-vivendi-tinted))))
   ((modulep! +deuteranopia)
    (setq modus-themes-to-toggle (quote (modus-operandi-deuteranopia modus-vivendi-deuteranopia))))
   ((modulep! +tritanopia)
    (setq modus-themes-to-toggle (quote (modus-operandi-tritanopia modus-vivendi-tritanopia))))
   (t (setq modus-themes-to-toggle (quote (modus-operandi modus-vivendi))))))
