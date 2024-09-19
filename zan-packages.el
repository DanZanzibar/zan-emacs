;; A place for packages to be 'require'd and customized. May need to move some
;; stuff out of here if it gets too busy.


(zanm-package diminish)


(zanm-package which-key)
(which-key-mode)
(diminish 'which-key-mode)
(which-key-setup-minibuffer) ; to help with echo area covering which-key


(zanm-package eglot)
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'js-mode 'eglot-ensure)
(setq eglot-report-progress nil)
(add-to-list 'eglot-server-programs
	     '((js-mode) "typescript-language-server" "--stdio"))

(keymap-set prog-mode-map "C-c k e" 'eglot)
(keymap-set prog-mode-map "C-c k C-e" 'eglot-reconnect)
(keymap-set prog-mode-map "C-c k r" 'eglot-rename)


(zanm-package corfu)
(setq corfu-auto t)
(global-corfu-mode)


(zanm-package git-gutter)
(diminish 'git-gutter)
(add-hook 'prog-mode-hook 'git-gutter-mode)
(setq git-gutter:update-interval 0.02)


(zanm-package git-gutter-fringe)
(define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)


(zanm-package magit)
(setq magit-repository-directories
      '(("~/" . 1)
	("~/.emacs.d/" . 1)
	("~/orghome/" . 1)
	("~/codehome/" . 5)
	("~/sync-general/" . 4)))
(keymap-global-set "C-c k m" 'magit-list-repositories)


(zanm-package zeal-at-point)
(keymap-set prog-mode-map "C-c z" 'zeal-at-point)


(zanm-package pdf-tools)
(zanm-package doc-toc)
(pdf-loader-install)
(keymap-set pdf-view-mode-map "C-c k t" 'doc-toc-extract-pages)


(zanm-package auctex)
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-electric-math '("$" . "$"))


(provide 'zan-packages)
