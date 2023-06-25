;; Start of zanf-run-python and helpers.

(defun zanf-run-python--get-interpreter ()
  (completing-read "Which version? (default python3) :"
		   (directory-files "/usr/bin/" nil "^python.+")
		   nil t "python3" nil "python3"))


(defun zanf-run-python ()
  (interactive)
  (run-python (zanf-run-python--get-interpreter) nil t))

(define-key global-map (kbd "C-c M-p") 'zanf-run-python)
  
;; End of function group


;; Pyvenv

(setenv "WORKON_HOME" "~/.venvs/")
(zanm-package pyvenv)
(define-key global-map (kbd "C-c v") 'pyvenv-workon)


(provide 'zan-python)
