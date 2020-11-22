;; -*- lexical-binding: t -*-

;; Some functions taken from the elpy package
;; https://github.com/jorgenschaefer/elpy/blob/master/snippets/python-mode/.yas-setup.el

(defvar elpy-snippet-split-arg-arg-regex
"\\([[:alnum:]*]+\\)\\(:[[:blank:]]*[[:alpha:]]*\\)?\\([[:blank:]]*=[[:blank:]]*[[:alnum:]]*\\)?"
"Regular expression matching an argument of a python function.
First group should give the argument name.")

(defvar elpy-snippet-split-arg-separator
"[[:blank:]]*,[[:blank:]]*"
"Regular expression matching the separator in a list of argument.")

(defun elpy-snippet-split-args (arg-string)
  "Split the python argument string ARG-STRING into a tuple of argument names."
  (mapcar (lambda (x)
            (when (string-match elpy-snippet-split-arg-arg-regex x)
              (match-string-no-properties 1 x)))
          (split-string arg-string elpy-snippet-split-arg-separator t)))

(defun elpy-snippet-init-assignments (arg-string)
  "Return the typical __init__ assignments for arguments in ARG-STRING."
  (let ((indentation (make-string (save-excursion
                                    (goto-char start-point)
                                    (current-indentation))
                                  ?\s)))
    (mapconcat (lambda (arg)
                 (if (string-match "^\\*" arg)
                     ""
                   (format "self.%s = %s\n%s" arg arg indentation)))
               (elpy-snippet-split-args arg-string)
               "")))
