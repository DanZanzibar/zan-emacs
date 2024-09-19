(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-startup-message t)

;; Themes
(zanm-package ef-themes)
(load-theme 'ef-cherie :no-confirm)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

(setq visible-bell t)

(add-hook 'Info-mode-hook 'visual-line-mode) ; get word wrap on all help docs

(setq initial-scratch-message nil)

(setq split-height-threshold 90)

(setq column-number-mode t)

(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))


(provide 'zan-ui)
