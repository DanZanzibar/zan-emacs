;; Try to keep all the 'setq' calls here if possible.


;; Set the 'sync' directory and others.
(setq zanv-sync-dir "~/sync/")
(setq zanv-texts-dir (concat zanv-sync-dir "texts/"))
(setq zanv-pricelists-dir (concat zanv-sync-dir "dat/price-lists/"))


;; Set the bookmarks file to one in the sync folder.
(setq bookmark-default-file (concat zanv-sync-dir "dat/emacs/bookmarks"))


;; Set default printer to 'lp'.
(setq lpr-command "lp")
(setq lpr-add-switches nil)


(provide 'zan-config-vars)
