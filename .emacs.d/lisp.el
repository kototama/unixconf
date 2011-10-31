
(add-to-list 'load-path "~/.emacs.d/emacs-modes/slime/contrib/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/clojure-mode/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/swank-clojure/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/paredit/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/highlight-80+/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/emacs-modes/misc/")

;; Customize swank-clojure start-up to reflect possible classpath changes
;; M-x ielm `slime-lisp-implementations RET or see `swank-clojure.el'
;; for more info 
;; (defadvice slime-read-interactive-args (before add-clojure)
;;   (require 'assoc)
;;   (aput 'slime-lisp-implementations 'clojure
;; 	(list (swank-clojure-cmd) :init 'swank-clojure-init)))

(require 'slime)
(require 'slime-repl)
(require 'paredit)
(require 'elein)
(require 'highlight-80+)
(require 'clojure-mode)
(require 'swank-clojure)
;; (require 'auto-complete)
;; (require 'ac-slime)
(require 'swank-clojure-extra)

;; (setq inferior-lisp-program "cd /home/pal/Documents/Projects/carneades/src/CarneadesEditor ; lein swank")

;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-mode-hook 'slime-redirect-inferior-output)

(setq slime-protocol-version 'ignore)

;(set-face-foreground 'paren-face "blue4")
(setq hl-paren-colors
       '("purple" "magenta1" "slateblue1" "cyan1" "springgreen1" "green1"
       "greenyellow" "yellow1" "orange1"))
;; ("orange1" "yellow1" "greenyellow" "green1"
;;         "springgreen1" "cyan1" "slateblue1" "magenta1" "purple")


(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

;; load scheme-mode for .sls files
(setq auto-mode-alist (cons '("\\.sls$" . scheme-mode) auto-mode-alist))

;; enable paredit for Lisp / Clojure modes / SLIME REPL
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp scheme lisp inferior-lisp inferior-scheme clojure
                   ;; slime
                   ;; slime-repl
                   ))

(eval-after-load "slime"
  '(progn
     ;; "Extra" features (contrib)
     (slime-setup 
      '(slime-repl slime-banner slime-fuzzy))
     ;; define <return> as paredit-newline, just type <C-return>
     ;; to evaluate the expression
     (define-key slime-repl-mode-map (kbd "<return>") 'paredit-newline)
     (define-key slime-repl-mode-map (kbd "<S-return>")
       'slime-repl-closing-return)
     (define-key slime-repl-mode-map
       (kbd "<C-return>") '(lambda ()
                             (interactive)
                             (switch-to-buffer nil)))
     (setq
      ;; Use UTF-8 coding
      slime-net-coding-system 'utf-8-unix
      ;; Use fuzzy completion (M-Tab)
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))

(add-hook 'slime-repl-mode-hook
          '(lambda ()
             (clojure-mode-font-lock-setup)
             (paredit-mode t)
             (define-key slime-repl-mode-map (kbd "C-c r")
               '(lambda ()
                  (interactive)
                  (slime-repl-previous-matching-input (slime-repl-current-input))))
             (define-key slime-repl-mode-map (kbd "C-c s")
               'slime-repl-next-matching-input)))

;; By default inputs and results have the same color
;; Customize result color to differentiate them
;; Look for `defface' in `slime-repl.el' if you want to further customize
(custom-set-faces
 '(slime-repl-result-face ((t (:foreground "orange")))))

(eval-after-load "swank-clojure"
  '(progn
    ;; Make REPL more friendly to Clojure (ELPA does not include this?)
    ;; The function is defined in swank-clojure.el but not used?!?
    (add-hook 'slime-repl-mode-hook
      'swank-clojure-slime-repl-modify-syntax t)))

(add-hook 'paredit-mode-hook
          (lambda ()
            ;; (define-key paredit-mode-map (kbd "<return>") '())
            ))

(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode t)
            (highlight-80+-mode t)
            (durendal-enable-auto-compile)
            (define-key clojure-mode-map (kbd "<f3>") 'slime-edit-definition)
            ;; (auto-complete-mode t)
            (slime-mode t)))

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (highlight-80+-mode t)))

