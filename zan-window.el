;;;; Window functions.


;;; Side window prefix functions.


(defun zanf-side-window-prefix (side &optional slot)
  (display-buffer-override-next-command
   (lambda (buffer alist)
     (setq alist (zanf-side-window-prefix--modify-alist alist side slot))
     (cons (display-buffer-in-side-window buffer alist) nil))
   nil "[side-window]")
  (message "Display next command buffer in a side window..."))

(defun zanf-side-window-prefix--modify-alist (alist side slot)
  (let ((window-params '((window-parameters . ((no-delete-other-windows . t)))))
	(side `((side . ,(intern side))))
	(slot `((slot . ,(or slot 0)))))
    (append window-params side slot alist)))

(defun zanf-open-dired-right-side ()
  (interactive)
  (zanf-side-window-prefix "right")
  (dired))


(provide 'zan-window)
