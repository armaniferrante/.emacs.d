(use-package go-mode
  :ensure t)
(setenv "GOPATH" "/home/armaniferrante/go")

(use-package exec-path-from-shell
  :ensure t)

;; 0)go get golang.org/x/tools/cmd/...
;;    - installs go doc and others
;; 1) First run M-x package-install and enter exec-path-from-shell
;; 2) Then add this
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GOPATH")

(use-package go-guru
  :ensure t)

(use-package gotest
  :ensure t)

;; Runs tests and code coverage everytime we save a file.
;; Note: I've made one adjustment to gotest.el:
;; Hardcode the --coverprofile= argument to always use the same
;; coverage output directory, so as not to prompt everytime you save.
(defun my-go-test-mode-hook ()
  ;; *Go Test* is the name of the buffer. See gotest.el.
  (when (not (get-buffer-window "*Go Test*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*Go Test*")
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'go-test-mode-hook 'my-go-test-mode-hook)

;; go get -u github.com/rogpeppe/godef/...
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'go-save-hook)
  ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun go-save-hook ()
  (when (eq major-mode 'go-mode)
    (gofmt-before-save)
    ;(go-test-current-coverage)
		))

;; Autocomplete.
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(use-package go-autocomplete
  :ensure t)

(use-package go-projectile
	:ensure t)

;; go get -u github.com/nsf/gocode
(with-eval-after-load 'go-mode
     (require 'go-autocomplete))
