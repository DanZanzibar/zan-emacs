;; Org-mode-capture-templates

(setq org-directory "~/orghome")
(setq org-agenda-entry-text-maxlines 10)

(defvar zan-desktop "/ssh:zan@zan-desktop.freeddns.org:")

(if (string= system-name "zan-desktop-linux")
    (progn 
      (setq org-agenda-files '("~/orghome/"))
      (defvar zan-gtd "~/orghome/gtd.org"))
    (progn
      (setq org-agenda-files `(,(concat zan-desktop "orghome/")))
      (defvar zan-gtd (concat zan-desktop "orghome/gtd.org"))))

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-capture-templates
      '(
	("g" "Templates for gtd")
	("gu"
	 "Urgent"
	 entry
	 (file+headline zan-gtd "Urgent")
	 "* TODO %?")
	("ga"
	 "Anytime"
	 entry
	 (file+headline zan-gtd "Anytime")
	 "* TODO %?")
	("gd" "Daytime")
	("gda"
	 "Add Attachment"
	 entry
	 (file+headline zan-gtd "Daytime")
	 "* TODO %a %?")
	("gdn"
	 "None"
	 entry
	 (file+headline zan-gtd "Daytime")
	 "* TODO %?")
	("gp"
	 "Personal"
	 entry
	 (file+headline zan-gtd "Personal")
	 "* TODO %?")
	("gh"
	 "Home"
	 entry
	 (file+headline zan-gtd "Home")
	 "* TODO %?")
	("ge"
	 "Errands"
	 entry
	 (file+headline zan-gtd "Errands")
	 "* Todo %?")
	("gc"
	 "Casi"
	 entry
	 (file+headline zan-gtd "Casi")
	 "* TODO %?")
	("gD"
	 "Dave"
	 entry
	 (file+headline zan-gtd "Dave")
	 "* TODO %?")
	("gP"
	 "Prot"
	 entry
	 (file+headline zan-gtd "Prot")
	 "* TODO %?")))

(provide 'zan-org-capture)
