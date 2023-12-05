;;; conf.d/_ligatures.el -*- lexical-binding: t; -*-

(set-ligatures! (quote org-mode)
  :src_block "#+src_begin"
  :true "yes" :false "no"
  )

(plist-put! +ligatures-extra-symbols
            ;; org
            :name          "»"
            :src_block     "»"
            :src_block_end "«"
            :quote         "“"
            :quote_end     "”"
            ;; ;; Functional
            ;; :lambda        "λ"
            ;; :def           "ƒ"
            ;; :composition   "∘"
            ;; :map           "↦"
            ;; ;; Types
            ;; :null          "∅"
            ;; :true          "𝕋"
            ;; :false         "𝔽"
            ;; :int           "ℤ"
            ;; :float         "ℝ"
            ;; :str           "𝕊"
            ;; :bool          "𝔹"
            ;; :list          "𝕃"
            ;; ;; Flow
            ;; :not           "￢"
            ;; :in            "∈"
            ;; :not-in        "∉"
            ;; :and           "∧"
            ;; :or            "∨"
            ;; :for           "∀"
            ;; :some          "∃"
            ;; :return        "⟼"
            ;; :yield         "⟻"
            ;; ;; Other
            ;; :union         "⋃"
            ;; :intersect     "∩"
            ;; :diff          "∖"
            ;; :tuple         "⨂"
            ;; :pipe          "" ;; FIXME: find a non-private char
            ;; :dot           "•"
            )

(quote
 (setq +ligatures-extra-alist
  (quote
   ((dired-mode
     ("rwx" . "7")
     ("rw-" . "6")
     ("r-x" . "5")
     ("r--" . "4")
     ("-wx" . "3")
     ("-r-" . "2")
     ("--x" . "1")
     ("---" . "0"))

    (emacs-lisp-mode
     ("lambda" . "λ")
     ("'\\\\''" . "⍞"))

    (org-mode
     ("#+BEGIN_QUOTE" . "“")
     ("#+BEGIN_SRC" . "»")
     ("#+END_QUOTE" . "”")
     ("#+END_SRC" . "«")
     ("#+NAME:" . "»")
     ("#+begin_quote" . "“")
     ("#+begin_src" . "»")
     ("#+end_quote" . "”")
     ("#+end_src" . "«")
     ("#+name:" . "»")
     ("no" . "𝔽")
     ("yes" . "𝕋"))

    (sh-mode
     ("[[" . "⟦")
     ("]]" . "⟧")
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("." . "•")
     ("return" . "⟼")
     ("for" . "∀")
     ("in" . "∈")
     ("||" . "∨")
     ("&&" . "∧")
     ("!" . "￢")
     ("false" . "𝔽")
     ("true" . "𝕋")
     ("function" . "ƒ"))
    (t)))))
