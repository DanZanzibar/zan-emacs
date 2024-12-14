;;;; Window functions.


;;; Side window prefix functions.


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
  (zanf-side-window-prefix "right" 1)
  (dired directory))


;;; 'display-buffer-alist' for matching buffer names to rules.
(setq display-buffer-alist
      '(("\\*info\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 (slot . -1)
	 (window-width . 80)
	 (window-height . 0.7))))


(provide 'zan-window)
