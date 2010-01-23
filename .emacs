

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))



;;; EMACS customization via the menu


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; fonts
(if (eq window-system 'x)
  (set-default-font "Inconsolata-12"))

;; no stupid tabs, spaces instead!
(setq-default indent-tabs-mode nil)

;; colors
(load-file "~/.emacs.d/colors.el")

;; enable paredit for Lisp / Clojure modes / SLIME REPL
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp clojure slime slime-repl))



;; set CLASSPATH for Clojure and SLIME

(setq swank-clojure-classpath (list "~/.swank-clojure/*"
                                    "~/Documents/Projects/Clojure/ansicommonlisp-book-clojure/ch05/"
                                    "classes"))

;; global bindings
(global-set-key [C-tab] 'other-window)
(global-set-key "\r" 'newline-and-indent)

;; bindings
(eval-after-load "paredit"
  '(progn
     (mapc (lambda (binding)
             (define-key paredit-mode-map (car binding) (cadr binding)))
           `(;(,(kbd "RET")  newline)
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