;; The snippet inserting function, helpers, and variables. It uses a directory
;; of text files where each file contains an insertable snippet. They may
;; contain fields to be replaced at the time of insertion. In the text file,
;; these fields should begin and end with 'zanv-snippet-placeholder-delimiter'
;; and are grouped by the name within these delimiters. Each group of fields
;; with the same name will be replaced by the same string which the user is
;; prompted to give at time of insertion. Thus the user will be prompted once to
;; supply a new string for "~NAME~" (supposing the delimiter is "~") and all
;; instances of "~NAME~" will become the new string.

;; TODO - I would like to add a 'capture-snippet' function that takes a region or
;; the whole buffer and make a new snippet file. Also a function that changes the
;; delimiter and replaces it properly in all snippet files.


(setq zanv-snippet-dir "~/sync/emacs/snippets/")

(setq zanv-snippet-placeholder-delimiter "~")

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
  (let ((affix-length (length zanv-snippet-placeholder-delimiter)))
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
       (concat zanv-snippet-placeholder-delimiter
	       "[^" zanv-snippet-placeholder-delimiter "]*" zanv-snippet-placeholder-delimiter)
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


(provide 'zan-snippet)
