;; A place for general prog-mode customization and keybindings.


;; Electric pair mode hooks
(defvar zanv-epair-mode-hooks
  '(python-mode-hook
    java-mode-hook
    c-mode-hook
    shell-mode-hook
    sh-mode-hook
    emacs-lisp-mode-hook
    LaTeX-mode-hook))

(dolist (mode zanv-epair-mode-hooks) (add-hook mode 'electric-pair-local-mode))


(provide 'zan-prog)
