(require 'anything)
(require 'anything-config)

(defun files-in-below-directory (directory)
  "List the .el files in DIRECTORY and in its sub-directories."
  (interactive "DDirectory name: ")
  (let (el-files-list
        (current-directory-list
         (directory-files-and-attributes directory t)))
    ;; while we are in the current directory
    (while current-directory-list
      (message (car (car current-directory-list)))
      (cond
       ;; check whether filename is that of a directory
       ((eq t (car (cdr (car current-directory-list))))
        ;; decide whether to skip or recurse
        (if
            (equal "."
                   (substring (car (car current-directory-list)) -1))
            ;; then do nothing since filename is that of
            ;;   current directory or parent, "." or ".."
            ()
          ;; else descend into the directory and repeat the process
          (setq el-files-list
                (append
                 (files-in-below-directory
                  (car (car current-directory-list)))
                 el-files-list))))
       
       (t
        (setq el-files-list
              (cons (car (car current-directory-list)) el-files-list)))
       
       )
      ;; move to the next filename in the list; this also
      ;; shortens the list so the while loop eventually comes to an end
      (setq current-directory-list (cdr current-directory-list)))
    ;; return the filenames
    el-files-list))

;; anything conf
(defun make-anything-directory-source (source-name dir)
  "Returns an anything source for a particular directory"
  `((name . ,(concat source-name))
	(candidates . (lambda ()
					(directory-files
					 ,dir)))
	(action . find-file)
	(type . file)))

(defun make-anything-recursive-directory-source (source-name dir)
  "Returns an anything source for a particular directory"
  `((name . ,(concat source-name))
	(candidates . (lambda ()
                        (files-in-below-directory
                         ,dir)))
	(action . find-file)
	(type . file)))


(setf anything-projects-source (make-anything-recursive-directory-source "Project files" "~/Documents/Projects/landoflisp-book-elisp"))
(setf anything-emacsdir-source (make-anything-recursive-directory-source "~/.emacs.d" "~/.emacs.d"))

(defun my-anything ()
       (interactive)
       (anything-other-buffer
        '(anything-c-source-buffers
          anything-c-source-file-name-history
          ;; anything-c-source-info-pages
          ;; anything-c-source-info-elisp
          ;; anything-c-source-man-pages
          ;; anything-c-source-locate
          ;; anything-c-source-emacs-commands
          anything-projects-source
          anything-emacsdir-source
          )
        "*my-anything*"))
