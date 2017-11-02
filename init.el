(setq inhibit-startup-message t)

;; spaces not tabs
(setq-default indent-tabs-mode nil)

;; .h files are c++ mode by defualt, not c mode
(add-to-list 'auto-mode-alist '("//.h//'" . c++-mode))

;; always show line number
(global-linum-mode 1)

;; Setup package sources
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(require 'package)
(add-to-list 'package-archives
               '("melpa2" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

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

;; Theme
;(use-package sublime-themes :ensure t)
;;(use-package spol
;;(use-package monokai-theme :ensure t)
;(use-package color-theme
;  :ensure t)
;(use-package moe-theme
;  :ensure t)
;(moe-light)

;; small interface tweaks
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; switch between header/implementation files
(add-hook 'c-mode-common-hook
	  (lambda()
	        (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; speedbar
;;(require 'sr-speedbar)
;;(setq sr-speedbar-right-side nil)
;;(sr-speedbar-open)
;;(with-current-buffer sr-speedbar-buffer-name
;;  (setq window-size-fixed 'width))
;;(semantic-mode)


(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Go Mode

;; set GOPATH

;; First Run M-x package-install and enter go-mode

;; - Go Doc (M-x godoc)

;; 0) Terminal command: go get golang.org/x/tools/cmd/...
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

(setenv "GOPATH" "/home/armaniferrante/Documents/code/")

;; - Godef
;; M-x godef-jump and M-* to go back
;; go get github.com/rogpeppe/godef

(defun my-go-mode-hook ()
                                        ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
                                        ; Godef jump key binding
  ;; Go Guru
;  (load-file "$GOPATH/src/golang.org/x/tools/cmd/guru/guru.el")
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; autocomplete

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

;; go-autocomplete

;; go get -u github.com/nsf/gocode
(with-eval-after-load 'go-mode
     (require 'go-autocomplete))

;; function call hierarchy
;; go get golang.org/x/tools/cmd/guru


;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'spolsky t)

;; required footer?
(provide 'init)
