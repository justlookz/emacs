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
 (defun my/doom-theme-customizations (&rest _)
    (when (and custom-enabled-themes
               (string-prefix-p "doom-" (symbol-name (car custom-enabled-themes))))
      (set-face-foreground
       'font-lock-comment-face
       (doom-color 'orange))))
(defvar after-enable-theme-hook nil
   "Normal hook run after enabling a theme.")

(defun run-after-enable-theme-hook (&rest _args)
   "Run `after-enable-theme-hook'."
   (run-hooks 'after-enable-theme-hook))

(advice-add 'enable-theme :after #'run-after-enable-theme-hook)

(use-package doom-themes
  :ensure t

  :config

  (add-hook 'enable-theme-functions #'my/doom-theme-customizations)
  (load-theme 'doom-gruvbox)
  )
