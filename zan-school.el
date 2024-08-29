(defalias 'launch-c-programming-language-text
  (kmacro "C-x C-f C-a C-k ~ / s y n c - <tab> t e x t s / t h e <tab> <return> o"))
(keymap-set zan-keymap "c" 'launch-c-programming-language-text)

(provide 'zan-school)
