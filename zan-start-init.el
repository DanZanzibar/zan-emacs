;;;; The first init file loaded. 


;;; A use-package macro. Deprecated in favour of 'use-package'.
(defmacro zanm-package (package &rest args)
  `(progn
     (unless (package-installed-p ',package)
       (package-install ',package))
     (require ',package)
     ,@args))


;;; Seperate out custom file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error)


;;; Initialize package sources
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;;; Set custom file variables.
;; Set the 'sync' directory and others.
(setq zanv-sync-dir "~/sync/")
(setq zanv-emacs-dat-dir (concat zanv-sync-dir "dat/emacs/"))
(setq zanv-texts-dir (concat zanv-sync-dir "texts/"))
(setq zanv-pricelists-dir (concat zanv-sync-dir "dat/price-lists/"))

;; Set the bookmarks file to one in the sync folder.
(setq bookmark-default-file (concat zanv-emacs-dat-dir "bookmarks"))



(provide 'zan-start-init)
