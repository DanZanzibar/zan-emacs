;; All things Java.


;; I'm using the eglot-java package for additional Java functionality.
(zanm-package eglot-java)
(add-hook 'java-mode-hook 'eglot-java-mode)



;; Compiling and running functions.

(defun zanf-java-compile-all ()
  (interactive)
  (compile "javac *.java" t))

(setq zanv-java--last-run "")

(defun zanf-java-run--completing-read ()
  (interactive)
  (setq zanv-java-files '())
  (dolist (file
	   (directory-files
	    (file-name-directory (buffer-file-name)) nil ".+\\.java"))
    (push (file-name-sans-extension file) zanv-java-files))
  (completing-read "Which file: " zanv-java-files nil nil zanv-java--last-run))

(defun zanf-java-run ()
  (interactive)
  (let ((java-file (zanf-java-run--completing-read)))
    (setq zanv-java--last-run java-file)
    (compile (concat "java " java-file) t))
  (other-window 1)
  (goto-char (point-max)))


(provide 'zan-java)
