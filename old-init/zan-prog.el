;; -*- lexical-binding: t -*-
;; A place for general prog-mode customization and keybindings.


;; Electric pair mode hooks
(defvar zanv-epair-mode-hooks
  '(python-mode-hook
    python-ts-mode-hook
    java-mode-hook
    java-ts-mode-hook
    c-mode-hook
    c-ts-mode-hook
    shell-mode-hook
    sh-mode-hook
    emacs-lisp-mode-hook
    LaTeX-mode-hook
    gdscript-mode-hook
    gdscript-ts-mode-hook))

(dolist (mode zanv-epair-mode-hooks) (add-hook mode 'electric-pair-local-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '((gdscript-mode gdscript-ts-mode) . ("localhost" 6005))))



(provide 'zan-prog)
