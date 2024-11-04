;; Storing all kbd's here.


;; Set up 'zan-extra-keymap' for one extra level of prefix key 'k'. The prefix
;; key should be used for most global keybindings and reserve "C-c letter"
;; bindings for major-mode specific bindings.
(define-prefix-command 'zan-extra-keymap)
(keymap-global-set "C-c k" 'zan-extra-keymap)


;; Since I'm using emacsclient typically, set this keybinding to terminate the
;; entire daemon.
(keymap-global-set "C-x C-c" 'save-buffers-kill-emacs)


;; Globals
(keymap-global-set "C-c k C-k" 'zanf-kill-to-end-of-buffer)
(keymap-global-set "C-c k C-s" 'zanf-scratch-buffer)
(keymap-global-set "C-x r m" 'zanf-bookmark-set)
(keymap-global-set "C-c k s" 'zanf-snippet-insert-at-point)
(keymap-global-set "C-c k o" 'zanf-open-text)


;; General Prog-mode
(keymap-set prog-mode-map "C-c k n" 'flymake-goto-next-error)
(keymap-set prog-mode-map "C-c k c" 'comment-region)
(keymap-set prog-mode-map "C-c k u" 'uncomment-region)


;; Magit
(keymap-global-set "C-c k m" 'magit-list-repositories)


;; Org
(keymap-global-set "C-c k k" 'org-capture)
(keymap-global-set "C-c k a" 'org-agenda)
(with-eval-after-load 'org-agenda
  (keymap-set org-agenda-mode-map "C-k" 'zanf-org-agenda-kill)
  (keymap-set org-agenda-mode-map "C-c C-q" 'zanf-org-agenda-refile)
  (keymap-set org-agenda-mode-map "z" 'zanf-org-agenda-add-note)
  (keymap-set org-agenda-mode-map "q" 'zanf-org-agenda-quit))


;; Eglot - gets its own prefix key 'e'
(define-prefix-command 'zan-eglot-keymap)
(keymap-set prog-mode-map "C-c e" 'zan-eglot-keymap)
(keymap-set prog-mode-map "C-c e e" 'eglot)
(keymap-set prog-mode-map "C-c e C-e" 'eglot-reconnect)
(keymap-set prog-mode-map "C-c e r" 'eglot-rename)
(keymap-set prog-mode-map "C-c e f" 'eglot-format-buffer)
(keymap-set prog-mode-map "C-c e c" 'eglot-code-actions)
(keymap-set prog-mode-map "C-c e x" 'eglot-code-action-extract)


;; Zeal
(keymap-set prog-mode-map "C-c z" 'zeal-at-point)


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


;; Open textbooks.
(keymap-global-set "C-c k t" 'zanf-open-text)
(keymap-global-set "C-c k p" 'zanf-open-pricelist)


(provide 'zan-general-kbds)
