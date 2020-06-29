;; Setup package sources.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'.
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
		("cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" "57f95012730e3a03ebddb7f2925861ade87f53d5bbb255398357731a7b1ac0e0" "0f302165235625ca5a827ac2f963c102a635f27879637d9021c04d845a32c568" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "ad9bbd248fa223436c71b87d80086c9e567b2e32e02bf0ccc90beb038cdbcea7" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "6dd2b995238b4943431af56c5c9c0c825258c2de87b6c936ee88d6bb1e577cb9" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" default)))
 '(package-selected-packages
	 (quote
		(company-mode cmake-ide rtags flycheck-irony scala-mode cmake-mode dockerfile-mode treemacs protobuf-mode emojify mocha tide typescript-mode eslint-fix ag lsp-rust yasnippet which-key use-package try toml-mode solidity-mode rust-playground racer nyan-mode magit jedi gotest go-guru go-autocomplete ggtags flymake-solidity flycheck-rust flycheck-mypy fill-column-indicator exec-path-from-shell cyberpunk-theme company-terraform cargo autopair atom-one-dark-theme atom-dark-theme)))
 '(safe-local-variable-values
	 (quote
		((company-clang-arguments "-I/home/armaniferrante/Documents/code/src/github.com/armaniferrante/trading/include")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
