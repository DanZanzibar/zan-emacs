;; All basic UI customization goes here.


;; Self explanatory.
(setq inhibit-startup-message t)
(set-scroll-bar-mode nil)
(if (fboundp tool-bar-mode)
    (tool-bar-mode -1))
(menu-bar-mode -1)
(tooltip-mode -1)
(setq visible-bell t)
(setq initial-scratch-message nil)
(setq column-number-mode t)
(setq global-visual-line-mode t)


;; Make frames maximized by default.
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Themes
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-trio-dark :no-confirm))


;; Get word wrap on all help docs.
(add-hook 'Info-mode-hook 'visual-line-mode)


;; Makes it so horizontal splits are preferred on 2440x1440 res screens.
(setq split-height-threshold 90)


;; Set display line-numbers-mode for all but certain modes.
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))


(provide 'zan-ui)
