(defun zanf-snippet--choose-snippet ()
  (concat
   zanv-snippet-dir
   (completing-read
    "Which snippet? "
    (remove
     "." (remove
	  ".."
	  (directory-files zanv-snippet-dir))))))

(defun zanf-snippet--replace-placeholder-get-input (placeholder)
  (read-string
   (concat (substring placeholder 1 -1) ": ")))

(defun zanf-snippet--replace-placeholder (placeholder input start)
  (goto-char start)
  (when (search-forward placeholder zanv-snippet--end t)
    (replace-match input)
    (setq zanv-snippet--end (+ zanv-snippet--end (- (length input) (length placeholder))))
    (zanf-snippet--replace-placeholder
     placeholder
     input
     start)))

(defun zanf-snippet--has-next-placeholder (start)
  (goto-char start)
  (if (re-search-forward "~[^~]*~" zanv-snippet--end t) t nil))

(defun zanf-snippet-insert-at-point ()
  (interactive)
  (let* ((start (point))
	 (snip (zanf-snippet--choose-snippet))
	 (length (nth 1 (insert-file-contents snip))))
    (setq zanv-snippet--end (+ start length))
    (indent-region start zanv-snippet--end)
    (while (zanf-snippet--has-next-placeholder start)
      (let* ((placeholder (match-string 0))
	     (input (zanf-snippet--replace-placeholder-get-input placeholder)))
	(zanf-snippet--replace-placeholder placeholder input start))))
  (goto-char zanv-snippet--end))

(save-excursion)

(setq zanv-snippet-dir "~/sync-general/emacs/snippets/")

(define-key global-map (kbd "C-c M-s") 'zanf-snippet-insert-at-point)

(provide 'zan-snippet)
