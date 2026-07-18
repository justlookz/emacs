(deftheme monokai-ristretto
  "Monokai Ristretto")

(let ((bg "#2C2525")
      (fg "#F9F1F1")
      (red "#FD6883")
      (green "#ADDA78")
      (yellow "#F9CC6C")
      (orange "#F38D70")
      (purple "#A8A9EB")
      (cyan "#85DACC"))

  (custom-theme-set-faces
   'monokai-ristretto

   ;; True color / 256 color
   `(default
      ((((min-colors 256))
        (:background ,bg :foreground ,fg))
       (t
        (:background "black" :foreground "white"))))

   `(hl-line
     ((((min-colors 256))
       (:background "#3A3030"))
      (t
       (:background "bright-black"))))

   ;; Terminal-friendly fallbacks
   `(font-lock-keyword-face
      ((((min-colors 256))
        (:foreground ,red :weight bold))
       (t (:foreground "red" :weight bold))))

   `(font-lock-function-name-face
      ((((min-colors 256))
        (:foreground ,green))
       (t (:foreground "green"))))

   `(font-lock-string-face
      ((((min-colors 256))
        (:foreground ,orange))
       (t (:foreground "orange"))))

   `(font-lock-comment-face
      ((((min-colors 256))
        (:foreground ,green :slant italic))
       (t (:foreground "bright-green" :slant italic))))

   `(font-lock-type-face
      ((((min-colors 256))
        (:foreground ,yellow))
       (t (:foreground "yellow"))))

   `(font-lock-variable-name-face
      ((((min-colors 256))
        (:foreground ,orange))
       (t (:foreground "magenta"))))

   `(font-lock-constant-face
      ((((min-colors 256))
        (:foreground ,purple))
       (t (:foreground "blue"))))

   `(font-lock-builtin-face
      ((((min-colors 256))
        (:foreground ,cyan))
       (t (:foreground "cyan"))))

   `(mode-line
     ((((min-colors 256))
       (:background ,bg
		    :foreground ,fg
		    :box nil))
      (t
       (:background "black"
		    :foreground "orange"
		    :box nil))))
   
   `(mode-line-inactive
     ((((min-colors 256))
       (:background ,bg
		    :foreground ,fg
		    :box nil))
      (t
       (:background "bright-black"
		    :foreground "white"
		    :box nil))))))


(provide-theme 'monokai-ristretto)
