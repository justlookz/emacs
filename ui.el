;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; dired is the file manager of emacs.
;; like oil mostly but not really
(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . hl-line-mode))
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-dwim-target t)
  )


;; easy undo redo and persistent history
(use-package undo-tree
  :ensure t
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (undo-tree-visualizer-timestamps t)
  :config
  (global-undo-tree-mode)
  )

;; complition with vertical options
;; with memory and partial completion
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :config
  (vertico-mode t))

;; minimal help info next to vertico
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode t)
  )

;; like neovim, it shows keybinds
(use-package which-key
  :ensure nil
  :config
  (which-key-setup-side-window-right)
  (which-key-setup-minibuffer)
  (which-key-mode t)
  )

;; helps to complete without the correct order
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless flex basic))
  )

;; completion next to cursor
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
  (global-corfu-mode t)
  )


;; this add selections for corfu for file completion etc
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) 
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
)


;; search engine with previou
(use-package consult
  :ensure t
  :bind
  (:map global-map
        ("C-;" . consult-buffer))
  )


;; different color bracket per level
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  )


(my/load "evil")
;; (my/load "meow")


;; doom themes
(use-package doom-themes
  :ensure t

  :init
  (defun my/doom-theme-customizations (&rest _)
    (when (and custom-enabled-themes
               (string-prefix-p "doom-" (symbol-name (car custom-enabled-themes))))
      (require 'org-faces)
      (require 'magit)
      (require 'consult)
      (require 'eglot)
      (set-face-foreground
       'font-lock-comment-face (doom-color 'orange))
      (set-face-foreground
       'shadow (doom-color 'green))
      (set-face-foreground
       'font-lock-string-face (doom-color 'yellow))
      (set-face-foreground
       'org-done (doom-color 'green))
      (set-face-foreground
       'tab-line (doom-color 'orange))
      (set-face-foreground
       'mode-line (doom-color 'orange))
      (set-face-foreground
       'magit-hash (doom-color 'green))
      (set-face-foreground
       'magit-log-graph (doom-color 'green))
      (set-face-foreground
       'magit-diff-hunk-heading (doom-color 'yellow))
      (set-face-foreground
       'magit-dimmed (doom-color 'yellow))
      (set-face-foreground
       'magit-diff-removed (doom-color 'red))
      (set-face-foreground
       'magit-refname (doom-color 'green))
      (set-face-foreground
       'org-drawer (doom-color 'green))
      (set-face-foreground
       'org-time-grid (doom-color 'green))
      (set-face-foreground
       'line-number (doom-color 'green))
      (set-face-foreground
       'message-mml (doom-color 'green))
      (set-face-foreground
       'consult-help (doom-color 'green))
      (set-face-foreground
       'dired-ignored (doom-color 'red))
      (set-face-foreground
       'eglot-type-hint-face (doom-color 'green))
      (set-face-foreground
       'eglot-type-hint-face (doom-color 'green))
      (set-face-foreground
       'eglot-inlay-hint-face (doom-color 'green))
      (set-face-foreground
       'eglot-parameter-hint-face (doom-color 'green))
      (set-face-foreground
       'eglot-diagnostic-tag-deprecated-face (doom-color 'red))
      (set-face-foreground
       'eglot-diagnostic-tag-unnecessary-face (doom-color 'green))
      ))
  (defvar after-enable-theme-hook nil
    "Normal hook run after enabling a theme.")

  (defun run-after-enable-theme-hook (&rest _args)
    "Run `after-enable-theme-hook'."
    (run-hooks 'after-enable-theme-hook))

  (advice-add 'enable-theme :after #'run-after-enable-theme-hook)

  
  :config

  (add-hook 'after-enable-theme-hook #'my/doom-theme-customizations)
  (load-theme 'doom-monokai-pro t)
  )
