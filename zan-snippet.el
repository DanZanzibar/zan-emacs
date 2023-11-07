(defun zanf-snippet-choose-snippet ()
  (concat
   zanv-snippet-dir
   (completing-read
    "Which snippet? "
    (remove
     "." (remove
	  ".."
	  (directory-files zanv-snippet-dir))))))

(defun zanf-snippet-replace-field (start end placeholder input)
  (goto-char start)
  (when placeholder
    (while (search-forward placeholder end t)
      (replace-match input)
      (goto-char start)))
  (when (re-search-forward "~[^~]*~" end t)
    (let* ((placeholder (match-string 0))
	   (input
	    (read-string
	     (concat (substring placeholder 1 -1) ": "))))
      (zanf-snippet-replace-field start end placeholder input))))

(defun zanf-snippet-insert-at-point ()
  (interactive)
  (let* ((start (point))
	 (snip (zanf-snippet-choose-snippet))
	 (length (nth 1 (insert-file-contents snip)))
	 (end (+ start length)))
    (indent-region start end)
    (zanf-snippet-replace-field start end nil nil)
    (goto-char end)))

(setq zanv-snippet-dir "~/sync-general/emacs/snippets/")

(define-key global-map (kbd "C-c M-s") 'zanf-snippet-insert-at-point)

(provide 'zan-snippet)
