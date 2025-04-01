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


;;; Tree Sitter stuff.
(setq treesit-extra-load-path `(,(concat zanv-sync-dir "dat/tree-sitter-grammers/")))
(setq treesit-font-lock-level 4)
(setq major-mode-remap-alist '((java-mode . java-ts-mode)
			       (c-mode . c-ts-mode)
			       (python-mode . python-ts-mode)))


;;; Dired customizations.
(setq dired-maybe-use-globstar t)
(setq dired-kill-when-opening-new-dired-buffer t)


;;; Set dictionary. Plain text word lists to be used with the variable below can
;;; be generated at http://app.aspell.net/create/. NOTE: Lines with apostrophes
;;; need to be removed from generated word list.
;;; Note that this variable needs the path set without using the tilde.
(setq ispell-alternate-dictionary "/home/zan/sync/dat/emacs/word-list/en_CA.txt")


;;; Have 'C-h f' show examples of function usage.
(add-hook 'help-fns-describe-function-functions
	  #'shortdoc-help-fns-examples-function)


;;; Abbrev-mode customizations
(setq abbrev-suggest t)
(setq abbrev-file-name (concat zanv-emacs-dat-dir "abbrevs_defs"))
(setq-default abbrev-mode t)


;;; Set default printer to 'lp'.
(setq lpr-command "lp")
(setq lpr-add-switches nil)


;;; Change location of 'persist.el' files.
(setq persist--directory-location (concat zanv-emacs-dat-dir "persist"))


;;; Add new project root markers.
(setq project-vc-extra-root-markers '(".project.el"))


(provide 'zan-misc)
