;; _*_ lexical-binding: t ; no-byte-compile: t _*_

;; vim keybinds
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

;; for other modes as well
(use-package evil-collection
  :after evil
  :requires evil
  :ensure t
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-want-find-usages-bindings t)
  :config
  (evil-collection-init '(magit dired vertico corfu))
)

;; increment number. no sequencial thou
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
