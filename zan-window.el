;;;; Window functions.


;;; Side window prefix functions.


(defun zanf-side-window-prefix (side &optional slot)
  (setq zanv-side-window-prefix--side side)
  (setq zanv-side-window-prefix--slot slot)
  (display-buffer-override-next-command
   (lambda (buffer alist)
     (setq alist (zanf-side-window-prefix--modify-alist alist))
     (cons (display-buffer-in-side-window buffer alist) nil))
   nil "[side-window]")
  (message "Display next command buffer in a side window..."))

(defun zanf-side-window-prefix--modify-alist (alist)
  (let ((window-params '((window-parameters . ((no-delete-other-windows . t)))))
	(side `((side . ,(intern zanv-side-window-prefix--side))))
	(slot `((slot . ,(or zanv-side-window-prefix--slot 0)))))
    (append window-params side slot alist)))

(setq some-alist '((1 . 2)))
(setq zanv-side-window-prefix--side "top")
(setq zanv-side-window-prefix--slot 1)
(zanf-side-window-prefix--modify-alist some-alist)
(zanf-side-window-prefix "top")


(provide 'zan-window)
