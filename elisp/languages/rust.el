(use-package rust-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package flycheck-rust
  :ensure t)

(use-package rust-playground
  :ensure t)

; curl https://sh.rustup.rs -sSf | sh
; rustup component add rust-src
; cargo install racer
(use-package racer
  :ensure t)

(use-package cargo
  :ensure t  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

;; Indentiation.
(setq rust-indent-offset 4)

(defun my-rust-mode-hook ()
  (flycheck-rust-setup)
  (rust-enable-format-on-save)
  (racer-mode))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;; Note: When installing rust via rustup, you might need to run
;;
;;       rustup update nightly
;;       rustup component add rustfmt-preview
;;
;;       before getting rust-fmt to work properly
;;       Also, make sure to run `rustup component add rust-src` for both stable
;;       and nightly.
;;
;; To find: echo `rustc --print sysroot`/lib/rustlib/src/rust/src.
;(setq racer-rust-src-path "/home/armaniferrante/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")
(setq racer-rust-src-path "/home/armaniferrante/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")
