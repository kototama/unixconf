;;; EMACS customization via the menu
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

(add-to-list 'load-path "~/.emacs.d/emacs-modes/misc")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/git-emacs")
(load-file "~/.emacs.d/colors.el")
(load-file "~/.emacs.d/lisp.el")

;; (require 'git-emacs)
(require 'git-emacs)
(require 'git-status)
(require 'smart-tab)
(require 'tabbar)
(require 'igrep)

;; default modes
(iswitchb-mode t)
(icomplete-mode t)
(column-number-mode t)
(ido-mode t)
(tabbar-mode t)
(winner-mode t)

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

;; tab bar
(set-face-attribute
 'tabbar-default nil
 :background "gray60")
(set-face-attribute
 'tabbar-unselected nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator nil
 :height 0.7)

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

;; fullscreen on F11
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

                                        ; Make new frames fullscreen by default. Note: this hook doesn't do
                                        ; anything to the initial frame if it's in your .emacs, since that file is
                                        ; read _after_ the initial frame is created.
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