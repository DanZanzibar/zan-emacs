(defmacro zanm-package (package &rest args)
  `(progn
     (unless (package-installed-p ',package)
       (package-install ',package))
     (require ',package)
     ,@args))


;; Seperate out custom file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error)


;; Add a directory for init modules
(add-to-list 'load-path "~/.emacs.d/zan-emacs")


;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;; Basic UI stuff

(toggle-frame-fullscreen)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(electric-pair-mode 1)

(global-display-line-numbers-mode t)
(setq column-number-mode t)
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))

(setq visible-bell t)
(setq vc-follow-symlinks t)
(add-hook 'Info-mode-hook 'visual-line-mode) ; get word wrap on all help docs
(setq initial-scratch-message nil)

(define-key global-map (kbd "C-c M-r") 'replace-string)

;; LaTeX
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-electric-math '("$" . "$"))

;; Autosave and backup
(setq kill-buffer-delete-auto-save-files t)
(setq make-backup-files nil)

;; To extend the authinfo hiding of passwords to other stuff
(setq authinfo-hidden (rx (or "password"
			      "client-id"
			      "client-secret"
			      "refresh-token")))


;; Packages

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

;; JS stuff - to move to it's own file.
(setq js-indent-level 2)

;; Java stuff
(zanm-package eglot-java)
(add-hook 'java-mode-hook 'eglot-java-mode)
(define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
(define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
(define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
(define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
(define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
(define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh)

(require 'text-property-search) ; Potential short term workaround for eglot

(zanm-package corfu)
(setq corfu-auto t)
(global-corfu-mode)

;; (use-package pcmpl-args) ; this probably isn't doing anything...?

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
	("~/codehome/" . 3)))

(define-key global-map (kbd "C-c M-m") 'magit-list-repositories)

;; Zeal
(zanm-package zeal-at-point)
(define-key global-map (kbd "C-c z") 'zeal-at-point)

;; Themes
(zanm-package ef-themes)
(load-theme 'ef-cherie :no-confirm)


;; Load init modules

(require 'zan-email)

(require 'zan-org-capture)

(require 'zan-org-functions)

(require 'zan-editing-functions)

(require 'zan-python)
