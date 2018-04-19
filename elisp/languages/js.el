(use-package js2-mode
  :ensure t)
(define-key js2-mode-map (kbd "M-.") nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; two space tabs
(setq js-indent-level 2)

;; disable js2-mode error highlighting (use flycheck instead)
(setq js2-mode-show-parse-errors nil
      js2-mode-show-strict-warnings nil)

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(use-package nodejs-repl
  :ensure t)
(use-package xref-js2
  :ensure t)
(use-package ag
  :ensure t)

(defun my-js-mode-hook ()
  (setq flycheck-checker 'javascript-eslint))

(add-hook 'js2-mode-hook 'my-js-mode-hook)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; fix node console that looks like: [1G[0J> [3G
(add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\\[[0-9]+[GK]" "" output)))
