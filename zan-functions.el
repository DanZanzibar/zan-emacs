;; General functions.


;; A function for wiping out the rest of buffer after point.

(defun zanf-kill-to-end-of-buffer ()
  (interactive)
  (kill-region (point) (point-max)))


;; A function and helpers for creating a scratch buffer with a specified
;; major mode.

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


;; Ask the user if they want to set a bookmark.
(defun zanf-prompt-for-bookmark ()
  (let ((prompt (read-from-minibuffer "Save a bookmark? (y/n default: no): "
				      nil nil nil nil "n")))
    (if (string= prompt "y")
	(bookmark-set))))


;; Make setting bookmark save bookmarks file.
(defun zanf-bookmark-set ()
  (interactive)
  (bookmark-set)
  (bookmark-save))


;; File-opening functions.
(defun zanf-open-file-in-dir (dir-path &optional prompt file-extension)
  "Prompt the user to open a file from a specified directory.

File names will be completed and a file-extension can be specified to filter
the results."
  (unless prompt (defvar prompt "Which file: "))
  (let* ((files (directory-files dir-path nil (when file-extension (concat ".*\." file-extension))))
	 (files (remove "." files))
	 (files (remove ".." files))
	 (file-name (completing-read prompt files nil t))
	 (file-path (concat dir-path file-name)))
    (find-file file-path)))

(defun zanf-open-text ()
  "Prompts the user to open a textbook pdf.

Uses pdfs stored in the directory specified by 'zanv-texts-dir'."
  (interactive)
  (zanf-open-file-in-dir zanv-texts-dir "Which text: " "pdf"))

(defun zanf-open-pricelist ()
  "Prompts the user to open a pricelist pdf.

Uses pdfs stored in the directory specified by 'zanv-pricelists-dir'."
  (interactive)
  (zanf-open-file-in-dir zanv-pricelists-dir "Which pricelist: " "pdf"))


(provide 'zan-functions)
