;; _*_ lexical-binding: t ; no-byte-compile: t _*_

(load (expand-file-name "utils" user-emacs-directory))

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
(run-at-time nil 1 #'recentf-mode)
(save-place-mode 1)
(run-at-time nil 1 #'global-auto-revert-mode)

;; numbers with relative numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)


(my/load "treesitter")
(my/load "modes")
(my/load "eglot")
(my/load "ui")


(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))


(use-package org
  :ensure nil
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (python     . t)))
   (setq org-confirm-babel-evaluate nil))


(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))


(use-package magit
  :ensure t)
