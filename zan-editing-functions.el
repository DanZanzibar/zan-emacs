;; General text editing functions.

(defun zan-kill-to-end-of-buffer ()
  (interactive)
  (kill-region (point) (point-max)))


(provide 'zan-editing-functions)
