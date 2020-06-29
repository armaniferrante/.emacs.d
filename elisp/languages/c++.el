;; CMake syntax highlighting.
(use-package cmake-mode
	:ensure t)
;; Ensure we use cmake mode for these files.
(add-to-list 'auto-mode-alist '("\\CMakeLists.txt\\'" . cmake-mode))

;; Install all required dependencies for cmake-ide.
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

(use-package rtags
  :ensure t
  :hook (c++-mode . rtags-start-process-unless-running)
  :config (setq rtags-completions-enabled t
		rtags-path "/home/armaniferrante/.emacs.d/rtags/src/rtags.el"
		rtags-rc-binary-name "/home/armaniferrante/.emacs.d/rtags/bin/rc"
		rtags-use-helm t
		rtags-rdm-binary-name "/home/armaniferrante/.emacs.d/rtags/bin/rdm")
  :bind (
				 ("M-." . rtags-find-symbol-at-point)
				 ("M-," . rtags-location-stack-back)
				)
	)
  ;; TODO: decide on the rest of these key-bindings.
  ;; 	 ("C-c e" . rtags-find-symbol-at-point)
  ;; 	 ("C-c O" . rtags-find-references)
  ;; 	 ("C-c o" . rtags-find-references-at-point)
  ;; 	 ("C-c s" . rtags-find-file)
  ;; 	 ("C-c v" . rtags-find-virtuals-at-point)
  ;; 	 ("C-c F" . rtags-fixit)
  ;; 	 ("C-c f" . rtags-location-stack-forward)
  ;; 	 ("C-c n" . rtags-next-match)
  ;; 	 ("C-c p" . rtags-previous-match)
  ;; 	 ("C-c P" . rtags-preprocess-file)
  ;; 	 ("C-c R" . rtags-rename-symbol)
  ;; 	 ("C-c x" . rtags-show-rtags-buffer)
  ;; 	 ("C-c T" . rtags-print-symbol-info)
  ;; 	 ("C-c t" . rtags-symbol-type)
  ;; 	 ("C-c I" . rtags-include-file)
  ;; 	 ("C-c i" . rtags-get-include-file-for-symbol)))

(setq rtags-display-result-backend 'helm)
;; After irony is installed, run
;; * sudo apt-get install libclang-dev
;; * M-x irony-install-server
(use-package irony
	:ensure t)
(use-package auto-complete-clang
	:ensure t)
(use-package company
	:ensure t)
(use-package flycheck
	:ensure t
	:init (global-flycheck-mode))
;; Now, finally install cmake-ide.
(use-package cmake-ide
	:ensure t)
(cmake-ide-setup)

;; Switch between header/implementation files.
(add-hook 'c-mode-common-hook
	  (lambda()
			(local-set-key  (kbd "C-c o") 'ff-find-other-file)))

(use-package clang-format
	:ensure t)

;; Format c++ files on save.
;;
;; Make sure to install clang format first, i.e., run
;; `sudo apt-get install clang-format`.
(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (clang-format-buffer)))
(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))
(defun my-c++-mode-hook ()
	(add-hook (make-local-variable 'before-save-hook) 'clang-format-buffer-smart-on-save))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; WARNING: breaks c header files. C++ only.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
