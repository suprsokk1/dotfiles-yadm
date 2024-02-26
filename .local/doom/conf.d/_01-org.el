;;; $DOOMDIR/conf.d/_org.el -*- lexical-binding: t; -*-

(defvar -org-babel-startup-block "_startup")

(quote
 ((after! org
    (remove-hook! org-mode-hook
      'doom--setq-display-line-numbers-mode-for-org-mode-h))

  (setq! org-mode-hook '(+lookup--init-org-mode-handlers-h
                         doom-disable-show-paren-mode-h
                         doom-disable-show-trailing-whitespace-h
                         +org-make-last-point-visible-h
                         org-appear-mode
                         org-fancy-priorities-mode
                         org-superstar-mode
                         toc-org-enable
                         org-babel-result-hide-spec
                         org-babel-hide-all-hashes
                         (cmd! (if (not (eq nil (buffer-file-name)))
                                   (progn
                                     (when (not (buffer-narrowed-p))
                                       (when (-by-buffer (get-buffer (buffer-name)))
                                         (org-babel-find-named-block -org-babel-startup-block)
                                         (org-babel-execute-src-block:async))))))
                         ))))

(defun -org-mode-hook ()
  (if (not (eq nil (buffer-file-name)))
      ;; file buffer
      (progn
        (when (not (buffer-narrowed-p))
          (when (-by-buffer (get-buffer (buffer-name)))
            (org-babel-find-named-block -org-babel-startup-block)
            (org-babel-execute-src-block:async)))))
  (setq-local display-line-numbers-mode -1))

;; (defun -org-mode-hook:around (func args)
;;   (message "%S" func)
;;   (apply func args))

;; (advice-add '-org-mode-hook :around #'-org-mode-hook:around)

;; (add-hook 'org-mode-hook #'-org-mode-hook)
;; ;; (add-hook 'org- #'-org-mode-hook)

(map! :map org-agenda-mode-map "" #'org-agenda-goto) ;original: org-agenda-switch-to

(map! :map org-agenda-mode-map "RET" #'org-agenda-goto) ;original: org-agenda-switch-to

(map!
 "s-a" (cmd! (org-agenda nil "t"))
 :prefix "s-SPC"
 "s-i" #'org-clock-in          ;FIXME
 "s-o" #'org-clock-out
 "s-a" (cmd! (org-agenda nil "t")))

(progn
  ;; https://orgmode.org/manual/Breaking-Down-Tasks.html
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-todo-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo))

(setq!
 ;; original modified with `%a'
 org-roam-capture-templates (quote (("d" "default" plain "%?" :target
                                     (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+begin_src\n%a\n#+end_src\n")
                                     :unnarrowed t)))

 org-babel-library-of-babel (quote ((foo "sh" "< /dev/null"
                                     ((:results . "replace drawer")
                                      (:exports . ""))
                                     "" "foo" 122 "(ref:%s)")))

 so-long-minor-modes (quote (global-display-line-numbers-mode display-line-numbers-mode flymake-mode flyspell-mode glasses-mode goto-address-mode goto-address-prog-mode hi-lock-mode highlight-changes-mode hl-line-mode linum-mode nlinum-mode prettify-symbols-mode visual-line-mode whitespace-mode diff-hl-amend-mode diff-hl-flydiff-mode diff-hl-mode dtrt-indent-mode flycheck-mode hl-sexp-mode idle-highlight-mode rainbow-delimiters-mode smartparens-mode smartparens-strict-mode spell-fu-mode eldoc-mode highlight-numbers-mode better-jumper-local-mode ws-butler-mode auto-composition-mode undo-tree-mode highlight-indent-guides-mode hl-fill-column-mode flycheck-mode smartparens-mode smartparens-strict-mode))

 org-babel-default-header-args       (quote ((:results . "drawer replace")))

 ;; org-babel-default-header-args:elisp (quote ((:results . "raw replace")
 ;;                                             (:wrap . "example emacs-lisp")))

 ;; org-babel-default-header-args:shell (quote ((:var . "ORG=(file!)")))

 org-agenda-files              (expand-file-name "agenda.lst" doom-user-dir)

 +org-capture-todo-file        (expand-file-name
                                "yadm/TODO/README.org"
                                (or
                                 (getenv "XDG_CONFIG_HOME")
                                 (expand-file-name "~/.config"))))

(setq org-emphasis-alist
      '(("*" org-emphasis-bold)
        ("/" org-emphasis-italic)
        ("_" org-emphasis-underline)
        ("=" org-verbatim verbatim)
        ("~" org-code verbatim)
        ("+" my-org-emphasis-strike-through)))


;; (("t" "Personal todo" entry
;;   (file+headline +org-capture-todo-file "Inbox")
;;   "* [ ] %?\n%i\n%a" :prepend t)
;;  ("n" "Personal notes" entry
;;   (file+headline +org-capture-notes-file "Inbox")
;;   "* %u %?\n%i\n%a" :prepend t)
;;  ("j" "Journal" entry
;;   (file+olp+datetree +org-capture-journal-file)
;;   "* %U %?\n%i\n%a" :prepend t)
;;  ("p" "Templates for projects")
;;  ("pt" "Project-local todo" entry
;;   (file+headline +org-capture-project-todo-file "Inbox")
;;   "* TODO %?\n%i\n%a" :prepend t)
;;  ("pn" "Project-local notes" entry
;;   (file+headline +org-capture-project-notes-file "Inbox")
;;   "* %U %?\n%i\n%a" :prepend t)
;;  ("pc" "Project-local changelog" entry
;;   (file+headline +org-capture-project-changelog-file "Unreleased")
;;   "* %U %?\n%i\n%a" :prepend t)
;;  ("o" "Centralized templates for projects")
;;  ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
;;  ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
;;  ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))

;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "|" "DONE(D)" "CANCEL(C)")
;;         (sequence "MEET(m)" "|" "MET(M)")
;;         (sequence "STUDY(s)" "|" "STUDIED(S)")
;;         (sequence "WRITE(w)" "|" "WROTE(W)")))

;; (setq org-todo-keyword-faces
;;       '(("MEET" . (:inherit (bold org-todo)))
;;         ("STUDY" . (:inherit (warning org-todo)))
;;         ("WRITE" . (:inherit (shadow org-todo)))))

;; (setq org-emphasis-alist
;;       '(("*" my-org-emphasis-bold)
;;         ("/" my-org-emphasis-italic)
;;         ("_" my-org-emphasis-underline)
;;         ("=" org-verbatim verbatim)
;;         ("~" org-code verbatim)
;;         ("+" my-org-emphasis-strike-through)))
