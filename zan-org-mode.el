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


;; Make 'org-agenda-quit' close the gtd.org buffer.
(defun zanf-org-agenda-quit ()
  (interactive)
  (org-agenda-quit)
  (org-save-all-org-buffers)
  (kill-buffer "gtd.org"))


;; Make 'org-capture' reload the capture templates after execution. Allows
;; adding new projects via 'org-capture' that have capture templates dynamically
;; generated capture templates themselves.
(defun zanf-org-capture ()
  (interactive)
  (org-capture)
  (zanf-set-org-capture-templates))


(setq org-refile-targets '((nil . (:maxlevel . 5))))


(provide 'zan-org-mode)
