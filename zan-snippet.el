(setq zanv-snippet-placeholder-affix "~")

(defun zanf-snippet--indent-line ()
  (interactive)
  (let ((pstart (point)))
    (indent-according-to-mode t)
    (- (point) pstart)))

(defun zanf-snippet--indent-all ()
  (interactive)
  (goto-char zanv-snippet--start)
  (while (<= (point) zanv-snippet--end)
    (let ((shift (zanf-snippet--indent-line)))
      (setq zanv-snippet--end (+ zanv-snippet--end shift))
      (setq zanv-snippet--start (+ zanv-snippet--start shift)))
    (next-line 1)))

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
  (let ((affix-length (length zanv-snippet-placeholder-affix)))
    (read-string
     (concat
      (substring placeholder affix-length (* affix-length -1))
      ": "))))

(defun zanf-snippet--replace-placeholder (placeholder input)
  (goto-char zanv-snippet--start)
  (when (search-forward placeholder zanv-snippet--end t)
    (replace-match input)
    (setq zanv-snippet--end (+ zanv-snippet--end (- (length input) (length placeholder))))
    (zanf-snippet--replace-placeholder
     placeholder
     input)))

(defun zanf-snippet--has-next-placeholder ()
  (goto-char zanv-snippet--start)
  (if (re-search-forward
       (concat zanv-snippet-placeholder-affix
	       "[^" zanv-snippet-placeholder-affix "]*" zanv-snippet-placeholder-affix)
       zanv-snippet--end t) t nil))

(defun zanf-snippet-insert-at-point ()
  (interactive)
  (setq zanv-snippet--start (point))
  (when (= (point) (+ 1 (buffer-size)))
    (insert "\n")
    (goto-char zanv-snippet--start))
  (let* ((snip (zanf-snippet--choose-snippet))
	 (length (nth 1 (insert-file-contents snip))))
    (setq zanv-snippet--end (+ zanv-snippet--start length))
    (zanf-snippet--indent-all)
    (while (zanf-snippet--has-next-placeholder)
      (let* ((placeholder (match-string 0))
	     (input (zanf-snippet--replace-placeholder-get-input placeholder)))
	(zanf-snippet--replace-placeholder placeholder input))))
  (goto-char zanv-snippet--end))


(setq zanv-snippet-dir "~/sync-general/emacs/snippets/")

(define-key global-map (kbd "C-c M-s") 'zanf-snippet-insert-at-point)

(provide 'zan-snippet)
