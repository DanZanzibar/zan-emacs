;; -*- lexical-binding: t -*-
;; Storing all kbd's here.


;; Set up 'zan-global-keymap' for one extra level of prefix key 'C-c g'. The prefix
;; key should be used for most global keybindings and reserve "C-c letter"
;; bindings for major-mode specific bindings or other prefix keys.
(define-prefix-command 'zan-global-keymap)
(keymap-global-set "C-c g" 'zan-global-keymap)


;; Since I'm using emacsclient typically, set this keybinding to terminate the
;; entire daemon.
(keymap-global-set "C-x C-c" 'save-buffers-kill-emacs)


;; Globals
(keymap-set zan-global-keymap "C-s" 'zanf-scratch-buffer)
(keymap-global-set "C-x r m" 'zanf-bookmark-set)
(keymap-set zan-global-keymap "s" 'zanf-snippet-insert-at-point)
(keymap-set zan-global-keymap "t" 'zanf-open-text)
(keymap-set zan-global-keymap "p" 'zanf-open-pricelist)
(keymap-global-set "C-c k m" 'magit-list-repositories)


;; General Prog-mode
(define-prefix-command 'zan-prog-general-keymap)
(keymap-set prog-mode-map "C-c g" 'zan-prog-general-keymap)
(keymap-set zan-prog-general-keymap "n" 'flymake-goto-next-error)
(keymap-set zan-prog-general-keymap "c" 'comment-region)
(keymap-set zan-prog-general-keymap "u" 'uncomment-region)


;; Org - NEED TO FIX
(keymap-global-set "C-c k k" 'org-capture)
(keymap-global-set "C-c k a" 'org-agenda)
(with-eval-after-load 'org-agenda
  (keymap-set org-agenda-mode-map "C-k" 'zanf-org-agenda-kill)
  (keymap-set org-agenda-mode-map "C-c C-q" 'zanf-org-agenda-refile)
  (keymap-set org-agenda-mode-map "z" 'zanf-org-agenda-add-note)
  (keymap-set org-agenda-mode-map "q" 'zanf-org-agenda-quit))


;; Eglot - gets its own prefix key 'C-c e'.
(define-prefix-command 'zan-eglot-keymap)
(keymap-set prog-mode-map "C-c e" 'zan-eglot-keymap)
(keymap-set zan-eglot-keymap "e" 'eglot)
(keymap-set zan-eglot-keymap "C-e" 'eglot-reconnect)
(keymap-set zan-eglot-keymap "r" 'eglot-rename)
(keymap-set zan-eglot-keymap "f" 'eglot-format-buffer)
(keymap-set zan-eglot-keymap "c" 'eglot-code-actions)
(keymap-set zan-eglot-keymap "x" 'eglot-code-action-extract)


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


(provide 'zan-general-kbds)

