
;; (require 'slime)
;; (require 'slime-repl)
(require 'clojure-mode)
(require 'cljdoc)
(require 'paredit)

;; paredit everywhere
;; (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;; (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
;; (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

(setq blink-matching-paren nil)

(setq slime-protocol-version 'ignore)

;; By default inputs and results have the same color
(custom-set-faces
 '(slime-repl-result-face ((t (:foreground "orange")))))

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
             return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
   open and indent an empty line between the cursor and the text.  Move the
   cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(defun paredit-eager-kill-line
  ()
  "Kills the current line or join the next line 
   if the point is at the end of the line"
  (interactive)
  (let ((current-point (point))
        (bol-point (line-beginning-position))
        (eol-point (line-end-position)))
    (if (and (= current-point eol-point)
             (/= current-point bol-point))
        (delete-indentation 1)
      (paredit-kill nil))))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-c 0") 'paredit-forward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c )") 'paredit-forward-barf-sexp)
          (define-key paredit-mode-map (kbd "C-c 9") 'paredit-backward-slurp-sexp)
          (define-key paredit-mode-map (kbd "C-c (") 'paredit-backward-barf-sexp)
          (define-key paredit-mode-map (kbd "M-R") 'paredit-raise-sexp)
          (define-key paredit-mode-map (kbd "M-r") nil)
          (define-key paredit-mode-map (kbd "C-k") 'paredit-eager-kill-line)))

(add-hook 'slime--mode-hook
          '(lambda ()
             ;; (define-key slime-mode-map (kbd "M-p") nil)
             ))

(add-hook 'slime-repl-mode-hook
          '(lambda ()
             (clojure-mode-font-lock-setup)
             (paredit-mode t)
             (set-syntax-table clojure-mode-syntax-table)
             (define-key slime-repl-mode-map (kbd "C-c r")
               '(lambda ()
                  (interactive)
                  (slime-repl-previous-matching-input (slime-repl-current-input))))
             (define-key slime-repl-mode-map
               (kbd "<C-return>") '(lambda ()
                                     (interactive)
                                     (switch-to-buffer nil)))
             (define-key slime-repl-mode-map (kbd "C-c s") 'slime-repl-next-matching-input)
             (define-key slime-repl-mode-map (kbd "<return>") 'paredit-newline)
             (define-key slime-repl-mode-map (kbd "<S-return>") 'slime-repl-closing-return)
             (define-key slime-repl-mode-map "{" 'paredit-open-brace)
             (define-key slime-repl-mode-map "}" 'paredit-close-brace)
             ;; (define-key slime-repl-mode-map (kbd "M-r") 'slime-repl-previous-matching-input)
             ))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (paredit-mode t)

            (turn-on-eldoc-mode)
            (eldoc-add-command
             'paredit-backward-delete
             'paredit-close-round)

            (local-set-key (kbd "RET") 'electrify-return-if-match)
            (eldoc-add-command 'electrify-return-if-match)

            (show-paren-mode t)))


(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode t)
            ;; (local-set-key (kbd "RET") 'electrify-return-if-match)
            (show-paren-mode t)))

(defun earmuffy (&optional arg)
  (interactive "P")
  (let* ((variable (thing-at-point 'sexp))
         (bounds (bounds-of-thing-at-point 'sexp))
         (current-point (point))
         (earmuffed-variable (concat "*" variable "*")))
    (save-excursion)
    (kill-region (car bounds) (cdr bounds))
    (if arg
        ;; unearmuffy
        (progn
          (insert (substring variable 1 (- (length variable) 1)))
          (goto-char (- current-point 1)))
      ;; earmuffy
      (progn
        (insert earmuffed-variable)
        (goto-char (+ current-point 1))))))

(defun clojure-correct-ns
  ()
  "Returns the namespace name that the file should have."
 (let* ((nsname ())
        (dirs (reverse (split-string (buffer-file-name) "/")))
        (aftersrc nil))
   (dolist (dir dirs)
     (when (not aftersrc)
       (if (or (string= dir "src") (string= dir "test"))
           (setq aftersrc t)
         (setq nsname (append nsname (list dir "."))))))
   (when nsname
     (replace-regexp-in-string "_" "-" (substring (apply 'concat (reverse nsname))  1 -4)))))

(defun clojure-update-ns
  ()
  "Updates the namespace of the current buffer. Useful if a file has been renamed."
  (interactive)
  (let ((nsname (clojure-correct-ns)))
    (when nsname
      (clojure-find-package) ;; function defined in clojure-mode
      (replace-match nsname nil nil nil 4))))

(add-hook 'clojure-mode-hook
  '(lambda ()
     (paredit-mode t)
     (define-key clojure-mode-map [f5] 'slime-compile-and-load-file)
     (define-key clojure-mode-map [f7] 'slime-edit-definition-with-etags)
     (define-key clojure-mode-map (kbd "C-*") 'earmuffy)
     (define-key clojure-mode-map "{" 'paredit-open-brace)
     (define-key clojure-mode-map "}" 'paredit-close-brace)))

(add-hook 'emacs-lisp-mode
          '(lambda ()
             (elisp-slime-nav-mode t)
             (define-key emacs-lisp-mode-map (kbd "M-.")'elisp-slime-nav-find-elisp-thing-at-point)
             (define-key emacs-lisp-mode-map (kbd "M-/") 'lisp-complete-symbol)
             (define-key emacs-lisp-mode-map (kbd "C-M-/") 'dabbrev-expand)
             (define-key emacs-lisp-mode-map [f5] 'eval-buffer)
             (define-key emacs-lisp-mode-map (kbd "M-o") nil)))