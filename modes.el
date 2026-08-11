;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; setup for typescript mode
(use-package typescript-ts-mode
  :ensure nil
  :no-require t
  :mode "\\.ts\\'")

;; setup for tsx mode
(use-package tsx-ts-mode
  :ensure nil
  :no-require t
  :mode ("\\.tsx|\\jsx\\'"))

;; same for jsx mode
(use-package js-ts-mode
  :ensure nil
  :no-require t
  :mode "\\.js\\'")

;; mostly for cc modes that dont have
;; treesitter setup
(use-package cc-mode
  :ensure nil
  :no-require t
  :init
  (setq-default c-basic-offset 4))

;; typst mode
(use-package typst-ts-mode
  :after treesit-auto
  :ensure t)

;; lua mode
(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'")

;; mode for godot
(use-package gdscript-mode
  :ensure t
  :mode "\\.gd\\'"
  :hook (gdscript-mode . eglot-ensure))

;; mode for rust mode if ts is not set
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")
