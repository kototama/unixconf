
(add-to-list 'load-path "~/.emacs.d/emacs-modes/git-emacs")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/yasnippet")

;; executes code in these files
(load-file "~/.emacs.d/colors.el")
(load-file "~/.emacs.d/lisp.el")
(load-file "~/.emacs.d/javascript.el")

(require 'smart-tab)
(require 'igrep)
(require 'undo-tree)
(require 'yasnippet)

(yas/initialize)
(yas/load-directory "~/.emacs.d/emacs-modes/yasnippet/snippets")

;; default modes
(iswitchb-mode t)
(icomplete-mode t)
(column-number-mode t)
(ido-mode t)
(winner-mode t)
(global-undo-tree-mode t)
(show-paren-mode t)
(column-number-mode t)

;; no toolbar
(tool-bar-mode -1)

;; no start screen
(setq inhibit-splash-screen t)

;; fonts
(if (eq window-system 'x)
    (set-default-font "Inconsolata-12"))

;; no tabs, spaces instead!
(setq-default indent-tabs-mode nil)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; ido-mode
;; do not confirm file creation
(setq confirm-nonexistent-file-or-buffer nil)

;; integrate copy/paste with X
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; scroll
(setq scroll-step 1)

;; save backup files in this directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

;; smart tab completion
(smart-tab 1)

(setq smart-tab-completion-functions-alist
      '((emacs-lisp-mode . lisp-complete-symbol)
        (text-mode . dabbrev-completion) ;; this is the "default" emacs expansion function
        (clojure-mode . slime-complete-symbol))) ;; see update below

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
;; global bindings
(global-set-key [C-tab] 'other-window)
(global-set-key "\r" 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "<f8>") '(lambda ()
                                (interactive)
                                (split-window-vertically 25)
                                (other-window 1)
                                (slime)))

; switch buffer with last previous buffer
(global-set-key (kbd "<C-return>") '(lambda ()
                                      (interactive)
                                      (switch-to-buffer nil)))
(global-set-key (kbd "C-p") 'backward-char)
(global-set-key (kbd "C-S-p") 'previous-line)
(global-set-key (kbd "C-S-j") 'join-line)
(global-set-key (kbd "C-<prior>") 'tabbar-forward)
(global-set-key (kbd "C-<next>") 'tabbar-backward)
(global-set-key (kbd "<f2>") 'slime-connect)
(global-set-key (kbd "<f9>") 'paredit-mode)
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "<C-return>")
                '(lambda ()
                   (interactive)
                   (switch-to-buffer nil)))

;; Make new frames fullscreen by default. Note: this hook doesn't do
;; anything to the initial frame if it's in your .emacs, since that file is
;; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

(if (window-system)
  (set-frame-height (selected-frame) 60))

(put 'downcase-region 'disabled nil)

;; macro to split the screen in three part with eshell in bottom right corner:
;; can be call with M-x splitscreen
(fset 'splitscreen
   [?\C-x ?3 ?\C-x ?o ?\C-x ?2 ?\C-x ?o ?\M-x ?e ?s ?h ?e ?l ?l return])

;; starts emacs server
(server-start)
;;;

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

