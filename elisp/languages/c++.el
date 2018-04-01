;; Auto completion
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; on the fly syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; snippets and snippet expansion
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))


;; tags for code navigation
;; must run sudo apt-get install global
(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		(ggtags-mode 1))))
  )

;; switch between header/implementation files
(add-hook 'c-mode-common-hook
	  (lambda()
	        (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
