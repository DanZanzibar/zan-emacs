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


;; Set Treesitter grammer load path.
(setq treesit-extra-load-path '("~/sync/dat/tree-sitter-grammers/"))
(setq treesit-font-lock-level 4)


;; Dired customizations.
(setq dired-maybe-use-globstar t)
(setq dired-kill-when-opening-new-dired-buffer t)


(provide 'zan-misc)
