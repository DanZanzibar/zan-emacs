;; A place for packages to be 'require'd and customized. May need to move some
;; stuff out of here if it gets too busy.


(use-package diminish
  :ensure t)


(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-count 10)
  (vertico-resize nil))


(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))


(use-package consult
  :ensure t)


(use-package which-key
  :ensure t)
(which-key-mode)
(diminish 'which-key-mode)
(which-key-setup-minibuffer) ; to help with echo area covering which-key


(use-package corfu
  :ensure t)
(setq corfu-auto t)
(global-corfu-mode)


(use-package git-gutter
  :ensure t)
(diminish 'git-gutter)
(add-hook 'prog-mode-hook 'git-gutter-mode)
(setq git-gutter:update-interval 0.02)


(use-package git-gutter-fringe
  :ensure t)
(define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)


(use-package magit
  :ensure t)
(setq magit-repository-directories
      '(("~/" . 1)
	("~/.emacs.d/" . 1)
	("~/sync/" . 4)))


(use-package zeal-at-point
  :ensure t)


(use-package pdf-tools
  :ensure t)
(use-package doc-toc
  :ensure t)
(pdf-loader-install)
(defun zanf-pdf-view-quit ()
  (interactive)
  (zanf-prompt-for-bookmark)
  (quit-window))


(use-package auctex
  :ensure t)
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-electric-math '("$" . "$"))


(provide 'zan-packages)
