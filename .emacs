

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;; path for the modes that are not part of package
(add-to-list 'load-path "~/.emacs.d/emacs-modes/misc")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/yasnippet")

;; loads this file to have beautifull colors
(load-file "~/.emacs.d/colors.el")

;; loads lisp configuration
(load-file "~/.emacs.d/lisp.el")

;; fonts
(if (eq window-system 'x)
    (set-frame-font "Inconsolata-13"))

;; save backup files in this directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))


(require 'undo-tree)
(require 'yasnippet)
(require 'paren)
(require 'multi-term)
(require 'igrep)
(require 'package)
(require 'maxframe)

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(package-initialize)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))


(yas/initialize)
(yas/load-directory "~/.emacs.d/emacs-modes/yasnippet/snippets")

;; associations between files extensions and modes
(setq auto-mode-alist (cons '("\\.html$" . nxml-mode) auto-mode-alist))

;; ido-mode options
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-ignore-extensions t)
(setq ido-file-extensions-order
      '(".clj" ".txt" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

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
(global-set-key [C-tab] 'other-window)
(global-set-key "\r" 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-region)


; switch buffer with last previous buffer
(global-set-key (kbd "C-p") 'backward-char)
(global-set-key (kbd "C-S-p") 'previous-line)
(global-set-key (kbd "C-S-j") 'join-line)
(global-set-key (kbd "C-<prior>") 'tabbar-forward)
(global-set-key (kbd "C-<next>") 'tabbar-backward)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key [f1] 'multi-term)
(global-set-key [f2] 'multi-term-next)
(global-set-key [f4] 'slime-connect)
(global-set-key [f5] 'slime-compile-and-load-file)
(global-set-key [(shift f3)] 'kmacro-start-macro-or-insert-counter)
(global-set-key [(shift f4)] 'kmacro-end-or-call-macro)
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

;; (if (window-system)
;;     (progn
;;       (set-frame-height (selected-frame) 66)
;;       (set-frame-width (selected-frame) 240)))
(add-hook 'window-setup-hook 'maximize-frame t)


;; js2-mode configuration
(add-hook 'js2-mode-hook
  '(lambda ()
     (define-key js2-mode-map (kbd "<return>") 
       '(lambda ()
          (interactive)
          (js2-enter-key)
          (indent-for-tab-command)))))

;; unicode
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; starts emacs server
(server-start)

(add-hook 'nxml-mode-hook
          '(lambda ()
             (define-key nxml-mode-map
               (kbd "<C-return>") '(lambda ()
                                     (interactive)
                                     (switch-to-buffer nil)))))


