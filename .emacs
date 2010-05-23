;;; EMACS customization via the menu
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(quack-fontify-style nil)
 '(quack-pretty-lambda-p nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

(load-file "~/.emacs.d/colors.el")
(load-file "~/.emacs.d/lisp.el")
(load-file "/opt/emacs-modes/tabbar.el")
(load-file "/opt/emacs-modes/igrep.el")

;; fonts
(if (eq window-system 'x)
    (set-default-font "Inconsolata-14"))

;; no tabs, spaces instead!
(setq-default indent-tabs-mode nil)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; default modes
;(iswitchb-mode)
(column-number-mode)
(ido-mode)
(tabbar-mode)
(winner-mode)

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

;; (define-key slime-mode-map "\M-\C-a" 'slime-beginning-of-defun)
;; (define-key slime-mode-map "\M-\C-e" 'slime-end-of-defun)
;; (define-key slime-mode-map "\C-c\M-q" 'slime-reindent-defun)
;; (global-set-key "\C-c\C-q" 'slime-close-all-parens-in-sexp)
;; (global-set-key "\C-]" 'slime-close-all-parens-in-sexp)

(if (window-system)
  (set-frame-height (selected-frame) 60))

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:foreground "wheat" :background "black"))))
;;  '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
;;  '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
;;  '(font-lock-comment-face ((t (:foreground "SteelBlue1"))))
;;  '(font-lock-function-name-face ((t (:foreground "gold"))))
;;  '(font-lock-keyword-face ((t (:foreground "springgreen"))))
;;  '(font-lock-type-face ((t (:foreground "PaleGreen"))))
;;  '(font-lock-variable-name-face ((t (:foreground "Coral"))))
;;  '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "wheat" :box (:line-width 2 :color "grey75" :style released-button)))))
;;  '(mode-line ((t (:foreground "black" :background "light slate gray"))))
;;  '(slime-repl-result-face ((t (:foreground "orange"))))
;;  '(tabbar-default ((t (:inherit variable-pitch :background "gray75" :foreground "grey75" :height 0.8))))
;;  '(tabbar-unselected ((t (:inherit tabbar-default :foreground "black" :box (:line-width 1 :color "white" :style released-button)))))
;;  '(tool-bar ((((type x w32 mac) (class color)) (:background "midnight blue" :foreground "wheat" :box (:line-width 1 :style released-button))))))
