;;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 1)

(use-package emacs
  :ensure nil
  :defer t
  :config
  (global-visual-line-mode 1)
  (global-display-fill-column-indicator-mode 1)
  (setq-default display-fill-column-indicator-column 64)
  (global-hl-line-mode 1)

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
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-dwim-target t))

(use-package org
  :ensure nil
  :custom
  (org-babel-default-header-args:shell
	'((:results . "output")
	  (:wrap . "src shell")
	  (:session . "CODE_RUNNING")
	  (:dir . ".")))
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
  (add-to-list 'treesit-language-source-alist
	       '(typst "https://github.com/uben0/tree-sitter-typst"))
  (treesit-auto-langs '(typst))
  (treesit-auto-install 'prompt)
  :config
  ;; (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package typst-ts-mode
  :after treesit-auto
  :ensure t)

(use-package lua-mode
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
		   "../**/lib/**/*.jar"])))

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
  (completion-styles '(orderless basic)))

(use-package corfu
  :ensure t
  :custom
  (tab-always-indent 'complete)
  :config
  (global-corfu-mode t))

(use-package consult
  :ensure t
  :bind
  (:map global-map
	("C-;" . consult-buffer)))

(use-package magit
  :ensure t)

(use-package evil
  :ensure t
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want C-i-jump)
  (evil-want-C-u-scroll t)
  (evil-want-C-d-scroll t)
  (evil-want-C-w-delete t)
  (evil-move-beyond-eol t)
  (evil-undo-system 'undo-redo)
  (evil-vsplit-window-right t)
  (evil-split-window-below t)
  (evil-global-set-key 'normal "gcc" 'comment-line)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
