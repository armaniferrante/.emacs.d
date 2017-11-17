;; backup files go into designated directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Setup package sources
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Basic UI changes
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; always show line number
(global-linum-mode 1)

;; tabs as two spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)

;; switch between header/implementation files
(add-hook 'c-mode-common-hook
	  (lambda()
	        (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; highlight matching parens with no delay
(setq show-paren-delay 0)
(show-paren-mode 1)

;; autofill
(add-hook 'go-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 100)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package sublime-themes
  :ensure t)
;(load-theme 'spolsky t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Go

(use-package go-mode
  :ensure t)
(setenv "GOPATH" "/Users/armaniferrante/Documents/code/")

;; 0)go get golang.org/x/tools/cmd/...
;;    - installs go doc and others
;; 1) First run M-x package-install and enter exec-path-from-shell
;; 2) Then add this
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GOPATH")

(use-package go-guru
  :ensure t)

;; go get -u github.com/rogpeppe/godef/...
(defun my-go-mode-hook ()
  ; gofmt on save
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; autocomplete

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

;; go-autocomplete

(use-package go-autocomplete
  :ensure t)

;; go get -u github.com/nsf/gocode
(with-eval-after-load 'go-mode
     (require 'go-autocomplete))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solidity

(use-package solidity-mode
  :ensure t)

(use-package flymake-solidity
  :ensure t)

;; this probably isn't needed because of use-package
(require 'flymake-solidity)
(add-hook 'find-file-hook 'flymake-solidity-maybe-load)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c++

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

;;;;;;;;;;;;;;;;;;;;;;;;
;; Ediff settings

;; ignore space, split side by side, prevent popup
(custom-set-variables
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain)))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Goodies

;(use-package nyan-mode
;  :ensure t)
;(nyan-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" default)))
 '(package-selected-packages
   (quote
    (exec-path-from-shell ggtags yasnippet flycheck auto-complete which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
