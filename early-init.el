(setq gc-cons-threshold 63000000
      gc-cons-percentage 0.6)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq inhibit-startup-message t)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)


(load-theme 'monokai-ristretto t)
(set-face-attribute 'default nil
		    :family "GoMono Nerd Font Propo"
		    :height 100)
