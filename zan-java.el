(zanm-package eglot-java)

(add-hook 'java-mode-hook 'eglot-java-mode)

(define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
(define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
(define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
(define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
(define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
(define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh)


(defun zanf-java-compile-all ()
  (interactive)
  (compile "javac *.java" t))

(define-key eglot-java-mode-map (kbd "C-c c") 'zanf-java-compile-all)


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

(define-key eglot-java-mode-map (kbd "C-c r") 'zanf-java-run)
  

(provide 'zan-java)
