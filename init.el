;; _*_ lexical-binding: t ; no-byte-compile: t _*_

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq package-quickstart t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 1)

(setq-default indent-tabs-mode nil)

(setq confirm-kill-processes nil)
(setq buffer-save-without-query t)

(let ((dir (expand-file-name "auto-save/" user-emacs-directory)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms
        `((".*" ,dir t))))

;; line at 64 characters
(global-visual-line-mode 1)
(global-display-fill-column-indicator-mode 1)
(setq-default display-fill-column-indicator-column 64)

;; highlight current line
(when (display-graphic-p)
  (global-hl-line-mode 1))

;; autopairs
(electric-pair-mode 1)

;; no sounds
(setq ring-bell-function 'ignore)

;; keep in memory last possistion
(run-at-time nil 5 #'recentf-mode)
(save-place-mode 1)
(run-at-time nil 2 #'global-auto-revert-mode)

;; numbers with relative numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)


(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))


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
  :ensure t
  :mode "\\.lua\\'")


(use-package gdscript-mode
  :ensure t
  :mode "\\.gd\\'"
  :hook (gdscript-mode . eglot-ensure))


(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")


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
  (which-key-setup-side-window-right)
  (which-key-setup-minibuffer)
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
        ([backtab] . corfu-previous))
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
  (evil-want-C-u-delete t)
  (evil-want-C-w-delete t)
  (evil-want-C-n-repeat-search t)
  (evil-move-beyond-eol t)
  (evil-undo-system `undo-tree)
  (evil-vsplit-window-right t)
  (evil-split-window-below t)
  (evil-leader/in-all-states t)
  (evil-want-fine-undo t)
  
  :config
  ;; Define the leader key as Space
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  ;; Keybindings for searching and finding files.
  (evil-define-key 'normal 'global (kbd "<leader> s f") 'consult-find)
  (evil-define-key 'normal 'global (kbd "<leader> s g") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s G") 'consult-git-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s r") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader> s h") 'consult-info)
  (evil-define-key 'normal 'global (kbd "<leader> /") 'consult-line)
  
  (evil-define-key 'normal 'global (kbd "] d") 'flymake-goto-next-error) ;; Go to next Flymake error
  (evil-define-key 'normal 'global (kbd "[ d") 'flymake-goto-prev-error) ;; Go to previous Flymake error

  ;; Dired commands for file management
  (evil-define-key 'normal 'global (kbd "<leader> x d") 'dired)
  (evil-define-key 'normal 'global (kbd "<leader> x j") 'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader> x f") 'find-file)

  ;; Magit keybindings for Git integration
  (evil-define-key 'normal 'global (kbd "<leader> g g") 'magit-status)      ;; Open Magit status
  (evil-define-key 'normal 'global (kbd "<leader> g l") 'magit-log-current) ;; Show current log
  (evil-define-key 'normal 'global (kbd "<leader> g d") 'magit-diff-buffer-file) ;; Show diff for the current file
  (evil-define-key 'normal 'global (kbd "<leader> g D") 'diff-hl-show-hunk) ;; Show diff for a hunk
  (evil-define-key 'normal 'global (kbd "<leader> g b") 'vc-annotate)       ;; Annotate buffer with version control info

  
  (evil-define-key 'normal 'global (kbd "] b") 'switch-to-next-buffer) ;; Switch to next buffer
  (evil-define-key 'normal 'global (kbd "[ b") 'switch-to-prev-buffer) ;; Switch to previous buffer
  (evil-define-key 'normal 'global (kbd "<leader> b i") 'consult-buffer) ;; Open consult buffer list
  (evil-define-key 'normal 'global (kbd "<leader> b b") 'ibuffer) ;; Open Ibuffer
  (evil-define-key 'normal 'global (kbd "<leader> b d") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer) ;; Save buffer
  (evil-define-key 'normal 'global (kbd "<leader> b l") 'consult-buffer) ;; Consult buffer
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'consult-buffer) ;; Consult buffer

  ;; Help keybindings
  (evil-define-key 'normal 'global (kbd "<leader> h m") 'describe-mode) ;; Describe current mode
  (evil-define-key 'normal 'global (kbd "<leader> h f") 'describe-function) ;; Describe function
  (evil-define-key 'normal 'global (kbd "<leader> h v") 'describe-variable) ;; Describe variable
  (evil-define-key 'normal 'global (kbd "<leader> h k") 'describe-key) ;; Describe key

  ;; Tab navigation
  (evil-define-key 'normal 'global (kbd "] t") 'tab-next) ;; Go to next tab
  (evil-define-key 'normal 'global (kbd "[ t") 'tab-previous) ;; Go to previous tab
  
  (evil-global-set-key `normal "gcc" 'comment-line)
  (evil-global-set-key `visual "gc" 'comment-line)
  (evil-mode 1))


(use-package evil-collection
  :after evil
  :requires evil
  :ensure t
  :hook (evil-mode . evil-collection-init)
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-want-find-usages-bindings t))


(use-package evil-numbers
  :ensure t
  :after evil
  :requires evil
  :config
  (evil-define-key
    '(normal visual)
    'global (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (evil-define-key
    '(normal visual)
    'global (kbd "C-c -") 'evil-numbers/dec-at-pt)
  (evil-define-key
    '(normal visual)
    'global (kbd "C-c C-+") 'evil-numbers/inc-at-pt-incremental)
  (evil-define-key
    '(normal visual)
    'global (kbd "C-c C--") 'evil-numbers/dec-at-pt-incremental))


(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))
