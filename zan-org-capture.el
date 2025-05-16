;; -*- lexical-binding: t -*-
;; Org-mode-capture-templates

(require 'org-capture)
(setq org-directory "~/sync/gtd")
(setq org-agenda-entry-text-maxlines 20)
(setq org-refile-use-outline-path t)

(setq zanv-gtd (concat zanv-sync-dir "gtd/gtd.org"))
(setq org-agenda-files `(,zanv-gtd))


(defun zanf-gen-org-capture-template
    (key name &optional parent-keys parent timestamp literal-heading)
  (let ((parent-keys (or parent-keys ""))
	(parent (or parent '()))
	(template (if timestamp "* TODO %u %?" "* TODO %?")))
    (list
     (concat parent-keys key)
     name
     'entry
     (append '(file+olp zanv-gtd) parent `(,(or literal-heading name)))
     template)))


(setq zanv-org-capture-templates-static
      `(("t" "Task Lists")
	,(zanf-gen-org-capture-template "a" "Anytime" "t")
	,(zanf-gen-org-capture-template "d" "Daytime" "t")
	,(zanf-gen-org-capture-template "e" "Evening" "t")
	,(zanf-gen-org-capture-template "w" "Weekend" "t")
	,(zanf-gen-org-capture-template "t" "Waiting" "t" nil t)

	,(zanf-gen-org-capture-template "s" "Someday")
	("k" "Tickler" entry (file+olp zanv-gtd "Tickler")
	 "* TODO %? %^g\nSCHEDULED: %^t")

	("p" "Projects")

	("w" "Work Lists")
	("wv" "Potential Visits")
	,(zanf-gen-org-capture-template
	  "e" "Edmonton" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "c" "Calgary" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "v" "Vancouver" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "V" "Victoria" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "i" "Interior" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "s" "Saskatoon" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "r" "Regina" "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "w" "Winnipeg" "wv" '("Static" "Visits"))

	("wp" "Prospects")
	,(zanf-gen-org-capture-template
	  "e" "Edmonton" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "c" "Calgary" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "v" "Vancouver" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "V" "Victoria" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "i" "Interior" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "s" "Saskatoon" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "r" "Regina" "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "w" "Winnipeg" "wp" '("Static" "Prospects"))

	,(zanf-gen-org-capture-template
	  "e" "Expense Reminders" "w" '("Static") t)
	,(zanf-gen-org-capture-template
	  "n" "Name on Accounts" "w" '("Static"))

	("l" "Other Lists")

	("n" "New Project or List")
	("np" "Project" entry (file+olp zanv-gtd "Projects")
	 "* %^{Project name}^p%^{Capture keys} :%^{tags}:")
	("nw" "Work List" entry (file+olp zanv-gtd "Dynamic")
	 "* %^{List name}^w%^{Capture keys} :%^{tags}:")
	("nl" "Other List" entry (file+olp zanv-gtd "Dynamic")
	 "* %^{List name}^l%^{Capture keys} :%^{tags}:")))


(defun zanf-add-dynamic-capture-templates--get-subheadings (heading)
  (let (subheadings)
    (org-map-entries
     (lambda ()
       (when (string= (org-get-heading t t t t) heading)
	 (org-map-entries
	  (lambda ()
	    (push (substring-no-properties (org-get-heading t t t t))
		  subheadings))
	  "LEVEL=2"
	  'tree)))
     "LEVEL=1" 'agenda)
    (nreverse subheadings)))

(defun zanf-add-dynamic-capture-templates (parent-heading)
  (let ((headings (zanf-add-dynamic-capture-templates--get-subheadings
		   parent-heading))
	templates)
    (dolist (heading headings)
      (let* ((parsed-heading (split-string heading "\\^"))
	     (name (nth 0 parsed-heading))
	     (keys (nth 1 parsed-heading)))
	(push (zanf-gen-org-capture-template
	       keys name nil `(,parent-heading) nil heading)
	      templates)))
    (setq templates (reverse templates))
    (setq org-capture-templates (append org-capture-templates templates))))


(defun zanf-set-org-capture-templates ()
  (setq org-capture-templates zanv-org-capture-templates-static)
  (zanf-add-dynamic-capture-templates "Projects")
  (zanf-add-dynamic-capture-templates "Dynamic"))


(provide 'zan-org-capture)
