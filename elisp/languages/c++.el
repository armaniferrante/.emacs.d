;; CMake syntax highlighting.
(use-package cmake-mode
	:ensure t)

;; Auto completion.
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; Snippets and snippet expansion.
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; Tags for code navigation. Run
;; * `sudo apt-get install global`
;; * `gtags` when the current directory is at your project root
;; before using.
(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
		(ggtags-mode 1))))
  )

;; Switch between header/implementation files.
(add-hook 'c-mode-common-hook
	  (lambda()
			(local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; Tell company where the headers are.
;(add-to-list 'company-c-headers-path-system "/usr/include/c++/7.4.0/")

(use-package clang-format
	:ensure t)

;; Flycheck will use the .clang-tidy configuration.
(use-package flycheck-clang-tidy
  :after flycheck
  :hook
  (flycheck-mode . flycheck-clang-tidy-setup)
  )

;; Format on save.
;; Make sure to install clang format first, i.e., run
;; `sudo apt-get install clang-format`.
(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (clang-format-buffer)))
(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

;; Setup hooks into cmode.
(defun my-c++-mode-hook ()
	(add-hook 'c-mode-common-hook 'my-c++-mode-hook)
	(add-hook 'before-save-hook 'clang-format-buffer-smart-on-save))

;; WARNING: breaks c header files. C++ only.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
