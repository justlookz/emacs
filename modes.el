(use-package typescript-ts-mode
  :ensure nil
  :no-require t
  :mode "\\.ts\\'")


(use-package tsx-ts-mode
  :ensure nil
  :no-require t
  :mode ("\\.tsx|\\jsx\\'"))


(use-package js-ts-mode
  :ensure nil
  :no-require t
  :mode "\\.js\\'")


(use-package cc-mode
  :ensure nil
  :no-require t
  :init
  (setq-default c-basic-offset 4))


(use-package typst-ts-mode
  :after treesit-auto
  :ensure t)


(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'")


(use-package gdscript-mode
  :ensure t
  :mode "\\.gd\\'"
  :hook (gdscript-mode . eglot-ensure))


(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")
