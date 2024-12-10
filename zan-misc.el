;;;; A place for oddball init calls without a home. Should be kept short.


;;; Autosave and backup
(setq kill-buffer-delete-auto-save-files t)
(setq make-backup-files nil)


;;; To extend the authinfo hiding of passwords to other stuff
(setq authinfo-hidden (rx (or "password"
			      "client-id"
			      "client-secret"
			      "refresh-token")))


;;; Automatically go to real file from symlink to version controlled file.
(setq vc-follow-symlinks t)


;;; Set Treesitter grammer load path.
(setq treesit-extra-load-path '("~/sync/dat/tree-sitter-grammers/"))
(setq treesit-font-lock-level 4)


;;; Dired customizations.
(setq dired-maybe-use-globstar t)
(setq dired-kill-when-opening-new-dired-buffer t)


;;; Set dictionary. Plain text word lists to be used with the variable below can
;;; be generated at http://app.aspell.net/create/. Note that this variable needs
;;; the path set without using the tilde.
(setq ispell-alternate-dictionary "/home/zan/sync/dat/emacs/word-list/en_CA.txt")


;;; Have 'C-h f' show examples of function usage.
(add-hook 'help-fns-describe-function-functions
	  #'shortdoc-help-fns-examples-function)


(provide 'zan-misc)
