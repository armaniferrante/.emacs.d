(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Git porcelain.
(use-package magit
  :ensure t)

;; Backup files go into designated directory.
(setq backup-directory-alist `(("." . "~/.saves")))

(setq make-backup-files nil)

(use-package docker-tramp
  :ensure t)

;; Ensure we can use clipboard when doing copy/past commands from other apps.
(setq x-select-enable-clipboard t)

;; Remap "windows" key to be the meta key.
(setq x-super-keysym 'meta)

(setq backup-directory-alist '((".*" . "~/.Trash")))
(setq create-lockfiles nil)
