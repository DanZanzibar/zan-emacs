;; The first init file loaded. 


;; A use-package macro.
(defmacro zanm-package (package &rest args)
  `(progn
     (unless (package-installed-p ',package)
       (package-install ',package))
     (require ',package)
     ,@args))


;; Seperate out custom file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error)


;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;; Set up 'zan-keymap' and set up one extra level of prefix key 'k'. The prefix
;; key should be used for most global keybindings and reserve "C-c single-letter"
;; bindings for major-mode specific bindings.
(define-prefix-command 'zan-keymap)
(keymap-global-set "C-c k" 'zan-keymap)


;; Since I'm using emacsclient typically, set this keybinding to terminate the
;; entire daemon.
(keymap-global-set "C-x C-c" 'save-buffers-kill-emacs)


(provide 'zan-start-init)
