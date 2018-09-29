;; Set color theme.
(use-package atom-one-dark-theme
  :ensure t)
(column-number-mode 1)

;; Transparent window.
(set-frame-parameter (selected-frame) 'alpha '(99 . 99))
(add-to-list 'default-frame-alist '(alpha . (99 . 99)))

;; Font size.
(set-face-attribute 'default nil :height 110)

;; Always show line number.
(global-linum-mode 1)

;; Hide default startup message.
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; Hide the toolbar.
(tool-bar-mode -1)

;; Draw line at 100 chars.
(setq-default fill-column 100)
(use-package fill-column-indicator
  :ensure t)

(setq-default tab-width 2)

;; Highlight matching parens with no delay.
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Highlight current line.
(global-hl-line-mode +1)

;; Create matching brackets/parenthesis automatically.
(use-package autopair
  :ensure t)

;; Open shell in same window.
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))

;; Always pop the following buffers at the bottom.
(setq compilation-window-height 25)
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . .1)))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Cargo Build*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . .1)))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Cargo Test*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . .1)))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Cargo Run*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . .1)))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*mocha tests*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . .1)))

;; Easy window navigation (macOS).
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
