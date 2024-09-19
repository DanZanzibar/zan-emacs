;; Add a directory for init modules
(add-to-list 'load-path "~/.emacs.d/zan-emacs")


;; Load init modules

(require 'zan-start-init)

(require 'zan-misc)

(require 'zan-ui)

(require 'zan-packages)

;; (require 'zan-email)

(require 'zan-school)

(require 'zan-org-capture)

(require 'zan-org-functions)

(require 'zan-editing-functions)

(require 'zan-prog)

(require 'zan-python)

(require 'zan-snippet)

(require 'zan-java)

(require 'zan-texts)

(require 'zan-c)

(require 'zan-keyboard-macros)

(require 'zan-general-kbds)
