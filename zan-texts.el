(setq computer-systems-text "~/sync-general/texts/computer-systems-a-programmers-perspective.pdf")
(setq c-programming-text "~/sync-general/texts/the-c-programming-language.pdf")
(setq texts-directory "~/sync-general/texts/")

(defun zanf-open-text--get-text ()
  (completing-read "Which text? :" (directory-files texts-directory)))

(defun zanf-open-text ()
  (interactive)
  
