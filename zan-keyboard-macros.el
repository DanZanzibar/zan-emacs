(defalias 'work-agenda-and-customers
  (kmacro "C-c a M d a y t i m e <return> C-x 1 C-x 2 C-x o M-x s h e l l <return> w o r k - c o n t a c t s <return> C-x o g"))
(keymap-global-set "C-x C-k 1" 'work-agenda-and-customers)

(defalias 'start-league-processes
  (kmacro "C-u M-x s h e l l <return> l e a g u e - 1 <return> l e a g u e - 1 <return> C-u M-x s h e l l <return> l e a g u e - 2 <return> l e a g u e - 2 <return> C-x b s c r <tab> <return>"))
(keymap-global-set "C-x C-k 2" 'start-league-processes)


(provide 'zan-keyboard-macros)
