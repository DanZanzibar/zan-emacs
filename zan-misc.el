;; A place for oddball init calls without a home. Should be kept short.


;; Autosave and backup
(setq kill-buffer-delete-auto-save-files t)
(setq make-backup-files nil)

;; To extend the authinfo hiding of passwords to other stuff
(setq authinfo-hidden (rx (or "password"
			      "client-id"
			      "client-secret"
			      "refresh-token")))


;; Automatically go to real file from symlink to version controlled file.
(setq vc-follow-symlinks t)


;; Set the bookmarks file to one in the sync folder.
(setq bookmark-default-file "~/sync/emacs/bookmarks")

;; Make setting bookmark save bookmarks file.
(defun zanf-bookmark-set ()
  (interactive)
  (bookmark-set)
  (bookmark-save))


(provide 'zan-misc)
