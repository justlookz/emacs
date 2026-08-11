;; -*- lexical-binding: t; no-byte-compile: t; -*-

;;; fixes from doom emacs


;; emacs gui setup stored to custom.el  Usefull to remember
;; colorsceme that I already modified
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 1)


;; gc increase chunks
(setq gc-cons-percentage 1.0)
(if noninteractive  ; in CLI sessions
    (setq gc-cons-threshold 134217728)  ; 128mb
  (setq gc-cons-threshold most-positive-fixnum)
  (setq load-prefer-newer nil))


;; increase chunk of loaded files
(setq read-process-output-max (* 64 1024))


;; disable native compile if cannot happen
(if (featurep 'native-compile)
    (if (not (native-comp-available-p))
        (delq 'native-compile features)))


;; disable warnings
(put 'if-let 'byte-obsolete-info nil)
(put 'when-let 'byte-obsolete-info nil)

;; disable warning for rebindings
(setq warning-suppress-types '((defvaralias) (lexical-binding)))


;; home path fix for plugins for windows
(let (realhome)
  (when (and (memq system-type '(cygwin windows-nt ms-dos))
             (null (getenv-internal "HOME"))
             (setq realhome (getenv "USERPROFILE")))
    (setenv "HOME" realhome)
    (setq abbreviated-home-dir nil)))


;; end of emacs optimization from doom emacs preconfiguration


;; disable elements from showing
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)


;; no start up message
(setq inhibit-startup-message t)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)


;; load theme. reduce flashbangs
;; if monokai it is costumized to have
;; green comments
(load-theme 'monokai t)


;; set fonts if exists on system
;; else only set size
;; unfortunally cannot load from file
(set-face-attribute 'default nil
		    :family "GoMono Nerd Font Propo"
		    :height 100) ; size * 10
