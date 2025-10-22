;; -*- lexical-binding: t -*-
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


;; Not using anymore.
(use-package activities
  :ensure t
  :init
  (activities-mode)
  (activities-tabs-mode)
  ;; Prevent `edebug' default bindings from interfering.
  (setq edebug-inhibit-emacs-lisp-mode-bindings t)

  :bind
  (("C-x C-a C-n" . activities-new)
   ("C-x C-a C-d" . activities-define)
   ("C-x C-a C-a" . activities-resume)
   ("C-x C-a C-s" . activities-suspend)
   ("C-x C-a C-k" . activities-kill)
   ("C-x C-a RET" . activities-switch)
   ("C-x C-a b" . activities-switch-buffer)
   ("C-x C-a g" . activities-revert)
   ("C-x C-a l" . activities-list)))


(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  :custom
  (aw-keys '(?a ?s ?d ?f ?h ?j ?k ?l))
  (aw-scope 'frame))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)))

(use-package embark-consult
  :ensure t)

(use-package gdscript-mode
  :ensure t
  :hook ((gdscript-mode . eglot-ensure)
	 (gdscript-ts-mode . eglot-ensure)))

(use-package org-roam
  :ensure t)

(use-package org-pdftools
  :ensure t
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-journal
  :ensure t)

(use-package gptel
  :ensure t)


(provide 'zan-packages)
