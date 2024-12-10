;;;; Storing all keybingss here. Makes it easier to see if there are any
;;;; conflicts.


;;; Zan's globals: begin with 'C-c g'.
(define-prefix-command 'zan-global-keymap)
(keymap-global-set "C-c g" 'zan-global-keymap)
(keymap-set zan-global-keymap "C-s" 'zanf-scratch-buffer)
(keymap-set zan-global-keymap "s" 'zanf-snippet-insert-at-point)
(keymap-set zan-global-keymap "t" 'zanf-open-text)
(keymap-set zan-global-keymap "p" 'zanf-open-pricelist)
(keymap-set zan-global-keymap "m" 'magit-list-repositories)
(keymap-set zan-global-keymap "k" 'org-capture)
(keymap-set zan-global-keymap "a" 'org-agenda)
(keymap-set zan-global-keymap "f" 'zanf-insert-filename)


;;; Emacs commands that I have redefined and shadowed with my own functions.
(keymap-global-set "C-x C-c" 'save-buffers-kill-emacs)  ; ends daemon
(keymap-global-set "C-x r m" 'zanf-bookmark-set) ; saves bookmark file

;; Org-mode changes.
(with-eval-after-load 'org-agenda
  (keymap-set org-agenda-mode-map "C-k" 'zanf-org-agenda-kill)
  (keymap-set org-agenda-mode-map "C-c C-q" 'zanf-org-agenda-refile)
  (keymap-set org-agenda-mode-map "z" 'zanf-org-agenda-add-note)
  (keymap-set org-agenda-mode-map "q" 'zanf-org-agenda-quit))


;;; Prog-mode.
(keymap-set prog-mode-map "C-c n" 'flymake-goto-next-error)
(keymap-set prog-mode-map "C-c c" 'comment-region)
(keymap-set prog-mode-map "C-c u" 'uncomment-region)
(keymap-set prog-mode-map "C-c z" 'zeal-at-point)

;; Eglot 'C-c e'.
(define-prefix-command 'zan-eglot-keymap)
(keymap-set prog-mode-map "C-c e" 'zan-eglot-keymap)
(keymap-set zan-eglot-keymap "e" 'eglot)
(keymap-set zan-eglot-keymap "C-e" 'eglot-reconnect)
(keymap-set zan-eglot-keymap "r" 'eglot-rename)
(keymap-set zan-eglot-keymap "f" 'eglot-format-buffer)
(keymap-set zan-eglot-keymap "c" 'eglot-code-actions)
(keymap-set zan-eglot-keymap "x" 'eglot-code-action-extract)

;; PDF-View
(keymap-set pdf-view-mode-map "C-c k C-t" 'doc-toc-extract-pages)
(keymap-set pdf-view-mode-map "q" 'zanf-pdf-view-quit)


;; C
(with-eval-after-load 'cc-mode
  (keymap-set c-mode-map "C-c c" 'zanf-compile-c)
  (keymap-set c-mode-map "C-c r" 'zanf-compile-and-run-c))


;; Java
(keymap-set eglot-java-mode-map "C-c c" 'zanf-java-compile-all)
(keymap-set eglot-java-mode-map "C-c r" 'zanf-java-run)
(keymap-set eglot-java-mode-map "C-c l n" #'eglot-java-file-new)
(keymap-set eglot-java-mode-map "C-c l x" #'eglot-java-run-main)
(keymap-set eglot-java-mode-map "C-c l t" #'eglot-java-run-test)
(keymap-set eglot-java-mode-map "C-c l N" #'eglot-java-project-new)
(keymap-set eglot-java-mode-map "C-c l T" #'eglot-java-project-build-task)
(keymap-set eglot-java-mode-map "C-c l R" #'eglot-java-project-build-refresh)


;; Python
(with-eval-after-load 'python
  (keymap-set python-mode-map "C-c v" 'pyvenv-workon)
  (keymap-set python-mode-map "C-c p" 'zanf-run-python))


(provide 'zan-keybindings)

