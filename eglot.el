;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; setup lsp. only 1 lsp per major mode
(use-package eglot
  :ensure nil
  :hook
  ((python-mode python-ts-mode) . eglot-ensure)
  ((go-mode go-ts-mode) . eglot-ensure)
  ((rust-mode rust-ts-mode) . eglot-ensure)
  ((c-mode c-ts-mode) . eglot-ensure)
  ((c++-mode c++-ts-mode) . eglot-ensure)
  ((java-mode java-ts-mode) . eglot-ensure)
  (typst-ts-mode . eglot-ensure)
  (lua-mode . eglot-ensure)
  :bind
  (:map eglot-mode-map
    ("C-c a" . eglot-code-actions)
    ("C-c r" . eglot-rename)
    ("C-c f" . eglot-format))
  :config
  (setq eglot-confirm-server-initiated-edits nil)
  (setq eglot-autoshutdown t)

  (add-to-list 'eglot-server-programs
           '(typst-ts-mode . ("tinymist")))

  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode tsx-ts-mode js-ts-mode)
                 . ("typescript-language-server" "--stdio")))

  (setq-default eglot-workspace-configuration
        '(:java
          (:configuration
           (:updateBuildConfiguration "automatic"))
          :codeGeneration
          (:toString
           (:template
            "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"))
          :project
          (:sourcePaths
           ["" "src" "src/main"
            "src/test" "app/src/main/java"
            "src/java"])
          :referencedLibraries
          ["../**/libs/**/*.jar"
           "../**/lib/**/*.jar"]))
  (add-to-list
   'eglot-server-programs
   `(lua-mode . ,(eglot-alternatives
                  '(("emmylua_ls")
                    ("lua_ls"))))))
