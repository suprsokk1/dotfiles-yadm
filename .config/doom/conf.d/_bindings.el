;;; $DOOMDIR/conf.d/_bindings.el -*- lexical-binding: t; -*-

(map!
 "H-SPC y y"       #'+default/yank-buffer-path-relative-to-project
 "H-SPC y Y"       #'+default/yank-buffer-contents
 "<f12>"           #'flycheck-list-errors
 "<f5>"            #'call-last-kbd-macro
 "C-."             #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>"         #'flycheck-next-error
 "C-c SPC SPC"     #'-refresh
 "H-."             #'dired-jump
 "H-/"             #'+default/search-buffer
 "H-0"             #'balance-windows
 ;; "H-8"             #'-mark-all-like-this
 ;; "s-8"             #'(cmd! (isearch-forward-symbol-at-point)(occur))
 "s-8"             (lambda (&rest BODY) (interactive)(isearch-forward-symbol-at-point)(apply (quote occur) BODY))
 "H-;"             #'company-yasnippet
 "H-<backspace>"   #'delete-pair
 "H-<down>"        #'-clone-line-down "s-<down>"        #'-clone-line-down
 "H-<return>"      #'bookmark-jump
 "H-<up>"          #'-clone-line-up "s-<up>"            #'-clone-line-up
 "H-M-0"           #'balance-windows-area
 "H-M-["           #'winner-undo
 "H-M-]"           #'winner-redo
 "H-M-k"           #'doom/kill-this-buffer-in-all-windows
 "H-M-l"           #'toggle-truncate-lines
 "H-M-n"           #'split-window-vertically
 "H-M-p"           #'projectile-switch-project
 "H-["             #'undo
 "H-]"             #'undo-redo
 "H-g"             #'magit-status
 "H-i f"           #'+default/insert-file-path
 "H-k"             #'delete-window
 "H-l"             #'display-line-numbers-mode
 "H-m"             #'+zen/toggle-fullscreen
 "H-n"             #'split-window-horizontally
 "H-p"             #'projectile-find-file
 "H-{"             #'flycheck-previous-error
 "H-}"             #'flycheck-next-error
 "M-["             #'previous-error
 "M-]"             #'next-error
 "M-s-0"           #'balance-windows-area
 "M-s-<return>"    #'org-roam-node-find
 "M-s-["           #'winner-undo
 "M-s-]"           #'winner-redo
 "M-s-k"           #'doom/kill-this-buffer-in-all-windows
 "M-s-l"           #'toggle-truncate-lines
 "M-s-n"           #'split-window-vertically
 "s-."             #'dired-jump
 "s-/"             #'+default/search-buffer
 "s-0"             #'balance-windows
 ;; "s-8"             #'-mark-all-like-this
 "s-;"             #'company-yasnippet
 "s-<backspace>"   #'delete-pair
 "s-<return>"      #'bookmark-jump
 "s-M-k"           #'doom/kill-this-buffer-in-all-windows
 "s-M-p"           #'projectile-switch-project

 "s-["             'undo
 "s-]"             'undo-redo
 "s-g"             #'magit-status
 "s-i f"           #'+default/insert-file-path
 "s-k"             #'delete-window
 "s-l"             #'display-line-numbers-mode
 "s-m s-m"         #'mc/mark-all-like-this
 "s-n"             #'split-window-horizontally
 "s-p"             #'projectile-find-file

 (:prefix "s-SPC"
          "m"         '+zen/toggle-fullscreen
          "SPC"       #'org-roam-node-find
          "."         #'dired-jump
          "TAB"       #'(cmd! (find-file initial-buffer-choice))
          "["         #'mc/edit-beginnings-of-lines
          "]"         #'mc/edit-enda-of-lines
          "a"         #'mc/edit-beginnings-of-lines
          "b"         #'doom-big-font-mode
          "c"         #'doom/goto-private-config-file
          "e"         #'mc/edit-enda-of-lines
          "h"         #'(cmd! (dired "~"))
          "n"         #'org-capture
          "q"         #'delete-other-windows
          "r"         nil
          "s"         #'org-narrow-to-subtree
          "s-SPC"     #'-refresh
          "s-q"       #'delete-other-frames
          "x"         #'doom/open-scratch-buffer
          "~"         #'(cmd! (dired "~")))

 (:prefix "H-SPC"
          "."         #'dired-jump
          "H-SPC"     #'-refresh
          "H-q"       #'delete-other-frames
          "TAB"       #'(cmd! (find-file initial-buffer-choice))
          "["         #'mc/edit-beginnings-of-lines
          "]"         #'mc/edit-enda-of-lines
          "a"         #'mc/edit-beginnings-of-lines
          "b"         #'doom-big-font-mode
          "c"         #'doom/goto-private-config-file
          "e"         #'mc/edit-enda-of-lines
          "h"         #'(cmd! (dired "~"))
          "l"         #'-open-library-of-babel
          "m"         #'mc/mark-all-like-this ;FIXME
          "n"         #'org-capture
          "q"         #'delete-other-windows
          "r"         nil
          "s"         #'org-narrow-to-subtree
          "x"         #'doom/open-scratch-buffer
          "~"         #'(cmd! (dired "~"))

          )
 )
(map!
 "M-o l" #'highlight-lines-matching-regexp
 "M-o r" #'highlight-regexp
 "M-o w" #'highlight-phrase)

(map!
 :map dired-mode-map
 "]"   #'dired-next-marked-file
 "["   #'dired-prev-marked-file
 "."  #'dired-up-directory

 ("," nil
  :prefix ","
  "," #'dired-unmark-all-marks)

 ;; ("." nil
 ;;  :prefix "."
 ;;  "." #'dired-up-directory)

 ("/" nil
  :prefix "/"
  "/" #'dired-mark-files-regexp
  "." #'dired-mark-files-containing-regexp))

(map!

 "<f12>"           #'flycheck-list-errors
 "<f5>"            #'call-last-kbd-macro
 "C-."             #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>"         #'flycheck-next-error
 "C-c SPC SPC"     #'-refresh
 "H-."             #'dired-jump
 "H-/"             #'+default/search-buffer
 "H-0"             #'balance-windows
 ;; "H-8"             #'-mark-all-like-this
 ;; "s-8"             #'(cmd! (isearch-forward-symbol-at-point)(occur))
 "s-8"             (lambda (&rest BODY) (interactive)(isearch-forward-symbol-at-point)(apply (quote occur) BODY))
 "H-;"             #'company-yasnippet
 "H-<backspace>"   #'delete-pair
 "H-<down>"        #'-clone-line-down "s-<down>"        #'-clone-line-down
 "H-<return>"      #'bookmark-jump
 "H-<up>"          #'-clone-line-up "s-<up>"            #'-clone-line-up
 "H-M-0"           #'balance-windows-area
 "H-M-["           #'winner-undo
 "H-M-]"           #'winner-redo
 "H-M-k"           #'doom/kill-this-buffer-in-all-windows
 "H-M-l"           #'toggle-truncate-lines
 "H-M-n"           #'split-window-vertically
 "H-M-p"           #'projectile-switch-project
 "H-["             #'undo
 "H-]"             #'undo-redo
 "H-g"             #'magit-status
 "H-i f"           #'+default/insert-file-path
 "H-k"             #'delete-window
 "H-l"             #'display-line-numbers-mode
 "H-m"             #'+zen/toggle-fullscreen
 "H-n"             #'split-window-horizontally
 "H-p"             #'projectile-find-file
 "H-{"             #'flycheck-previous-error
 "H-}"             #'flycheck-next-error
 "M-["             #'previous-error
 "M-]"             #'next-error
 "M-s-0"           #'balance-windows-area
 "M-s-<return>"    #'org-roam-node-find
 "M-s-["           #'winner-undo
 "M-s-]"           #'winner-redo
 "M-s-k"           #'doom/kill-this-buffer-in-all-windows
 "M-s-l"           #'toggle-truncate-lines
 "M-s-n"           #'split-window-vertically
 "s-."             #'dired-jump
 "s-/"             #'+default/search-buffer
 "s-0"             #'balance-windows
 ;; "s-8"             #'-mark-all-like-this
 "s-;"             #'company-yasnippet
 "s-<backspace>"   #'delete-pair
 "s-<return>"      #'bookmark-jump
 "s-M-k"           #'doom/kill-this-buffer-in-all-windows
 "s-M-p"           #'projectile-switch-project

 "s-["             'undo
 "s-]"             'undo-redo
 "s-g"             #'magit-status
 "s-i f"           #'+default/insert-file-path
 "s-k"             #'delete-window
 "s-l"             #'display-line-numbers-mode
 "s-m s-m"         #'mc/mark-all-like-this
 "s-n"             #'split-window-horizontally
 "s-p"             #'projectile-find-file

 (:prefix "s-SPC"
          "m"         '+zen/toggle-fullscreen
          "SPC"       #'org-roam-node-find
          "."         #'dired-jump
          "TAB"       #'(cmd! (find-file initial-buffer-choice))
          "["         #'mc/edit-beginnings-of-lines
          "]"         #'mc/edit-enda-of-lines
          "a"         #'mc/edit-beginnings-of-lines
          "b"         #'doom-big-font-mode
          "c"         #'doom/goto-private-config-file
          "e"         #'mc/edit-enda-of-lines
          "h"         #'(cmd! (dired "~"))
          "n"         #'org-capture
          "q"         #'delete-other-windows
          "r"         nil
          "s"         #'org-narrow-to-subtree
          "s-SPC"     #'-refresh
          "s-q"       #'delete-other-frames
          "x"         #'doom/open-scratch-buffer
          "~"         #'(cmd! (dired "~")))

 (:prefix "H-SPC"
          "."         #'dired-jump
          "H-SPC"     #'-refresh
          "H-q"       #'delete-other-frames
          "TAB"       #'(cmd! (find-file initial-buffer-choice))
          "["         #'mc/edit-beginnings-of-lines
          "]"         #'mc/edit-enda-of-lines
          "a"         #'mc/edit-beginnings-of-lines
          "b"         #'doom-big-font-mode
          "c"         #'doom/goto-private-config-file
          "e"         #'mc/edit-enda-of-lines
          "h"         #'(cmd! (dired "~"))
          "l"         #'-open-library-of-babel
          "m"         #'mc/mark-all-like-this ;FIXME
          "n"         #'org-capture
          "q"         #'delete-other-windows
          "r"         nil
          "s"         #'org-narrow-to-subtree
          "x"         #'doom/open-scratch-buffer
          "~"         #'(cmd! (dired "~"))

          )
 )

(map!
 "H-r" #'consult-buffer
 "s-r" #'consult-buffer
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "H-\\"   #'+vterm/toggle
 "s-\\"   #'+vterm/toggle
 "M-o l"  #'highlight-lines-matching-regexp
 "M-o r"  #'highlight-regexp
 "M-o w"  #'highlight-phrase
 "s-q"    #'windmove-left
 "s-e"    #'windmove-right
 "s-w"    #'windmove-up
 "s-s"    #'windmove-down
 "H-q"    #'windmove-left
 "H-e"    #'windmove-right
 "H-w"    #'windmove-up
 "H-s"    #'windmove-down
 "M-s-q"  #'windmove-swap-states-left
 "M-H-q"  #'windmove-swap-states-left
 "M-s-e"  #'windmove-swap-states-right
 "M-H-e"  #'windmove-swap-states-right
 "M-s-w"  #'windmove-swap-states-up
 "M-H-w"  #'windmove-swap-states-up
 "M-s-s"  #'windmove-swap-states-down
 "M-H-s"  #'windmove-swap-states-down
 "C-c m m" 'mc/mark-all-like-this
 )
