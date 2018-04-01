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
