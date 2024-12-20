;; Org-mode-capture-templates

(setq org-directory "~/sync/gtd")
(setq org-agenda-entry-text-maxlines 20)
(setq org-refile-use-outline-path t)

(setq zan-gtd (concat zanv-sync-dir "gtd/gtd.org"))
(setq org-agenda-files `(,zan-gtd))


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

	("gn"
	 "Name on Accounts"
	 entry
	 (file+headline zan-gtd "Name on Accounts")
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

	("gP"
	 "Prospects"
	 entry
	 (file+headline zan-gtd "Prospects")
	 "* TODO %?")

	("gE"
	 "Expense Reminders"
	 entry
	 (file+headline zan-gtd "Expense Reminders")
	 "* TODO %u %?")))


(provide 'zan-org-capture)
