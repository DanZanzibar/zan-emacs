;; A place just for this function. Perhaps overkill...


(setq zanv-texts-directory "~/sync-general/texts/")

(defun zanf-open-text--get-text ()
  (completing-read "Which text? :" (directory-files zanv-texts-directory)))

(defun zanf-open-text ()
  (interactive)
  (let* ((text-book (zanf-open-text--get-text))
	 (text-file-path (concat zanv-texts-directory text-book)))
    (find-file text-file-path)))

(keymap-global-set "C-c k o" 'zanf-open-text)


(provide 'zan-texts)
