;; -*- lexical-binding: t -*-
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


;;; A macro for adding keybindings to modes via mode hooks.
(defmacro zanm-keybindings-for-mode (mode mode-map kbd-commands)
  "Define a function to set keybindings for a major mode and add it to the mode's hook.

MODE is the mode symbol (e.g., 'java-mode).
MODE-MAP is the keymap variable (e.g., `java-mode-map`).
KBD-COMMANDS is a list of keybinding-command pairs. (e.g. ((\"C-c c\" 'some-function)))

Each keybinding is applied using `keymap-set` when the major mode is activated.
The generated function is named `zanf-keybindings-MODE` and is automatically
added to `MODE-hook`."
  (let ((function-symbol (intern (format "zanf-keybindings-%s" mode)))
	(hook-symbol (intern (format "%s-hook" mode))))
    `(progn
       (defun ,function-symbol ()
	 (dolist (kbd-command ',kbd-commands)
	   (keymap-set ,mode-map (car kbd-command) (cadr kbd-command))))
       (add-hook ',hook-symbol #',function-symbol))))


(defmacro zanm-keybindings-for-multiple-modes (modes-and-maps kbd-commands)
  "Apply the same keybindings to multiple major modes using `zanm-keybindings-for-mode`.

MODES-AND-MAPS is an alist mapping the mode to the mode-map.
  e.g. ((java-mode . java-mode-map) (java-ts-mode . java-ts-mode-map))
KBD-COMMANDS is a list of keybinding-command pairs. (e.g. ((\"C-c c\" 'some-function)))"
  `(progn
     ,@(mapcar (lambda (mode-and-map)
		 `(zanm-keybindings-for-mode
		   ,(car mode-and-map) ,(cdr mode-and-map) ,kbd-commands))
		 modes-and-maps)))


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
(keymap-global-set "C-x p d" 'zanf-project-dired)

;; Org-mode changes.
(zanm-keybindings-for-mode org-agenda-mode org-agenda-mode-map
			   (("k" zanf-org-capture--from-agenda)
			    ("C-k" zanf-org-agenda-kill)
			    ("C-c C-q" zanf-org-agenda-refile)
			    ("z" zanf-org-agenda-add-note)
			    ("q" zanf-org-agenda-quit)))


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

;; Org-roam keys.
(define-prefix-command 'zan-org-roam-keymap)
(keymap-global-set "C-c r" 'zan-org-roam-keymap)
(keymap-set zan-org-roam-keymap "f" 'org-roam-node-find)
(keymap-set zan-org-roam-keymap "b" 'org-roam-buffer-toggle)
(keymap-set zan-org-roam-keymap "i" 'org-roam-node-insert)

;; C
(zanm-keybindings-for-multiple-modes
 ((c-mode . c-mode-map)
  (c-ts-mode . c-ts-mode-map))
 (("C-c c" zanf-compile-c)
  ("C-c r" zanf-compile-and-run-c)))


;; Java
(zanm-keybindings-for-multiple-modes
 ((java-mode . java-mode-map)
  (java-ts-mode . java-ts-mode-map))
 (("C-c c" zanf-java-compile-all)
  ("C-c r" zanf-java-run-project-file)))


;; Python
(zanm-keybindings-for-multiple-modes
 ((python-mode . python-mode-map)
  (python-ts-mode . python-ts-mode-map))
 (("C-c v" pyvenv-workon)
  ("C-c p" zanf-run-python)))


;;; Other modes.

;; PDF-View
(zanm-keybindings-for-mode pdf-view-mode pdf-view-mode-map
			   (("q" zanf-pdf-view-quit) ; prompts for bookmark
			    ("C-c x" doc-toc-extract-pages)))


(provide 'zan-keybindings)
