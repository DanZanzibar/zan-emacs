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

;;; TODO - make java-run run a .class file from /bin instead.
(defun zanf-java-run ()
  (interactive)
  (let ((java-file (zanf-java-run--completing-read)))
    (setq zanv-java--last-run java-file)
    (compile (concat "java " java-file) t))
  (other-window 1)
  (goto-char (point-max)))


;;; Creates the .dir-locals.el file for a java project.
(setq zanv-java-dir-locals
      ";;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info \"(emacs) Directory Variables\")

((nil . ((compile-command . \"javac -d bin $(find src -name \\\"*.java\\\")\")))
 (java-ts-mode . ((eglot-workspace-configuration . (:java (:project (:sourcePaths [\"src\"] :outputPath \"bin\")))))))
")

(defun zanf-java-create-dir-locals ()
  (interactive)
  (with-temp-file ".dir-locals.el"
    (insert zanv-java-dir-locals)))


(provide 'zan-java)
