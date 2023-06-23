;; General text editing functions.

(defun zanf-kill-to-end-of-buffer ()
  (interactive)
  (kill-region (point) (point-max)))


;; Start of function group for making scratch buffers.

(defvar zanv-derived-majors ())


(defun zanf-derived-majors--mapatoms-f (symbol)
  (when (and (apply 'provided-mode-derived-p symbol zanv-derived-majors)
	     (not (member symbol zanv-derived-majors)))
    (setq mode-found t)
    (add-to-list 'zanv-derived-majors symbol)))


(defun zanf-derived-majors--get-modes ()
  (let ((mode-found nil))
    (mapatoms 'zanf-derived-majors--mapatoms-f)
    (if mode-found
	(zanf-derived-majors--get-modes))))


(defun zanf-derived-majors (&rest modes)
  "Search 'obarray' for derived major modes currently loaded in Emacs.

Parent modes can be specified, or if none are given, defaults to prog-mode
and text-mode. Returns a list of found major modes. Also updates variable
'zanv-derived-majors' with returned list."
  (let ((parent-modes (if modes modes '(prog-mode text-mode))))
    (setq zanv-derived-majors parent-modes)
    (zanf-derived-majors--get-modes)
    (dolist (mode parent-modes zanv-derived-majors)
      (setq zanv-derived-majors (remove mode zanv-derived-majors)))))


(defun zanf-scratch-buffer--choose-major ()
  (completing-read "Which major mode? (default: python-mode) "
		   (zanf-derived-majors) nil nil nil nil "python-mode"))


(defun zanf-scratch-buffer ()
  "Create and switch to a new scratch buffer with the chosen major mode enabled.

Completion is available for major modes currently loaded in Emacs according to
the function 'zanf-derived-majors'. If you wish to use a major mode not yet
loaded, you may specify it anyway (without completion)."
  (interactive)
  (let* ((mode (zanf-scratch-buffer--choose-major))
	(scratch-name (format "*%s-scratch*"
			     (substring mode 0 -5))))
    (get-buffer-create scratch-name)
    (switch-to-buffer scratch-name)
    (funcall (intern-soft mode))))



(provide 'zan-editing-functions)
