;;;; Window functions.


;;; Side window prefix functions.
;;; TODO - make it interactive and assign keybinding.
(defun zanf-side-window-prefix (side &optional slot width)
  (display-buffer-override-next-command
   `(lambda (buffer alist)
      (setq alist (zanf-side-window-prefix--modify-alist
		   alist ,side ,slot ,width))
      (cons (display-buffer-in-side-window buffer alist) nil))
   nil "[side-window]")
  (message "Display next command buffer in a side window..."))

(defun zanf-side-window-prefix--modify-alist (alist side slot width)
  (let ((window-params '((window-parameters . ((no-delete-other-windows . t)))))
	(side `((side . ,(intern side))))
	(slot `((slot . ,(or slot 0))))
	(width `((window-width . ,(or width 80)))))
    (append alist window-params side slot width)))

(defun zanf-dired-right-side-window (directory)
  (interactive "DDirectory: ")
  (zanf-side-window-prefix "right" 0)
  (dired directory))


;;; 'display-buffer-alist' customization.
;; A variable to store my custom version.
(setq zanv-user-display-buffer-alist
      '(("\\*info\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 (slot . -1)
	 (window-width . 80)
	 (window-height . 0.7)
	 (window-parameters . ((no-delete-other-windows . t))))
	("\\*Help\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 (slot . 1)
	 (window-width . 80)
	 (window-height . 0.3)
	 (window-parameters . ((no-delete-other-windows . t))))
	("\\*Outline.*\\.pdf\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 (slot . -2)
	 (window-width . 80)
	 (window-height . 0.3)
	 (window-parameters . ((no-delete-other-windows . t))))
	((major-mode . dired-mode)
	 (display-buffer-in-side-window)
	 (side . right)
	 (slot . -2)
	 (window-width . 80)
	 (window-height . 0.3)
	 (window-parameters . ((no-delete-other-windows . t))))
	("\\*eshell\\*"
	 (display-buffer-in-side-window)
	 (side . bottom)
	 (slot . 0)
	 (window-height . 0.3)
	 (window-parameters . ((no-delete-other-windows . t))))))

;; Load 'zanv-user-display-buffer-alist' when starting emacs.
(setq display-buffer-alist zanv-user-display-buffer-alist)
(setq window-sides-vertical t)

;; A command for toggling default vs custom alist.
(defun zanf-toggle-user-display-buffer-alist ()
  (interactive)
  (if display-buffer-alist
      (progn
	(setq display-buffer-alist nil)
	(message "Using default 'display-buffer-alist'"))
    (setq display-buffer-alist zanv-user-display-buffer-alist)
    (message "Using user-defined 'display-buffer-alist'")))


(provide 'zan-window)
