;; Org-mode-capture-templates

(setq org-directory "~/orghome")
(setq rmt "/ssh:zan@zan-desktop.freeddns.org:")

(if (string= system-name "zan-desktop-linux")
    (setq org-agenda-files '("~/orghome/")
	  gtd "~/orghome/gtd.org")
    (setq org-agenda-files `(,(concat rmt "orghome/"))
	  gtd (concat rmt "orghome/gtd.org")))

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-capture-templates
      '(
	("g" "Templates for gtd")
	("gu"
	 "Urgent"
	 entry
	 (file+headline gtd "Urgent")
	 "* TODO %?")
	("ga"
	 "Anytime"
	 entry
	 (file+headline gtd "Anytime")
	 "* TODO %?")
	("gd"
	 "Daytime"
	 entry
	 (file+headline gtd "Daytime")
	 "* TODO %?")
	("gp"
	 "Personal"
	 entry
	 (file+headline gtd "Personal")
	 "* TODO %?")
	("gh"
	 "Home"
	 entry
	 (file+headline gtd "Home")
	 "* TODO %?")
	("ge"
	 "Errands"
	 entry
	 (file+headline gtd "Errands")
	 "* TODO %?")
	("gc"
	 "Casi"
	 entry
	 (file+headline gtd "Casi")
	 "* TODO %?")
	("gD"
	 "Dave"
	 entry
	 (file+headline gtd "Dave")
	 "* TODO %?")
	("gP"
	 "Prot"
	 entry
	 (file+headline gtd "Prot")
	 "* TODO %?")))

(provide 'zan-org-capture)
