;; -*- lexical-binding: t -*-
;;;; All things Java.


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


(defvar zanv-java-run-project-file--last nil
  "This variable is an alist of projects and their last run file. Does not
persist over sessions.")


(defun zanf-java-run-project-file ()
  "Prompts the user the select a '.class' file from the 'bin' directory at the
project root directory and runs it"
  (interactive)
  (let* ((completion-ignored-extensions nil)
	 (default-directory (project-root (project-current)))
	 (bin-dir (concat default-directory "bin/"))
	 (full-file-path (read-file-name "Run: " bin-dir nil t
					 zanv-java-run-project-file--last))
	 (rel-file-path (file-relative-name full-file-path bin-dir))
	 (class-name (file-name-sans-extension
		      (replace-regexp-in-string "/" "." rel-file-path))))
    (async-shell-command (format "java -cp %s %s" bin-dir class-name))
    (setq zanv-java-run-project-file--last rel-file-path)))


(provide 'zan-java)
