;;; conf.d/_python.el -*- lexical-binding: t; -*-

(after! python
  (set (quote +python-ipython-repl-args)
       (quote ("-i" "--simple-prompt" "--no-color-info")))

  (set (quote +python-jupyter-repl-args)
       (quote ("--simple-prompt"))))
