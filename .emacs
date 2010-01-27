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
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "wheat" :background "black"))))
 '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
 '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
 '(font-lock-comment-face ((t (:foreground "SteelBlue1"))))
 '(font-lock-function-name-face ((t (:foreground "gold"))))
 '(font-lock-keyword-face ((t (:foreground "springgreen"))))
 '(font-lock-type-face ((t (:foreground "PaleGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "Coral"))))
 '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "wheat" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(mode-line ((t (:foreground "black" :background "light slate gray"))))
 '(tool-bar ((((type x w32 mac) (class color)) (:background "midnight blue" :foreground "wheat" :box (:line-width 1 :style released-button))))))

;; fonts
(if (eq window-system 'x)
  (set-default-font "Inconsolata-12"))

;; no stupid tabs, spaces instead!
(setq-default indent-tabs-mode nil)

;; colors
(load-file "~/.emacs.d/colors.el")

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; clojure-mode
(add-to-list 'load-path "/opt/clojure-mode")
(require 'clojure-mode)

;; paredit
(add-to-list 'load-path "/opt/paredit-20")
(autoload 'paredit-mode "paredit")


;; swank-clojure
(add-to-list 'load-path "/opt/swank-clojure/src/emacs")

;; set CLASSPATH for Clojure and SLIME
(setq swank-clojure-jar-path "/opt/clojure/clojure.jar"
      swank-clojure-extra-classpaths (list
				      "/opt/swank-clojure/src/main/clojure"
				      "/opt/clojure-contrib/clojure-contrib.jar"
                                      "~/Documents/Projects/Clojure/ansicommonlisp-book-clojure/ch05"
                                      "~/Documents/Projects/Clojure/ansicommonlisp-book-clojure/ch05/classes"))

(require 'swank-clojure-autoload)

;; Slime
(eval-after-load "slime"
   '(progn (slime-setup '(slime-repl))
           ;; define <return> as paredit-newline, just type C-<return>
           ;; to evaluate the expression
           (define-key slime-repl-mode-map (kbd "<return>") 'paredit-newline)))

(add-to-list 'load-path "/opt/slime")
(require 'slime)
;; (slime-setup)

;; Adding sbcl to Slime
(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))
(setq slime-default-lisp 'clojure)

;; enable paredit for Lisp / Clojure modes / SLIME REPL
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp clojure slime slime-repl))

;; global bindings
(global-set-key [C-tab] 'other-window)
(global-set-key "\r" 'newline-and-indent)

;; bindings
(eval-after-load "paredit"
  '(progn
     (mapc (lambda (binding)
             (define-key paredit-mode-map (car binding) (cadr binding)))
           `(			      ;(,(kbd "RET")  newline)
					;(,(kbd "C-j")  paredit-newline)
             (,(kbd "\r") paredit-newline)
					;(,(kbd "<C-left>") paredit-forward-barf-sexp)
					;(,(kbd "<C-right>") paredit-forward-slurp-sexp))
             ))))

;; (define-key slime-mode-map "\M-\C-a" 'slime-beginning-of-defun)
;; (define-key slime-mode-map "\M-\C-e" 'slime-end-of-defun)
;; (define-key slime-mode-map "\C-c\M-q" 'slime-reindent-defun)
;; (global-set-key "\C-c\C-q" 'slime-close-all-parens-in-sexp)
;; (global-set-key "\C-]" 'slime-close-all-parens-in-sexp)


; This fits my screen (1680x1024)
;; (when window-system
;;         (set-frame-height (selected-frame) 225)
;;         (set-frame-width (selected-frame) 230))