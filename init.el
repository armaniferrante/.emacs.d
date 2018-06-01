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
 '(custom-safe-themes
   (quote
	("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "6dd2b995238b4943431af56c5c9c0c825258c2de87b6c936ee88d6bb1e577cb9" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" default)))
 '(package-selected-packages
   (quote
	(mocha tide typescript-mode eslint-fix ag lsp-rust yasnippet which-key use-package try toml-mode solidity-mode rust-playground racer nyan-mode magit jedi gotest go-guru go-autocomplete ggtags flymake-solidity flycheck-rust flycheck-mypy fill-column-indicator exec-path-from-shell cyberpunk-theme company-terraform cargo autopair atom-one-dark-theme atom-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
