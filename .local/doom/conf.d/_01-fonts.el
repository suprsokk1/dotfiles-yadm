;;; conf.d/_fonts.el -*- lexical-binding: t; -*-

;; TODO generate

(defface my-org-emphasis-italic
  '((default :inherit italic)
    (((class color) (min-colors 88) (background light))
     :foreground "#005e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#44bc44"))
  "My italic emphasis for Org.")

(defface my-org-emphasis-underline
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org.")

(defface my-org-block
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org.")


;; (custom-set-faces
;;  ;; '(default                      ((t (:family "Iosevka" :size 15))))

;;  ;; '(default                         ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight normal :height 103 :width normal :spacing 100))))

;;  ;; '(default ((t (:family "Ubuntu Nerd Font Mono" :size 15 :foundry "DAMA" :slant normal :weight light :height 158 :width normal :spacing 100 :spacing 90 ))))

;;  ;; '(default ((t (:family "Ubuntu Nerd Font Mono"
;;  ;;                :size 15
;;  ;;                :foundry "DAMA"
;;  ;;                :slant normal
;;  ;;                :weight light
;;  ;;                :height 158
;;  ;;                :width normal
;;  ;;                :spacing 110
;;  ;;                ))))

;;  ;; '(default                         ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight normal :height 103 :width normal :spacing 100))))

;;  ;; '(default                      ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight normal :height 103 :width normal))))

;;  '(org-priority-highest            ((t (:family "Iosevka" :size 15))))

;;  '(org-priority-lowest             ((t (:family "Iosevka" :size 15))))

;;  '(line-number             ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))

;;  ;; '(org-block                    ((t (:family "Iosevka" :size 15))))

;;  '(org-block                       ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))
;;  '(org-block-begin-line            ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))
;;  '(org-block-end-line              ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))

;;  '(org-emphasis-italic             ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))
;;  '(org-emphasis-underline          ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))
;;  '(org-emphasis-bold               ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight thin :height 103 :width normal))))

;;  '(org-special-keyword               ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight normal :height 103 :width normal))))

;;  '(org-todo               ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight bold :height 103 :width normal))))

;;  ;; '(org-level-1                  ((t (:family "Iosevka" :size 15))))

;;  '(org-level-1                     ((t (:family "Iosevka Custom" :size 15 :foundry "UKWN" :slant normal :weight normal :height 103 :width normal))))

;;  '(rainbow-delimiters-depth-1-face ((t (:foreground "gray"))))
;;  '(rainbow-delimiters-depth-1-face ((t (:foreground "gray"))))

;;  ;; '(org-level-1                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight light :height 140 :width normal))))
;;  ;; '(org-level-2                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight light :height 140 :width normal))))
;;  ;; '(org-level-3                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight light :height 140 :width normal))))
;;  ;; '(org-level-5                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight ultra-light :height 140 :width normal))))
;;  ;; '(org-level-6                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight ultra-light :height 140 :width normal))))
;;  ;; '(org-level-7                  ((t (:family "San Francisco Display" :foundry "APPL" :slant normal :weight ultra-light :height 140 :width normal))))

;;  )


;; ;; (custom-set-faces (quote (default ((t (:weight extralight))))))


;; (defface my-org-default
;;   '((default :inherit italic)
;;     (((class color) (min-colors 88) (background light))
;;      :foreground "#005e00")
;;     (((class color) (min-colors 88) (background dark))
;;      :foreground "#44bc44"))
;;   "My italic emphasis for Org.")


;; (quote (let ((foo (mapcar
;;                    (lambda (x) `(quote (,x ((t (:inherit my-org-default))))))
;;                    (make-symbols! (grep! (rx bol "org" (* any) eol)
;;                                          (mapconcat #'symbol-name (face-list) "\n"))))))
;;         (eval `(custom-set-faces ,@foo))))


;; (let ((bar (mapcar
;;             (lambda (x) `(quote (,x ((t (:weight extralight))))))
;;             (face-list))))
;;   (eval `(custom-set-faces ,@bar)))


;; (defface iosevka-custom
;;   '((default :family "Iosevka Custom")
;;      :size 15
;;      :foundry "UKWN"
;;      :slant normal
;;      :weight extra-light
;;      :height 103
;;      :width normal)))


(defface iosevka-custom
  '((default :family "Iosevka Custom" :foundry "UKWN" :height 103 :width normal))
  "Iosevka Custom.")


(defface extralight
  '((default :weight extralight))
  ":weight extralight")


(defface default
  '((default :weight extralight))
  ":weight extralight")



(custom-set-faces
 ;; '(default ((t (:inherit iosevka-custom-extra-light
 ;;                :size 15))))

 '(org-priority-highest            ((t (:inherit default))))

 '(org-priority-lowest             ((t (:inherit default))))

 '(line-number                     ((t (:inherit default))))

 '(org-block                       ((t (:inherit default))))
 '(org-block-begin-line            ((t (:inherit default))))
 '(org-block-end-line              ((t (:inherit default))))

 '(org-emphasis-italic             ((t (:inherit default))))
 '(org-emphasis-underline          ((t (:inherit default))))
 '(org-emphasis-bold               ((t (:inherit default))))

 '(org-special-keyword             ((t (:inherit default))))

 '(org-todo                        ((t (:inherit default))))

 '(org-level-1                     ((t (:inherit default))))

 '(org-level-2                     ((t (:inherit org-level-1))))
 '(org-level-3                     ((t (:inherit org-level-1))))
 '(org-level-4                     ((t (:inherit org-level-1))))
 '(org-level-5                     ((t (:inherit org-level-1))))
 '(org-level-6                     ((t (:inherit org-level-1))))
 '(org-level-7                     ((t (:inherit org-level-1))))
 '(org-level-8                     ((t (:inherit org-level-1))))
 '(org-level-9                     ((t (:inherit org-level-1))))

 '(rainbow-delimiters-depth-1-face ((t (:foreground "gray"
                                        :inherit default))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-depth-1-face))))

 )

(require 'color)

(after! org
  (set-face-attribute 'org-block nil :background
                      (color-lighten-name
                       (face-attribute 'default :background) 30)
                      )
  )
;; (custom-set-faces
;;  '(default ((t (:inherit iosevka-custom-extra-light
;;                 :size 10
;;                 :slant normal)))))


;; Wrong type argument: plistp, (:inherit iosevka-custom extra-light :size 15
;; :slant normal)
