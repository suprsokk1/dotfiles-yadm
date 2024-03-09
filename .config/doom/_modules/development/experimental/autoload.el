;;; foo/bar/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun -generic-advice (func &rest args)
  (let ((empty-file-name (null (buffer-file-name)))
        ;; (file-buffer (not (string-match (buffer-name) (rx bol ?* (+ (any word space)) ?* eol))))
        (file-buffer (not (string-match (rx bol ?*) (buffer-name))))
        (is-window-buffer (string-match (buffer-name) (format "%s" (window-list)))))

    ;; (message "%S" func)
    ;; (debug! (re! "subr" func))
    ;; (str! func)
    ;; (debug! (string-match (rx ?# ?< (+ (not ?>))) (format "%S" func)))
    ;; (message (str! func))

    ;; (message "%S" (list
    ;;                func
    ;;                (string-match "foo" (format "%s"))
    ;;                ))

    (pcase func
      ('save-buffer (when (and file-buffer is-window-buffer (not empty-file-name))
                      (make-symbolic-link (buffer-file-name) (HOME "emacs.buffer-save") t)
                      (apply 'func args)))
      (_ (apply 'func args)))

    (when (string-match "save-buffer" (format "%S" func))
      (when (and file-buffer is-window-buffer (not empty-file-name))
        (make-symbolic-link (buffer-file-name) (HOME "emacs.buffer-save") t)
        (apply 'func args)))))

;;;###autoload
(defun --read-key (key-sequence)
  "TODO"
  (interactive
   (list (read-key-sequence "Press key: ")))
  (let ((sym (key-binding key-sequence)))
    (cond
     ((null sym)
      (user-error "No command is bound to %s"
                  (key-description key-sequence)))
     (t (user-error "%s is bound to %s which is not a command"
                    (key-description key-sequence)
                    sym)))))

;;;###autoload
(defmacro GIT (PATH &optional RELATIVE)
  `(message "TODO defmacro GIT"))

;;;###autoload
(defun debug! (&rest BODY)
  (message "%S" BODY))

;;;###autoload
(defun str! (&rest BODY)
  (format "%S" BODY))

;;;###autoload
(defmacro temp-buffer-to-string! (&rest BODY)
  `(with-temp-buffer
     ,@BODY
     (buffer-string)))
