(use-package atom-one-dark-theme
  :ensure t)

;; font size
(set-face-attribute 'default nil :height 120)

;; always show line number
(global-linum-mode 1)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default fill-column 80)

(use-package fill-column-indicator
  :ensure t)

;; tabs as two spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)

;; highlight matching parens with no delay
(setq show-paren-delay 0)
(show-paren-mode 1)

;; create matching brackets/parenthesis automatically
(use-package autopair
  :ensure t)

;; open shell in same window
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))


;; always pop flycheck buffer at bottom to 1/10 of screen height
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.1)))

;; easy window navigation
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
