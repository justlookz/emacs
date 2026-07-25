;; _*_ lexical-binding: t ; no-byte-compile: t _*_

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 1)

(setq-default indent-tabs-mode nil)

(setq confirm-kill-processes nil)
(setq buffer-save-without-query t)

(let ((dir (expand-file-name "auto-save/" user-emacs-directory)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms
        `((".*" ,dir t))))

(use-package emacs
  :ensure nil
  :defer t
  :config
  (global-visual-line-mode 1)
  (global-display-fill-column-indicator-mode 1)
  (setq-default display-fill-column-indicator-column 64)
  (when (display-graphic-p)
    (global-hl-line-mode 1))

  (electric-pair-mode 1)

  (setq ring-bell-function 'ignore)

  (recentf-mode 1)
  (save-place-mode 1)
  (global-auto-revert-mode 1)

  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode 1)

  (recentf-mode 1)
  (save-place-mode 1)
  (global-auto-revert-mode 1))

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . hl-line-mode))
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-dwim-target t))

(use-package org
  :ensure nil
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (python     . t)))
   (setq org-confirm-babel-evaluate nil))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs '(typst rust c cpp python go java))
  (treesit-auto-install t)
  :init
  (setq-default c-ts-mode-indent-offset 4)
  (setq treesit-language-source-alist
        '((rust         "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3")
          (c            "https://github.com/tree-sitter/tree-sitter-c" "v0.23.6")
          (cpp          "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")
          (python       "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
          (go           "https://github.com/tree-sitter/tree-sitter-go" "v0.23.4")
          (java           "https://github.com/tree-sitter/tree-sitter-java" "v0.23.5")
          (typst        "https://github.com/uben0/tree-sitter-typst")))
  :config
  (treesit-auto-install-all)
  (global-treesit-auto-mode))

(use-package cc-mode
  :ensure nil
  :no-require t
  :init
  (setq-default c-basic-offset 4))

(use-package typst-ts-mode
  :after treesit-auto
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package gdscript-mode
  :ensure t
  :mode "\\.gd\\'"
  :hook (gdscript-mode . eglot-ensure))

(use-package rust-mode
  :ensure t)

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

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :config
  (vertico-mode t))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode t))

(use-package which-key
  :ensure nil
  :config
  (which-key-mode t))

(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless flex basic)))

(use-package corfu
  :ensure t
  :demand t
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (tab-always-indent 'complete)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab]. corfu-previous))

  :config
  (global-corfu-mode t))

(use-package consult
  :ensure t
  :bind
  (:map global-map
    ("C-;" . consult-buffer)))

(use-package magit
  :ensure t)

;; easy undo redo and persistent history
(use-package undo-tree
  :ensure t
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (undo-tree-visualizer-timestamps t)
  :config
  (global-undo-tree-mode))

(use-package evil
  :ensure t
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want C-i-jump t)
  (evil-want-C-u-scroll t)
  (evil-want-C-d-scroll t)
  (evil-want-C-w-delete t)
  (evil-want-C-n-repeat-search t)
  (evil-move-beyond-eol t)
  (evil-undo-system `undo-tree)
  (evil-vsplit-window-right t)
  (evil-split-window-below t)
  
  :config
  (evil-global-set-key `normal "gcc" 'comment-line)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
