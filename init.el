;; backup files go into designated directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; setup package sources
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; basic UI changes
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; always show line number
(global-linum-mode 1)

;; tabs as two spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)

;; highlight matching parens with no delay
(setq show-paren-delay 0)
(show-paren-mode 1)

;; create matching brackets/parenthesis automatically
(use-package autopair
  :ensure t)

;; easy window navigation
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)

;; features for all programming modes
(defun all-code-hooks ()
  ;; max line length 80 chars
  (turn-on-auto-fill)
  ;; add matching paren/bracket automatically
  (autopair-mode))

(add-hook 'go-mode-hook 'all-code-hooks)
(add-hook 'c-mode-hook 'all-code-hooks)
(add-hook 'c++-mode-hook 'all-code-hooks)
(add-hook 'python-mode-hook 'all-code-hooks)

(setq-default fill-column 80)

(use-package cyberpunk-theme
  :ensure t)

(use-package org-mode
  :ensure t)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; git porcelain
(use-package magit
  :ensure t)

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

(use-package gotest
  :ensure t)

;; Runs tests and code coverage everytime we save a file.
;; Note: I've made one adjustment to gotest.el:
;; Hardcode the --coverprofile= argument to always use the same
;; coverage output directory, so as not to prompt everytime you save.
(setq compilation-window-height 10)
(defun my-go-test-mode-hook ()
  ;; *Go Test* is the name of the buffer. See gotest.el.
  (when (not (get-buffer-window "*Go Test*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*Go Test*")
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'go-test-mode-hook 'my-go-test-mode-hook)

;; go get -u github.com/rogpeppe/godef/...
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'go-save-hook)
  ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun go-save-hook ()
  (when (eq major-mode 'go-mode)
    (gofmt-before-save)
    (go-test-current-coverage)))

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

;; switch between header/implementation files
(add-hook 'c-mode-common-hook
	  (lambda()
	        (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python

;; dependency: sudo pip install virtualenv
;;             jedi: install-server
(use-package jedi
  :ensure t)

(defun my-python-mode-hook ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-*") 'jedi:goto-definition-pop-marker)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;
;; shell

;; open shell in same window
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Goodies

(use-package nyan-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(package-selected-packages
   (quote
    (org-mode yasnippet which-key w3m use-package try sublime-themes solidity-mode org-link-minor-mode nyan-mode magit load-theme-buffer-local jedi go-guru go-autocomplete ggtags flymake-solidity flycheck exec-path-from-shell cyberpunk-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
