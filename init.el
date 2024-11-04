;; Add a directory for init modules
(add-to-list 'load-path "~/.emacs.d/zan-emacs")


;; Load init modules

(require 'zan-start-init)

(require 'zan-config-vars)

(require 'zan-functions)

(require 'zan-misc)

(require 'zan-ui)

(require 'zan-packages)

;; (require 'zan-email)

(require 'zan-org-capture)

(require 'zan-org-mode)

(require 'zan-prog)

(require 'zan-python)

(require 'zan-java)

(require 'zan-c)

(require 'zan-snippet)

(require 'zan-texts)

(require 'zan-keyboard-macros)

(require 'zan-general-kbds)
