;; features for all programming modes
(defun all-code-hooks ()
  ;; max line length 80 chars
  (turn-on-auto-fill)
  ;; add matching paren/bracket automatically
  (autopair-mode)
  ;; line at 80 chars
  (fci-mode 1))

(add-hook 'go-mode-hook 'all-code-hooks)
(add-hook 'c-mode-hook 'all-code-hooks)
(add-hook 'python-mode-hook 'all-code-hooks)
(add-hook 'rust-mode-hook 'all-code-hooks)
(add-hook 'js2-mode-hook 'all-code-hooks)
(add-hook 'typescript-mode-hook 'all-code-hooks)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(load "~/.emacs.d/elisp/languages/rust.el")
(load "~/.emacs.d/elisp/languages/go.el")
(load "~/.emacs.d/elisp/languages/terraform.el")
(load "~/.emacs.d/elisp/languages/c++.el")
(load "~/.emacs.d/elisp/languages/solidity.el")
(load "~/.emacs.d/elisp/languages/python.el")
(load "~/.emacs.d/elisp/languages/react.el")
;(load "~/.emacs.d/elisp/languages/js.el")

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

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
