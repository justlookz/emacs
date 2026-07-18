;;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)

(recentf-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 1)

(global-display-fill-column-indicator-mode 1)
(setq-default display-fill-column-indicator-column 64)

;; (tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; (tab-bar-mode -1)
;; (menu-bar-mode -1)

(electric-pair-mode 1)

(setq ring-bell-function 'ignore)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-hl-line-mode 1)

(use-package org
  :ensure nil
  :config
  (setq org-babel-default-header-args:shell
	'((:results . "output")
	  (:wrap . "src shell")
	  (:session . "CODE_RUNNING")
	  (:dir . ".")))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (python     . t)))
   (setq org-confirm-babel-evaluate nil))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-monokai-ristretto") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-monokai-ristretto t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package typst-ts-mode
  :init
  (add-to-list 'treesit-language-source-alist
	       '(typst "https://github.com/uben0/tree-sitter-typst"))
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
  :bind
  (:map eglot-mode-map
	("C-c a" . eglot-code-actions)
	("C-c r" . eglot-rename)
	("C-c f" . eglot-format))
  :init
  (setq eglot-confirm-server-initiated-edits nil)
  (setq eglot-autoshutdown t)
  :config
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
  :config
  (vertico-mode t))

(use-package marginalia
  :ensure t
  :init
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
  :init
  (global-corfu-mode t)
  :custom
  (tab-always-indent 'complete))

(use-package magit
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-global-set-key 'normal "gcc" 'comment-line)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :init
  :config
  (evil-collection-init))
