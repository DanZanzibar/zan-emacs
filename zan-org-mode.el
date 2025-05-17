;; -*- lexical-binding: t -*-
;; All things org-mode. Note that org-capture-templates are stored in their own
;; file.


;; Custom functions for org-mode and org-agenda-mode.


;; Start of zanf-org-refile-list-item and helpers
;; Lets you move a list item as-is to another heading within the same file.

(defvar zanv-org-refile-last-stored-list-item nil)

(defun zanf-org-refile-store-list-item ()
  (let ((beg (line-beginning-position))
        (end (line-end-position)))	
    (setq zanv-org-refile-last-stored-list-item (buffer-substring-no-properties beg end))
    (delete-region beg (line-beginning-position 2))))

(defun zanf-org-refile-choose-heading ()
  (completing-read "Choose a heading: "
		   (org-map-entries
		    #'(org-get-heading :no-tags :no-todo :no-cookie :no-comment))))

(defun zanf-org-refile-find-heading (target-heading)
  (goto-char (point-min))
  (re-search-forward (format "^\\*+\\( .*? \\| \\)%s" target-heading) nil nil 1)
  (goto-char (line-beginning-position))
  (unwind-protect
      (progn
	(org-narrow-to-subtree)
	(goto-char (point-max)))
    (widen)))

(defun zanf-org-refile-list-item ()
  (interactive)
  (let ((target (zanf-org-refile-choose-heading)))
    (zanf-org-refile-store-list-item)
    (zanf-org-refile-find-heading target)
    (insert "\n")
    (insert zanv-org-refile-last-stored-list-item)))


;; Since 'org-agenda-kill' doesn't save the file after, make it do so.
(defun zanf-org-agenda-kill ()
  (interactive)
  (org-agenda-kill)
  (org-save-all-org-buffers))


;; Same for 'org-agenda-refile'.
(defun zanf-org-agenda-refile ()
  (interactive)
  (org-agenda-refile)
  (org-save-all-org-buffers))


;; Same for 'org-agenda-add-note'.
(defun zanf-org-agenda-add-note ()
  (interactive)
  (org-agenda-add-note)
  (org-save-all-org-buffers))


;; Make 'org-agenda-quit' close all org-agenda files.
(defun zanf-org-agenda-quit ()
  (interactive)
  (org-agenda-quit)
  (org-save-all-org-buffers)
  (dolist (filename (org-files-list))
    (let ((buffer (find-buffer-visiting filename)))
      (when buffer
	(kill-buffer buffer)))))


;;; Functions for using project-specific org-agenda files.

(defvar zanv-project-agenda-file-names '("tasks.org")
  "A list containing possible project agenda file names.")

(defvar zanv-project-agenda-file-locations '("doc")
  "A list containing possible agenda file locations.

These must be either absolute paths or relative to the project root.")

;; For use in the project opening functions, like 'project-find-file':
(defun zanf-project-agenda ()
  "Opens org-agenda using the project agenda file.

Like other project.el functions, prompts the user if no project is active.
Checks for a file named in 'zanv-project-agenda-file-names' located in
'zanv-project-agenda-file-locations'. If no matching files exist, it
offers to create one using the first name in
'zanv-project-agenda-file-names' located in the project root directory."
  (interactive)
  (let* ((project (project-current t))
	 (agenda-file (zanf-project-agenda--find-agenda project)))
    (unless agenda-file)))

(defun zanf-porject-agenda--create-agenda (project)
  "Create a project agenda file in the root directory.

Uses the first name in 'zanv-project-agenda-file-names'."
  )

(defun zanf-project-agenda--find-agenda (project)
  "Return the agenda file for the project."
  (let* ((root (project-root project))
	 (dirs (cons root zanv-project-agenda-file-locations))
	 (dirs-abs (mapcar
		    (lambda (dir) (expand-file-name dir root)) dirs)))
    (catch 'found
      (dolist (file-name zanv-project-agenda-file-names)
	(dolist (dir dirs-abs)
	  (let ((path (expand-file-name file-name dir)))
	    (when (file-exists-p path)
	      (throw 'found path))))))))
    

;; Make 'org-capture' reload the capture templates before execution. Allows
;; adding new projects via 'org-capture' that have capture templates dynamically
;; generated capture templates themselves.
(defun zanf-org-capture ()
  (interactive)
  (zanf-set-org-capture-templates)
  (org-capture))


(setq org-refile-targets '((nil . (:maxlevel . 5))))
(add-hook 'org-mode-hook '(lambda () (visual-line-mode 1)))


(provide 'zan-org-mode)
