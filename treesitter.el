;; _*_ lexical-binding: t ; no-byte-compile: t _*_

;; setup to download treesitter
;; base of the 14 abi
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs '(typst typescript
                              rust c cpp python go java))
  (treesit-auto-install t)
  :init
  (setq-default c-ts-mode-indent-offset 4)
  (setq treesit-language-source-alist
        '((rust         "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3")
          (c            "https://github.com/tree-sitter/tree-sitter-c" "v0.23.6")
          (typescript   "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2"
                        "typescript/src")
          (javascript   "https://github.com/tree-sitter/tree-sitter-javascript" "v0.23.1"
                        "src")
          (tsx          "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2"
                        "tsx/src")
          (cpp          "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")
          (python       "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
          (go           "https://github.com/tree-sitter/tree-sitter-go" "v0.23.4")
          (java         "https://github.com/tree-sitter/tree-sitter-java" "v0.23.5")
          (typst        "https://github.com/uben0/tree-sitter-typst")))
  :config
  (global-treesit-auto-mode))
