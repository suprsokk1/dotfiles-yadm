;;; conf.d/_99-dbus.el -*- lexical-binding: t; -*-

(require 'dbus)

;; Example from:
;; https://www.gnu.org/software/emacs/manual/html_mono/dbus.html
;;

;;;###autoload
(defun my-dbus-method-handler (filename)
  (if (find-file filename)
      '(:boolean t)
    '(:boolean nil)))


(dbus-register-method
 :session "org.freedesktop.TextEditor" "/org/freedesktop/TextEditor"
 "org.freedesktop.TextEditor" "OpenFile"
 #'my-dbus-method-handler)
