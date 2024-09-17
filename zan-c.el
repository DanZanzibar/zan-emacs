(defun zanf-compile-c ()
  "Compile the current C file."
  (interactive)
  (let ((file (file-name-nondirectory buffer-file-name)))
    (compile (concat "gcc " file " -o " (file-name-sans-extension file)))))

(keymap-set c-mode-map "C-c c" 'zanf-compile-c)

(provide 'zan-c)
