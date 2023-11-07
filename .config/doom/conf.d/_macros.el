;;; $DOOMDIR/conf.d/_macros.el -*- lexical-binding: t; -*-

;;;###autoload
(defmacro -all-windows ()
  `(flatten-list (mapcar #'window-list (frame-list))))

;;;###autoload
(defmacro -all-buffers ()
  `(flatten-list (mapcar #'buffer-list (frame-list))))

;;;###autoload
(defmacro -all-window-buffers ()
  `(flatten-list (mapcar #'window-buffer (-all-windows))))

;;;###autoload
(defmacro -all-process-buffers ()
  `(flatten-list (mapcar #'process-buffer (process-list))))

;;;###autoload
(defmacro -get-buffer ($buffer-name)
  `(get-buffer
    (with-temp-buffer
      (insert (with-output-to-string
                (princ (-all-process-buffers))))
      (re-search-backward (rx ?* ,(eval $buffer-name) ?*) nil t)
      (buffer-substring (match-beginning 0)
                        (match-end 0)))))
