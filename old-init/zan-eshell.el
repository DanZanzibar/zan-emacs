;; -*- lexical-binding: t -*-
;;;; All my eshell stuff.

;;; Require eshell so the modules can load properly.
(require 'eshell)
(add-to-list 'eshell-modules-list 'eshell-elecslash)


;;; Set aliases to sync directory.
(setq eshell-aliases-file (concat zanv-emacs-dat-dir "eshell/alias"))


(provide 'zan-eshell)
