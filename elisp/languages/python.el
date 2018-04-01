;; dependency: sudo pip install virtualenv
;;             jedi: install-server
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package flycheck-mypy
  :ensure t)
(add-hook 'python-mode-hook 'flycheck-mode)

;; highlight entire line for errors
(set-face-attribute 'flycheck-error nil :background "red")
(set-face-attribute 'flycheck-error nil :foreground "white")

(flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports"
              "--strict-optional"
              "--python-version" "3.6"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)

; don't use pylint checker
(setq-default flycheck-disabled-checkers '(python-pylint))
(add-to-list 'flycheck-checkers 'python-mypy t)

(defun my-python-mode-hook ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-*") 'jedi:goto-definition-pop-marker)
  (fci-mode 1)
  (setq flycheck-checker 'python-mypy)
)
(add-hook 'python-mode-hook 'my-python-mode-hook)
