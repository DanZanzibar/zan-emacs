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

(defun zanf-project-agenda--create-agenda (project)
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

(defun zanf-project-agenda--create (project)
  "Creates an agenda file for the project and returns the file path.

Uses the first element from 'zanv-project-agenda-file-name' for the file name 
and creates it in the project root."
  (let ((filename (expand-file-name (car zanv-project-agenda-file-names)
					 (project-root project))))
    (write-region "" nil filename nil nil nil 'excl)
    filename))

(defun zanf-set-gtd-capture-templates ()
  "Set 'org-capture-templates' for the gtd file.

Adds all the dynamically generated templates."
  (setq org-capture-templates
	(append
	 zanv-org-capture-templates-static
	 (zanf-dynamic-capture-templates zanv-gtd "Static")
	 (zanf-dynamic-capture-templates zanv-gtd "Dynamic"))))


(defun zanf-set-project-capture-templates (project)
  "Set 'org-capture-templates' for the given project.

All the headings in the project agenda file will generate templates."
  (let ((agenda (zanf-project-agenda--find-agenda project)))
    (setq org-capture-templates
	  (append
	   (zanf-org-capture-templates--project-default agenda)
	   (zanf-dynamic-capture-templates agenda)))))

(defun zanf-org-capture ()
  "A replacement for 'org-capture' that allows choosing the agenda file.

It prompts the user to choose getween the GTD agenda or the project's."
  (interactive)
  (let* ((project (when (string= "project"
				 (completing-read
				  "Which agenda: " '("gtd" "project")))
		    (project-current t)))
	 (agenda (if project
		     (zanf-project-agenda--find-agenda project)
		   zanv-gtd)))
    (setq org-agenda-files (list agenda))
    (if project
	(zanf-set-project-capture-templates project)
      (zanf-set-gtd-capture-templates))
    (org-capture)))

(defun zanf-org-capture--from-agenda ()
  "Call 'org-capture' for the current 'org-agenda-files'.

Still rebuilds all the dynamic capture templates for the given file."
  (interactive)
  (let ((agenda (car org-agenda-files)))
    (if (file-equal-p agenda zanv-gtd)
	(zanf-set-gtd-capture-templates)
      (zanf-set-project-capture-templates (project-current t)))
    (org-capture)))


(setq org-agenda-custom-commands
      '(("p" "Project Agenda" tags-todo ""
	 ((org-agenda-files
	   (setq org-agenda-files
		 (list (let ((project (project-current t)))
			 (or (zanf-project-agenda--find-agenda project)
			     (zanf-project-agenda--create project))))))))
	("g" "GTD" tags-todo ""
	 ((org-agenda-files (setq org-agenda-files (list zanv-gtd)))))))
	  

(setq org-refile-targets '((nil . (:maxlevel . 5))))
(add-hook 'org-mode-hook '(lambda () (visual-line-mode 1)))


;;; Org-roam configs
(setq org-roam-directory "/home/zan/sync/dat/org-roam/")
(org-roam-db-autosync-mode)


(provide 'zan-org-mode)
