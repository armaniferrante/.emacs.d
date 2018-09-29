;;; Commentary:
;;;
;;; To setup gdb on mac-os, you need to add to ~/.gdbinit:
;;;
;;; set startup-with-shell off
;;; python
;;; # This is valid for rustup rust installation only.  The path will be different for Homebrew-installed Rust.
;;; import os
;;; sys.path.insert(0, os.path.join(os.getenv('HOME'), ".rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/etc"))
;;; import gdb_rust_pretty_printing
;;; gdb_rust_pretty_printing.register_printers(gdb)
;;; end

;; directions from https://gist.github.com/danisfermi/17d6c0078a2fd4c6ee818c954d2de13c
;; Open Keychain Access
;; In menu, open Keychain Access > Certificate Assistant > Create a Certificate
;; Give it a name (e.g. gdbcert)
;; Identity type: Self Signed Root
;; Certificate type: Code Signing
;; Check: Let Me Override Defaults
;; Continue until "Specify a Location For"
;; Set Keychain location to System. If this yields the following error: Certificate Error: Unknown Error =-2,147,414,007 Set Location to Login, Unlock System by click on the lock at the top left corner and drag and drop the certificate gdbcert to the System Keychain.
;; Create certificate and close Certificate Assistant.
;; Find the certificate in System keychain.
;; Double click certificate.
;; Expand Trust, set Code signing to Always Trust
;; Restart taskgated in terminal: killall taskgated
;; Enable root account by following the steps given below: Open System Preferences. Go to User & Groups > Unlock. Login Options > "Join" (next to Network Account Server). Click "Open Directory Utility". Go up to Edit > Enable Root User.
;; Codesign gdb using your certificate: codesign -fs gdbc /usr/local/bin/gdb
;; Shut down your mac and restart in recovery mode (hold down command-R until apple logo appears)
;; Open terminal window
;; Modify System Integrity Protection to allow debugging: csrutil enable --without debug
;; Reboot your Mac. Debugging with gdb should now work as expected.

(use-package rust-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package flycheck-rust
  :ensure t)

(use-package rust-playground
  :ensure t)

;; on the fly syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

; curl https://sh.rustup.rs -sSf | sh
; rustup component add rust-src
; cargo install racer
(use-package racer
  :ensure t)

(use-package company
  :ensure t)

(use-package cargo
  :ensure t  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

(defun set-two-spaces ()
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

(defun my-rust-mode-hook ()
  (flycheck-rust-setup)
  (rust-enable-format-on-save)
  (racer-mode))
  ;(set-two-spaces))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;; note: when installing rust via rustup, you might need to run
;;       rustup update nightly
;;       rustup component add rustfmt-preview
;;       before getting rust-fmt to work properly

;; to find: echo `rustc --print sysroot`/lib/rustlib/src/rust/src
;(setq racer-rust-src-path "/Users/armaniferrante/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
(setq racer-rust-src-path "/Users/armaniferrante/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src")
