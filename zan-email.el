(require 'sendmail)

;; This is the MU4E email client
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")

(require 'mu4e)

(setq user-full-name "Zan Owsley")
(setq shr-use-colors nil)
(setq shr-use-fonts nil)
(setq mu4e-completing-read-function 'completing-read)
(setq mu4e-view-show-images t)
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-update-interval 300)
(setq mu4e-headers-sort-direction 'ascending)

(setq send-mail-function 'smtpmail-send-it)

(setq mu4e-compose-context-policy "ask-if-none")
(setq mu4e-contexts
      `(,(make-mu4e-context
	  :name "work"
	  :enter-func (lambda () (mu4e-message "Entering WORK"))
	  :leave-func (lambda () (mu4e-message "Leaving WORK"))
	  :match-func (lambda (msg)
			(when msg
			  (or
			  (mu4e-message-contact-field-matches
			   msg :to "zowsley@electro-meters.com"))))
	  :vars '((user-mail-address . "zowsley@electro-meters.com")
		  (mu4e-sent-folder . "/work/Sent Items")
		  (mu4e-drafts-folder . "/work/Drafts")
		  (mu4e-trash-folder . "/work/Trash")
		  (mu4e-refile-folder . "/work/Archive")
		  (smtpmail-smtp-server . "localhost")
		  (smtpmail-stream-type . nil)
		  (smtpmail-smtp-service . 1025)
		  (smtpmail-queue-mail . nil)
		  (mu4e-maildir-shortcuts . ((:maildir "/work/INBOX" :key ?i)
					     (:maildir "/work/Sent Items" :key ?s)
					     (:maildir "/work/Drafts" :key ?d)
					     (:maildir "/work/Trash" :key ?t)
					     (:maildir "/work/Archive" :key ?a)))
		  ))
	,(make-mu4e-context
	  :name "home"
	  :enter-func (lambda () (mu4e-message "Entering HOME"))
	  :leave-func (lambda () (mu4e-message "Leaving HOME"))
	  :match-func (lambda (msg)
			(when msg
			  (mu4e-message-contact-field-matches
			   msg :to "zanowsley@gmail.com")))
	  :vars `((user-mail-address . "zanowsley@gmail.com")
		  (mu4e-sent-folder . "/personal/[Gmail].Sent Mail")
		  (mu4e-drafts-folder . "/personal/[Gmail].Drafts")
		  (mu4e-trash-folder . "/personal/[Gmail].Trash")
		  (mu4e-refile-folder . "/personal/Archives")
		  (smtpmail-default-smtp-server . "smtp.gmail.com")
		  (smtpmail-smtp-server . "smtp.gmail.com")
		  (smtpmail-stream-type . ssl)
		  (smtpmail-smtp-service . 465)
		  (smtpmail-queue-mail . nil)
		  (mu4e-maildir-shortcuts . ((:maildir "/personal/INBOX" :key ?i)
					     (:maildir "/personal/[Gmail].Sent Mail" :key ?s)
					     (:maildir "/personal/[Gmail].Drafts" :key ?d)
					     (:maildir "/personal/[Gmail].Trash" :key ?t)
					     (:maildir "/personal/Archives" :key ?a)))
		  ))))

(define-key global-map (kbd "C-c m") 'mu4e)


(provide 'zan-email)
