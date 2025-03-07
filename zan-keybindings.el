;;;; Storing all key bindings here. Makes it easier to see if there are any
;;;; conflicts.
;;;;
;;;; My conventions for key bindings:
;;;; 1. Unless redefining an existing command, only use 'C-c letter ...' for
;;;; new key bindings.
;;;; 2. Global keybinding should use 'C-c k' prefix followed by an
;;;; mnemonically appropriate letter.
;;;; 3. Once the final letter is chosen (ex. 'a'), use 'a', 'A', or
;;;; 'C-a' (do not use 'C-A') in that order of preference. The most
;;;; popular command should use the most preferential choice.
;;;; 4. Try to use other 'C-c letter' prefix keys for groups of
;;;; commands to keep many 'C-c letter' key bindings available for
;;;; major-mode bindings. In general, only major-mode specific key
;;;; bindings should utlize many 'C-c letter' bindings.


;;; A macro for combining 'with-eval-after-load' and 'keymap-set'.
(defmacro zanm-with-eval-keymap-set (mode keymap kbd command)
  `(with-eval-after-load ',mode
     (keymap-set ,keymap ,kbd ',command)))


;;; Zan's globals: begin with 'C-c k'. 'k' for global KEYS.
(define-prefix-command 'zan-global-keymap)
(keymap-global-set "C-c k" 'zan-global-keymap)
(keymap-set zan-global-keymap "s" 'zanf-snippet-insert-at-point)
(keymap-set zan-global-keymap "S" 'zanf-scratch-buffer)
(keymap-set zan-global-keymap "t" 'zanf-open-text)
(keymap-set zan-global-keymap "p" 'zanf-open-pricelist)
(keymap-set zan-global-keymap "m" 'magit-list-repositories)
(keymap-set zan-global-keymap "k" 'zanf-org-capture)
(keymap-set zan-global-keymap "a" 'org-agenda)
(keymap-set zan-global-keymap "f" 'zanf-insert-filename)
(keymap-set zan-global-keymap "d" 'zanf-dired-right-side-window)
(keymap-set zan-global-keymap "w" 'window-toggle-side-windows)
(keymap-set zan-global-keymap "b" 'zanf-toggle-user-display-buffer-alist)
(keymap-set zan-global-keymap "e" 'eshell)


;;; Emacs commands that I have redefined and shadowed with my own functions.
(keymap-global-set "C-x C-c" 'save-buffers-kill-emacs)  ; ends daemon
(keymap-global-set "C-x r m" 'zanf-bookmark-set) ; saves bookmark file
(zanm-with-eval-keymap-set
 pdf-view-mode pdf-view-mode-map "q" zanf-pdf-view-quit) ; prompts for bookmark

;; Org-mode changes.
(with-eval-after-load 'org-agenda
  (keymap-set org-agenda-mode-map "k" 'zanf-org-capture)
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


;; C
(with-eval-after-load 'c-mode
  (keymap-set c-mode-map "C-c c" 'zanf-compile-c)
  (keymap-set c-mode-map "C-c r" 'zanf-compile-and-run-c))


;; Java
(with-eval-after-load 'java-mode
  (keymap-set eglot-java-mode-map "C-c c" 'zanf-java-compile-all)
  (keymap-set eglot-java-mode-map "C-c r" 'zanf-java-run))


;; Python
(with-eval-after-load 'python
  (keymap-set python-mode-map "C-c v" 'pyvenv-workon)
  (keymap-set python-mode-map "C-c p" 'zanf-run-python))


;;; Other modes.

;; PDF-View
(keymap-set pdf-view-mode-map "C-c x" 'doc-toc-extract-pages)


(provide 'zan-keybindings)
