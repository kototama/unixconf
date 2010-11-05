(add-to-list 'load-path "~/.emacs.d/emacs-modes/slime/")
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
(defadvice slime-read-interactive-args (before add-clojure)
  (require 'assoc)
  (aput 'slime-lisp-implementations 'clojure
	(list (swank-clojure-cmd) :init 'swank-clojure-init)))

(require 'slime)
(require 'slime-repl)
(require 'paredit)
(require 'elein)
(require 'highlight-80+)
(require 'durendal)
(require 'clojure-mode)
(require 'swank-clojure)
(require 'auto-complete)
(require 'ac-slime)
(require 'swank-clojure-extra)

(setq inferior-lisp-program "cd /home/pal/Documents/Projects/carneades/src/CarneadesEditor ; lein swank")

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-mode-hook 'slime-redirect-inferior-output)

(setq slime-protocol-version 'ignore)

;(set-face-foreground 'paren-face "blue4")
(setq hl-paren-colors
       '("purple" "magenta1" "slateblue1" "cyan1" "springgreen1" "green1"
       "greenyellow" "yellow1" "orange1"))
;; ("orange1" "yellow1" "greenyellow" "green1"
;;         "springgreen1" "cyan1" "slateblue1" "magenta1" "purple")


(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))
; (add-to-list 'slime-lisp-implementations '(scheme ("mzscheme")))

;; load scheme-mode for .sls files
(setq auto-mode-alist (cons '("\\.sls$" . scheme-mode) auto-mode-alist))

;; enable paredit for Lisp / Clojure modes / SLIME REPL
(mapc (lambda (mode)
	(let ((hook (intern (concat (symbol-name mode)
				    "-mode-hook"))))
	  (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp scheme lisp inferior-lisp inferior-scheme clojure slime
                   slime-repl))

;; define lein-swank command
;; (defun lein-swank ()
;;   (interactive)
;;   (let ((root (locate-dominating-file default-directory "project.clj")))
;;     (when (not root)
;;       (error "Not in a Leiningen project."))
;;     ;; you can customize slime-port using .dir-locals.el
;;     (shell-command (format "cd %s && lein swank %s &" root slime-port)
;;                    "*lein-swank*")
;;     (set-process-filter (get-buffer-process "*lein-swank*")
;;                         (lambda (process output)
;;                           (when (string-match "Connection opened on" output)
;;                             (slime-connect "localhost" slime-port)
;;                             (set-process-filter process nil))))
;;     (message "Starting swank server...")))

(eval-after-load "slime"
  '(progn
     ;; "Extra" features (contrib)
     (slime-setup 
      '(slime-repl slime-banner slime-fuzzy)) ;; slime-highlight-edits
     ;; define <return> as paredit-newline, just type <C-return>
     ;; to evaluate the expression
     (define-key slime-repl-mode-map (kbd "<return>") 'paredit-newline)
     (define-key slime-repl-mode-map (kbd "<S-return>")
       'slime-repl-closing-return)
     (define-key slime-repl-mode-map (kbd "<C-return>") '(lambda ()
                                                           (interactive)
                                                           (switch-to-buffer nil)))
     (define-key slime-repl-mode-map (kbd "<f9>") 'slime-restart-inferior-lisp)
     (define-key slime-repl-mode-map (kbd "<f3>") 'slime-edit-definition)
     ;;(define-key slime-repl-mode-map (kbd "C-M-p") 'slime-repl-backward-input)
     (setq
      ;; Use UTF-8 coding
      slime-net-coding-system 'utf-8-unix
      ;; Use fuzzy completion (M-Tab)
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     
     ;; Use parentheses editing mode paredit
     (paredit-mode t)
     ;; (highlight-parentheses-mode nil)
     ))

(add-hook 'slime-repl-mode-hook '(lambda ()
                                   (paredit-mode t)
                                   (clojure-mode-font-lock-setup)))

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
      'swank-clojure-slime-repl-modify-syntax t)
    ;; Add classpath for Incanter (just an example)
    ;; The preferred way to set classpath is to use swank-clojure-project
                                        ;(add-to-list 'swank-clojure-classpath 
     ;            "~/Documents/Projects/carneades/trunk/clojure/Carneades/src/")
    ;(add-to-list 'swank-clojure-classpath 
     ;            "~/Documents/Projects/carneades/trunk/clojure/Carneades/lib/jgraphx.jar")
    ;(add-to-list 'swank-clojure-classpath 
     ;            "~/Documents/Projects/carneades/trunk/clojure/Carneades/test/"))
    ))

(add-hook 'paredit-mode-hook
          (lambda ()
            (define-key paredit-mode-map (kbd "\r") 'paredit-newline)
            ;; (highlight-parentheses-mode t)
            ;; copy a sexp without killing it (BETA)
            (define-key paredit-mode-map (kbd "M-k")
              '(lambda ()
                 (interactive)
                 (mark-sexp)
                 (let ((cur (point))
                       (beg (progn
                              (paredit-backward)
                              (paredit-backward)
                              (point)))
                       (end (progn
                              (paredit-forward)
                              (point))))
                   (copy-region-as-kill beg end))))))

(add-hook 'inferior-scheme-mode-hook
          (lambda ()
            (define-key inferior-scheme-mode-map (kbd "<C-return>")
              'comint-send-input)))

(add-hook 'clojure-mode-hook
          (lambda ()
            (durendal-enable-auto-compile)
            (define-key clojure-mode-map (kbd "<f2>") 'elein-swank)
            (define-key clojure-mode-map (kbd "<f3>") 'elein-swank)
            (define-key clojure-mode-map (kbd "<f7>") 'swank-clojure-project)
            (highlight-80+-mode t)
            (auto-complete-mode t)))

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (highlight-80+-mode)))
