(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; git porcelain
(use-package magit
  :ensure t)

;; backup files go into designated directory
(setq backup-directory-alist `(("." . "~/.saves")))

(setq make-backup-files nil)

(use-package docker-tramp
  :ensure t)
