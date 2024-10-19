;; A place for general prog-mode customization and keybindings.


;; Electric pair mode hooks
(dolist (mode '(python-mode-hook
		java-mode-hook
		c-mode-hook
		sh-mode
		LaTeX-mode-hook))
  (add-hook mode 'electric-pair-local-mode))


(provide 'zan-prog)
