;; Org-mode-capture-templates

(setq org-directory "~/sync/gtd")
(setq org-agenda-entry-text-maxlines 20)
(setq org-refile-use-outline-path t)

(setq zanv-gtd (concat zanv-sync-dir "gtd/gtd.org"))
(setq org-agenda-files `(,zanv-gtd))


(setq zanv-org-capture-templates-static
      '())

(defun zanf-gen-org-capture-template (parent parent-keys name key)
  (list
   (concat parent-keys key)
   name
   entry
   (file+olp zanv-gtd )))

(defun zanf-set-org-capture-templates ()
  )


(setq org-capture-templates
      '(("g" "Templates for gtd")
	
	("ga"
	 "Anytime"
	 entry
	 (file+headline zanv-gtd "Anytime")
	 "* TODO %?")
	
	("gd"
	 "Daytime"
	 entry
	 (file+headline zanv-gtd "Daytime")
	 "* TODO %?")
	
	("gp"
	 "Personal"
	 entry
	 (file+headline zanv-gtd "Personal")
	 "* TODO %?")
	
	("gw"
	 "Waiting"
	 entry
	 (file+headline zanv-gtd "Waiting")
	 "* TODO %u %?")
	
	("gh"
	 "Home"
	 entry
	 (file+headline zanv-gtd "Home")
	 "* TODO %?")
	
	("ge"
	 "Errands"
	 entry
	 (file+headline zanv-gtd "Errands")
	 "* Todo %?")
	
	("gc"
	 "Casi"
	 entry
	 (file+headline zanv-gtd "Casi")
	 "* TODO %?")
	
	("gD"
	 "Dave"
	 entry
	 (file+headline zanv-gtd "Dave")
	 "* TODO %?")

	("gn"
	 "Name on Accounts"
	 entry
	 (file+headline zanv-gtd "Name on Accounts")
	 "* TODO %?")

	("gt"
	 "Tickler"
	 entry
	 (file+headline zanv-gtd "Tickler")
	 "* TODO %? %^g\nSCHEDULED: %^t")

	("gs"
	 "Someday"
	 entry
	 (file+headline zanv-gtd "Someday")
	 "* TODO %?")

	("gv" "Potential Visits")
	("gve"
	 "Edmonton"
	 entry
	 (file+olp zanv-gtd "Visits" "Edmonton")
	 "* TODO %?")
	("gvc"
	 "Calgary"
	 entry
	 (file+olp zanv-gtd "Visits" "Calgary")
	 "* TODO %?")
	("gvv"
	 "Vancouver"
	 entry
	 (file+olp zanv-gtd "Visits" "Vancouver")
	 "* TODO %?")
	("gvV"
	 "Victoria"
	 entry
	 (file+olp zanv-gtd "Visits" "Victoria")
	 "* TODO %?")
	("gvi"
	 "Interior"
	 entry
	 (file+olp zanv-gtd "Visits" "Interior")
	 "* TODO %?")
	("gvs"
	 "Saskatoon"
	 entry
	 (file+olp zanv-gtd "Visits" "Saskatoon")
	 "* TODO %?")
	("gvr"
	 "Regina"
	 entry
	 (file+olp zanv-gtd "Visits" "Regina")
	 "* TODO %?")
	("gvw"
	 "Winnipeg"
	 entry
	 (file+olp zanv-gtd "Visits" "Winnipeg")
	 "* TODO %?")

	("gP" "Prospects")
	("gPe"
	 "Edmonton"
	 entry
	 (file+olp zanv-gtd "Prospects" "Edmonton")
	 "* TODO %?")
	("gPc"
	 "Calgary"
	 entry
	 (file+olp zanv-gtd "Prospects" "Calgary")
	 "* TODO %?")
	("gPv"
	 "Vancouver"
	 entry
	 (file+olp zanv-gtd "Prospects" "Vancouver")
	 "* TODO %?")
	("gPV"
	 "Victoria"
	 entry
	 (file+olp zanv-gtd "Prospects" "Victoria")
	 "* TODO %?")
	("gPi"
	 "Interior"
	 entry
	 (file+olp zanv-gtd "Prospects" "Interior")
	 "* TODO %?")
	("gPs"
	 "Saskatoon"
	 entry
	 (file+olp zanv-gtd "Prospects" "Saskatoon")
	 "* TODO %?")
	("gPr"
	 "Regina"
	 entry
	 (file+olp zanv-gtd "Prospects" "Regina")
	 "* TODO %?")
	("gPw"
	 "Winnipeg"
	 entry
	 (file+olp zanv-gtd "Prospects" "Winnipeg")
	 "* TODO %?")

	("gE"
	 "Expense Reminders"
	 entry
	 (file+headline zanv-gtd "Expense Reminders")
	 "* TODO %u %?")))


(provide 'zan-org-capture)
