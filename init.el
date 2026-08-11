;; _*_ lexical-binding: t ; no-byte-compile: t _*_

;; load custom utilities like my/load for all future packages
(load (expand-file-name "utils" user-emacs-directory))


;; add melpa to the package manager
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;; setup packages to not recompile when started or
;; check for newer versions
(setq package-quickstart t)


;; I prefer space instead of tab
;; this is overrided frm .editorconfig
(setq-default indent-tabs-mode nil)


;; I dont care about sessions in org mode
;; of terminal then I close emacs
(setq confirm-kill-processes nil)
(setq buffer-save-without-query t)


;; Autosave directory for fail safe. I already use it one time
;; it saves a lot of time with little to non space
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


;; smerge mode. helps with boxes mismatch
(smerge-mode 1)

;; no sounds because I dont like it
(setq ring-bell-function 'ignore)


;; keep in memory last possistion
(run-at-time nil 1 #'recentf-mode)
(save-place-mode 1)
(run-at-time nil 1 #'global-auto-revert-mode)


;; numbers with relative numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)


;; load packages
(my/load "treesitter")
(my/load "modes")
(my/load "eglot")
(my/load "ui")


;; etc
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
