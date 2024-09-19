;; This is for general prog-mode customization and keybindings.


;; Electric pair mode hooks
(dolist (mode '(python-mode-hook
		java-mode-hook
		c-mode-hook
		LaTeX-mode-hook))
  (add-hook mode 'electric-pair-local-mode))


;; Keybindings
(keymap-set prog-mode-map "C-c n" 'flymake-goto-next-error)
(keymap-set prog-mode-map "C-c k c" 'comment-region)
(keymap-set prog-mode-map "C-c k u" 'uncomment-region)


(provide 'zan-prog)
