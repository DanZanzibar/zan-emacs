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



(defun zanf-java-run ()
  (interactive))
  

(define-key eglot-java-mode-map (kbd "C-c c") 'zanf-java-compile-all)

(provide 'zan-java)
