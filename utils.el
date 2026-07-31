(defun my/load(name)
  "Load an emacs-lisp file from emacs directory"
  (load (expand-file-name name user-emacs-directory)))
