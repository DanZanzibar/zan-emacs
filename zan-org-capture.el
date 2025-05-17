;; -*- lexical-binding: t -*-
;; Org-mode-capture-templates

(require 'org-capture)
(setq org-directory "~/sync/gtd")
(setq org-agenda-entry-text-maxlines 20)
(setq org-refile-use-outline-path t)

(setq zanv-gtd (concat zanv-sync-dir "gtd/gtd.org"))
(setq org-agenda-files `(,zanv-gtd))


(defun zanf-gen-org-capture-template
    (key name &optional file parent-keys parent timestamp literal-heading)
  (let ((parent-keys (or parent-keys ""))
	(parent (or parent '()))
	(template (if timestamp "* TODO %u %?" "* TODO %?")))
    (list
     (concat parent-keys key)
     name
     'entry
     (append `(file+olp ,file) parent `(,(or literal-heading name)))
     template)))


(setq zanv-org-capture-templates-static
      `(("t" "Task Lists")
	,(zanf-gen-org-capture-template "a" "Anytime" zanv-gtd "t")
	,(zanf-gen-org-capture-template "d" "Daytime" zanv-gtd "t")
	,(zanf-gen-org-capture-template "e" "Evening" zanv-gtd "t")
	,(zanf-gen-org-capture-template "w" "Weekend" zanv-gtd "t")
	,(zanf-gen-org-capture-template "t" "Waiting" zanv-gtd "t" nil t)

	,(zanf-gen-org-capture-template "s" "Someday" zanv-gtd)
	("k" "Tickler" entry (file+olp zanv-gtd "Tickler")
	 "* TODO %? %^g\nSCHEDULED: %^t")

	("p" "Projects")

	("w" "Work Lists")
	("wv" "Potential Visits")
	,(zanf-gen-org-capture-template
	  "e" "Edmonton" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "c" "Calgary" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "v" "Vancouver" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "V" "Victoria" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "i" "Interior" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "s" "Saskatoon" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "r" "Regina" zanv-gtd "wv" '("Static" "Visits"))
	,(zanf-gen-org-capture-template
	  "w" "Winnipeg" zanv-gtd "wv" '("Static" "Visits"))

	("wp" "Prospects")
	,(zanf-gen-org-capture-template
	  "e" "Edmonton" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "c" "Calgary" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "v" "Vancouver" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "V" "Victoria" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "i" "Interior" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "s" "Saskatoon" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "r" "Regina" zanv-gtd "wp" '("Static" "Prospects"))
	,(zanf-gen-org-capture-template
	  "w" "Winnipeg" zanv-gtd "wp" '("Static" "Prospects"))

	,(zanf-gen-org-capture-template
	  "e" "Expense Reminders" zanv-gtd "w" '("Static") t)
	,(zanf-gen-org-capture-template
	  "n" "Name on Accounts" zanv-gtd "w" '("Static"))

	("l" "Other Lists")

	("n" "New Project or List")
	("np" "Project" entry (file+olp zanv-gtd "Projects")
	 "* %^{Project name}^p%^{Capture keys} :%^{tags}:")
	("nw" "Work List" entry (file+olp zanv-gtd "Dynamic")
	 "* %^{List name}^w%^{Capture keys} :%^{tags}:")
	("nl" "Other List" entry (file+olp zanv-gtd "Dynamic")
	 "* %^{List name}^l%^{Capture keys} :%^{tags}:")))


(defvar zanv-org-capture-templates-project
  '(("q" "Quick Tasks" entry ())))


(defun zanf-add-dynamic-capture-templates--get-gtd-headings (heading)
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

;; A more general function for files that are composed entirely of dynamically
;; generated heading through org-capture.
(defun zanf-add-dynamic-capture-templates--get-headings (file)
  (let (headings)
    (org-map-entries
     (lambda ()
       (push (substring-no-properties (org-get-heading t t t t)) headings))
     "LEVEL=1" `(,file))
    (nreverse headings)))

(defun zanf-add-dynamic-capture-templates (agenda-file &optional parent-heading)
  (let ((headings (if (string= agenda-file zanv-gtd)
		      (zanf-add-dynamic-capture-templates--get-gtd-headings
		       parent-heading)
		    (zanf-add-dynamic-capture-templates--get-headings agenda-file)))
	templates)
    (dolist (heading headings)
      (let* ((parsed-heading (split-string heading "\\^"))
	     (name (nth 0 parsed-heading))
	     (keys (nth 1 parsed-heading)))
	(push (zanf-gen-org-capture-template
	       keys name agenda-file nil `(,parent-heading) nil heading)
	      templates)))
    (setq templates (reverse templates))
    (setq org-capture-templates (append org-capture-templates templates))))


(defun zanf-set-org-capture-templates ()
  (setq org-capture-templates zanv-org-capture-templates-static)
  (zanf-add-dynamic-capture-templates zanv-gtd "Projects")
  (zanf-add-dynamic-capture-templates zanv-gtd "Dynamic"))


(provide 'zan-org-capture)
