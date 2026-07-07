(setq inhibit-startup-message t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function 'ignore)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(hl-line-mode 1)

(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

(use-package marginalia
     :ensure t
     :init
     (marginalia-mode t))

(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package magit
  :ensure t)
