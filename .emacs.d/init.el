;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/emacs-modes/misc/package.el"))
  (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ))
  (package-initialize))



;; path for the modes that are not part of package
(add-to-list 'load-path "~/.emacs.d/emacs-modes/misc")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/yasnippet")

;; loads personal emacs functions and configurations
(load-file "~/.emacs.d/elisp/dev.el")
(load-file "~/.emacs.d/elisp/colors.el")
(load-file "~/.emacs.d/elisp/anything.el")
(load-file "~/.emacs.d/elisp/lisp.el")
(load-file "~/.emacs.d/elisp/javascript.el")
(load-file "~/.emacs.d/elisp/html.el")
(load-file "~/.emacs.d/elisp/smartbeol.el")

;; fonts
(if (eq window-system 'x)
    (progn
      (set-frame-font "Inconsolata-13")
      ;; (add-to-list 'default-frame-alist
      ;;              '(font . "Inconsolata-13"))
      ))

;; save backup files in this directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))


(require 'undo-tree)
(require 'yasnippet)
(require 'paren)
(require 'multi-term)
(require 'igrep)
(require 'package)
(require 'maxframe)
(require 'real-auto-save)
(require 'smex) 

(smex-initialize)

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)


(yas/initialize)
(yas/load-directory "~/.emacs.d/emacs-modes/yasnippet/snippets")

;; ido-mode options
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-ignore-extensions t)
(setq ido-file-extensions-order
      '(".clj" "js" ".txt" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;; igrep options
(put 'igrep-files-default 'clojure-mode
     (lambda () "*.clj"))
(put 'igrep-files-default 'js2-mode
     (lambda () "*.js"))

;; show paren options
(set-face-background 'show-paren-match-face "transparent")
(set-face-foreground 'show-paren-match-face "red")

;; always uses the following modes 
(ido-mode t)
(global-undo-tree-mode t)
(highlight-parentheses-mode t)
(show-paren-mode t)
(winner-mode t)
(column-number-mode t)

;; no toolbar
(tool-bar-mode -1)

;; no start screen
(setq inhibit-splash-screen t)

;; no tabs, spaces instead
(setq-default indent-tabs-mode nil)

;; changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; do not confirm file creation
(setq confirm-nonexistent-file-or-buffer nil)

;; disable blinking cursor
(blink-cursor-mode nil)

;; integrate copy/paste with X
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; scroll
(setq scroll-step 1)

;; default shell to zsh
(setq multi-term-program "/bin/zsh")

;; emacs lisp functions
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))

;; global key bindings
(global-set-key (kbd "<C-tab>") 'other-window)
;; (global-set-key (kbd "<S-iso-lefttab>") '(lambda ()
;;                                      (other-window -1)))
(global-set-key "\r" 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "C-k") 'eager-kill-line)
(global-set-key (kbd "C-p") 'backward-char)
(global-set-key (kbd "C-S-p") 'previous-line)
(global-set-key (kbd "C-S-j") 'join-line)
;; (global-set-key (kbd "C-<prior>") 'tabbar-forward)
;; (global-set-key (kbd "C-<next>") 'tabbar-backward)
(global-set-key (kbd "C-M-s") 'igrep-find)
;; (global-set-key [C-kp-1] '(lambda ()
;;                             (ido-find-file "~/.emacs")))

(global-set-key (kbd "C-a") 'move-indentation-or-line)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-o") 'my-anything)
(global-set-key (kbd "M-x") 'smex)

(global-set-key [f1] 'multi-term)
(global-set-key [f2] 'multi-term-prev)
(global-set-key [f3] 'multi-term-next)
(global-set-key [(shift f3)] 'kmacro-start-macro-or-insert-counter)
(global-set-key [(shift f4)] 'kmacro-end-or-call-macro)
(global-set-key [f4] 'slime-connect)
(global-set-key [f6] 'next-error)
(global-set-key [f8] 'paredit-mode)
(global-set-key [f9] 'magit-status)

;; (global-set-key [f10] 'toggle-fullscreen)
(global-set-key [f12] '(lambda ()
                         (interactive)
                         (kill-buffer nil)))
;; (global-set-key (kbd "²") '(lambda ()
;;                                  (interactive)
;;                                  (kill-buffer nil)))

(global-set-key (kbd "<C-return>")
                '(lambda ()
                   (interactive)
                   (switch-to-buffer nil)))

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term)

(add-hook 'window-setup-hook 'maximize-frame t)

(setq auto-save-interval 20)

(add-hook 'org-mode-hook 'turn-on-real-auto-save)
(add-hook 'org-mode-hook '(lambda ()
                            (define-key org-mode-map (kbd "<C-return>") nil)
                            (define-key org-mode-map (kbd "<C-tab>") nil)
                            (define-key org-mode-map (kbd "<S-iso-lefttab>") nil)
                            (define-key org-mode-map (kbd "<backtab>") nil)))

;; C programming
(setq-default c-basic-offset 4)

;; unicode
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; (setq browse-url-generic-program "/opt/google/chrome/chrome")

;; starts emacs server
(server-start)
