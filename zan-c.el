(defun zanf-compile-c ()
  "Compile the current C file."
  (interactive)
  (let ((file (file-name-nondirectory buffer-file-name)))
    (compile (concat "gcc " file " -o " (file-name-sans-extension file)))))

(defun zanf-compile-and-run-c ()
  "Runs the output of the current buffer. Compiles if necessary."
  (interactive)
  (let* ((file (file-name-nondirectory buffer-file-name))
	 (exe (file-name-sans-extension file)))
    (compile (concat "gcc " file " -o " exe " && ./" exe))))

(keymap-set c-mode-map "C-c c" 'zanf-compile-c)
(keymap-set c-mode-map "C-c r" 'zanf-compile-and-run-c)

(provide 'zan-c)
