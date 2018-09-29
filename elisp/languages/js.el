(use-package js2-mode
  :ensure t)
(define-key js2-mode-map (kbd "M-.") nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; disable js2-mode error highlighting (use flycheck instead)
(setq js2-mode-show-parse-errors nil
      js2-mode-show-strict-warnings nil)

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(use-package xref-js2
  :ensure t)
;; first run: brew install the_silver_searcher
(use-package ag
  :ensure t)

(use-package prettier-js
	:ensure t)

;; Indentation.
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)
(setq typescript-indent-level 2)

(defun my-js-mode-hook ()
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-checker #'javascript-eslint))

(add-hook 'js2-mode-hook #'my-js-mode-hook)
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;(js2r-add-keybindings-with-prefix "C-c C-r")
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

(use-package tide
  :ensure t)

(use-package mocha
  :ensure t)

(use-package typescript-mode
 :ensure t)
(add-hook 'typescript-mode-hook 'prettier-js-mode)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;(company-mode +1)
  ;(setq indent-tabs-mode t)
  (local-set-key (kbd "C-c C-c C-t") (lambda () (interactive) (mocha-test-project))))

aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))
