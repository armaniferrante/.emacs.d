(use-package solidity-mode
  :ensure t)

(use-package flymake-solidity
  :ensure t)

;; this probably isn't needed because of use-package
(require 'flymake-solidity)
(add-hook 'find-file-hook 'flymake-solidity-maybe-load)
