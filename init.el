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

(load "~/.emacs.d/elisp/languages/init.el")
(load "~/.emacs.d/elisp/ui.el")
(load "~/.emacs.d/elisp/utils.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ag lsp-rust yasnippet which-key use-package try toml-mode solidity-mode rust-playground racer nyan-mode magit jedi gotest go-guru go-autocomplete ggtags flymake-solidity flycheck-rust flycheck-mypy fill-column-indicator exec-path-from-shell cyberpunk-theme company-terraform cargo autopair atom-one-dark-theme atom-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
