;;; conf.d/_modus-themes.el -*- lexical-binding: t; -*-

(use-package! modus-themes
  :ensure t
  :load-path "~/src/modus-themes"
  :config
  ;; (modus-themes-select 'modus-vivendi-tinted)
  (modus-themes-select 'modus-vivendi)
  :custom

  (org-hide-emphasis-markers t)

  (hl-line-mode nil)
  (global-hl-line-mode nil)
  (modus-themes-custom-auto-reload t)
  (modus-themes-variable-pitch-ui nil)
  (modus-themes-mixed-fonts t)

  ;; (modus-themes-mixed-fonts nil)
  ;; (modus-themes-variable-pitch-ui t)

  (modus-themes-variable-pitch-ui t)

  ;; (modus-themes-variable-pitch-ui nil)

  (modus-themes-headings (quote
                          (
                           (1 . (variable-pitch 1.2))
                           (2 . (1.)
                              )
                           (agenda-date . (1.3))
                           (agenda-structure . (variable-pitch light 1.8))
                           (t . (1.1)))))

  (modus-themes-common-palette-overrides
   '(

     ;; (prose-done fg-dim)

     (prose-done fg-dim)

     (prose-todo fg-dim)

     (prose-strt fg-dim)

     (fg-heading-1 fg-dim)

     (fg-heading-2 fg-dim)

     (fg-heading-3 fg-dim)

     (date-deadline red-warmer)

     (date-weekday cyan-cooler)

     (prose-done fg-dim)

     (date-scheduled magenta-cooler)

     (date-event magenta-warmer)

     (date-now yellow-warmer)

     (date-weekend blue-faint)

     (bg-line-number-active unspecified)

     )
   )


  (modus-vivendi-palette-overrides
   '(
     (bg-line-number-inactive "gray6")
     (border-mode-line-active unspecified)
     (border-mode-line-inactive unspecified)
     (date-common cyan) ; default value (for timestamps and more)
     (date-holiday blue) ; for M-x calendar
     (fg-line-number-active "gray80")
     (fringe "gray6")
     ))
   ;; (fg-line-number-active unspecified)
   ;; (fg-line-number-inactive unspecified)
   ;; (fringe unspecified)

   (modus-operandi-palette-overrides (quote
                                      ((fg-main "#333333")
                                       (comment red-faint)
                                       (keyword cyan-cooler))))


   (modus-themes-to-toggle (quote (modus-operandi-tinted modus-vivendi-tinted))))
