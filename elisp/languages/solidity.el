(use-package solidity-mode
  :ensure t)

(use-package flymake-solidity
  :ensure t)

;; this probably isn't needed because of use-package
(require 'flymake-solidity)
(add-hook 'find-file-hook 'flymake-solidity-maybe-load)

;(define-key map (kbd "C-c C-g") 'solidity-estimate-gas-at-point)
(setq flycheck-solidity-solium-soliumrcfile "/Users/armaniferrante/Documents/code/src/github.com/counterfactual/counterfactual-contracts/.soliumrc.json")

(defun my-solidity-mode-hook ()
  (setq flycheck-checker 'solium-checker))

(add-hook 'solidity-mode-hook 'my-solidity-mode-hook)
