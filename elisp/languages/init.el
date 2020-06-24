;; Features for all programming modes.
(defun all-code-hooks ()
  ;; Max line length.
  (turn-on-auto-fill)
  ;; Add matching paren/bracket automatically.
  (autopair-mode)
  ;; Draw line at max line length.
  (fci-mode 1))

;; Register the mode hook.
(add-hook 'go-mode-hook 'all-code-hooks)
(add-hook 'c-mode-hook 'all-code-hooks)
(add-hook 'python-mode-hook 'all-code-hooks)
(add-hook 'rust-mode-hook 'all-code-hooks)
(add-hook 'js2-mode-hook 'all-code-hooks)
(add-hook 'typescript-mode-hook 'all-code-hooks)

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(load "~/.emacs.d/elisp/languages/rust.el")
(load "~/.emacs.d/elisp/languages/go.el")
(load "~/.emacs.d/elisp/languages/terraform.el")
(load "~/.emacs.d/elisp/languages/c.el")
(load "~/.emacs.d/elisp/languages/c++.el")
(load "~/.emacs.d/elisp/languages/solidity.el")
(load "~/.emacs.d/elisp/languages/python.el")
(load "~/.emacs.d/elisp/languages/react.el")
;(load "~/.emacs.d/elisp/languages/js.el")

(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
;; Highlight entire line for errors.
(set-face-attribute 'flycheck-error nil :background "red")
(set-face-attribute 'flycheck-error nil :foreground "white")

(use-package protobuf-mode
  :ensure t)

(use-package docker
	:ensure t)

(use-package dockerfile-mode
	:ensure t)

(use-package yaml-mode
	:ensure t)

(use-package lua-mode
	:ensure t)

(use-package scala-mode
	:ensure t)
