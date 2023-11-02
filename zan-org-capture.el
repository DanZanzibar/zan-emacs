;; Org-mode-capture-templates

(setq org-directory "~/orghome")
(setq org-agenda-entry-text-maxlines 10)
(setq org-refile-use-outline-path t)

(setq org-agenda-files '("~/sync-general/gtd/gtd.org"))
(setq zan-gtd "~/sync-general/gtd/gtd.org")

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
	
	("gd"
	 "Daytime"
	 entry
	 (file+headline zan-gtd "Daytime")
	 "* TODO %?")
	
	("gp"
	 "Personal"
	 entry
	 (file+headline zan-gtd "Personal")
	 "* TODO %?")
	
	("gw"
	 "Waiting"
	 entry
	 (file+headline zan-gtd "Waiting")
	 "* TODO %u %?")
	
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

	("gt"
	 "Tickler"
	 entry
	 (file+headline zan-gtd "Tickler")
	 "* TODO %? %^g\nSCHEDULED: %^t")

	("gs"
	 "Someday"
	 entry
	 (file+headline zan-gtd "Someday")
	 "* TODO %?")

	("gv" "Potential Visits")

	("gve"
	 "Edmonton"
	 entry
	 (file+olp zan-gtd "Visits" "Edmonton")
	 "* TODO %?")

	("gvc"
	 "Calgary"
	 entry
	 (file+olp zan-gtd "Visits" "Calgary")
	 "* TODO %?")

	("gvv"
	 "Vancouver"
	 entry
	 (file+olp zan-gtd "Visits" "Vancouver")
	 "* TODO %?")

	("gvV"
	 "Victoria"
	 entry
	 (file+olp zan-gtd "Visits" "Victoria")
	 "* TODO %?")

	("gvi"
	 "Interior"
	 entry
	 (file+olp zan-gtd "Visits" "Interior")
	 "* TODO %?")

	("gvs"
	 "Saskatoon"
	 entry
	 (file+olp zan-gtd "Visits" "Saskatoon")
	 "* TODO %?")

	("gvr"
	 "Regina"
	 entry
	 (file+olp zan-gtd "Visits" "Regina")
	 "* TODO %?")

	("gvw"
	 "Winnipeg"
	 entry
	 (file+olp zan-gtd "Visits" "Winnipeg")
	 "* TODO %?")

	("gP" "Potential Prospects")

	("gPe"
	 "Edmonton"
	 entry
	 (file+olp zan-gtd "Prospects" "Edmonton")
	 "* TODO %?")

	("gPc"
	 "Calgary"
	 entry
	 (file+olp zan-gtd "Prospects" "Calgary")
	 "* TODO %?")

	("gPv"
	 "Vancouver"
	 entry
	 (file+olp zan-gtd "Prospects" "Vancouver")
	 "* TODO %?")

	("gPV"
	 "Victoria"
	 entry
	 (file+olp zan-gtd "Prospects" "Victoria")
	 "* TODO %?")

	("gPi"
	 "Interior"
	 entry
	 (file+olp zan-gtd "Prospects" "Interior")
	 "* TODO %?")

	("gPs"
	 "Saskatoon"
	 entry
	 (file+olp zan-gtd "Prospects" "Saskatoon")
	 "* TODO %?")

	("gPr"
	 "Regina"
	 entry
	 (file+olp zan-gtd "Prospects" "Regina")
	 "* TODO %?")

	("gPw"
	 "Winnipeg"
	 entry
	 (file+olp zan-gtd "Prospects" "Winnipeg")
	 "* TODO %?")
	
	))

(provide 'zan-org-capture)
