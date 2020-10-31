;; Generated with doom-emacs/config.org    -*- lexical-binding: t -*-

(setq user-full-name    "Ziyang Lin"
      user-mail-address "jakelinnzy@gmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13 :weight 'regular)
    doom-variable-pitch-font (font-spec :family "Noto Sans"))

(setq doom-theme 'doom-one
      doom-one-brighter-comments t)

(setq display-line-numbers-type 'relative)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq undo-limit 100000000            ;; Raise undo limit to 100MB
      evil-want-fine-undo t           ;; More granular undo
      truncate-string-ellipsis "…")   ;; Display unicode clipsis

(setq tab-width 4
      evil-shift-width 4)
(setq-default indent-tabs-mode nil)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(modify-syntax-entry ?_ "w")

(setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l
                 ?q ?w ?e ?r ?t ?y ?u ?i ?o ?p
                 ?z ?x ?c ?v ?b ?n ?m 59))

(after! evil-snipe
    (evil-snipe-mode -1))

(defvar my-top-level-mode-map (make-sparse-keymap)
  "M-h/j/k/l to move between split windows.")
(map!
 (:map my-top-level-mode-map
    :nvm "M-h" #'windmove-left
    :nvm "M-j" #'windmove-down
    :nvm "M-k" #'windmove-up
    :nvm "M-l" #'windmove-right
  ))
(define-minor-mode my-top-level-mode
  "Allows to use M-h/j/k/l to move between split windows."
  ;; The initial value
  :init-value t
  ;; Indicator for mode line
  :lighter " my-top-level"
  ;; The minor mode map
  :keymap my-top-level-mode-map
  )
(define-globalized-minor-mode global-my-top-level-mode
  my-top-level-mode my-top-level-mode)
(add-to-list 'emulation-mode-map-alists
             `((my-top-level-mode . ,my-top-level-mode-map)))
(provide 'my-top-level-mode)

(map!
    ;; map j and k only in normal mode, so v10j works as expected.
    :n   "j"   #'evil-next-visual-line
    :n   "k"   #'evil-previous-visual-line
    ;; Use m and , to scroll
    :nm  "m"   #'evil-scroll-down
    :nm  ","   #'evil-scroll-up
    :n   "f"   #'avy-goto-char
    :n   "s"   #'avy-goto-char-2
    :nm  "M"   #'evil-set-marker
    :n   "RET" #'evil-ex-nohighlight
    :nvm "H"   #'beginning-of-line-text
    :nvm "L"   #'end-of-line
    ;; Use C-f/b/p/n in Insert mode
    :i   "C-p" #'previous-line
    :i   "C-n" #'next-line)

(map!
    ;; evil-scroll-up/down and Info-scroll-up/down are the opposite. wtf?
    (:mode Info-mode
        :nvm "m" #'Info-scroll-up
        :nvm "," #'Info-scroll-down)
    ;; Why the f**k is this called pdf-tools not pdf
    (:after pdf-tools
        (:map pdf-view-mode-map
            :nm "m" #'pdf-view-scroll-up-or-next-page
            :nm "," #'pdf-view-scroll-down-or-previous-page))
 
    ;; company-mode for completion
    (:after company
        :i "C-x C-x" #'company-complete
        (:map company-active-map
            ;; Tab accepts completion
            "TAB" #'company-complete-selection
            [tab] #'company-complete-selection
            ;; Return always inserts newline
            "RET"    #'newline-and-indent
            [return] #'newline-and-indent))

    ;; treemacs: NERDTree-like file explorer
    ;; C-t or SPC f t to open treemacs
    :nm "C-t" #'treemacs
    (:leader
        (:prefix ("f" . "file")
            :desc "Open treemacs" "t" #'treemacs))
    (:after treemacs
        (:map treemacs-mode-map
            "p"    nil
            "p a"  #'treemacs-add-project-to-workspace
            "p d"  #'treemacs-remove-project-from-workspace
            "m"    #'treemacs-move-file))

    (:after dired
        (:map dired-mode-map
            :nm "c" #'dired-create-empty-file
            :nm "C" #'dired-create-directory)))

(map!
    ;; SPC l g - Go to definition
    (:leader
        :desc "Format buffer"            "c f" #'lsp-format-buffer
        :desc "Go to definition"         "c g" #'evil-goto-definition
        :desc "Toggle maximized window"  "t M" #'toggle-frame-maximized)
    ;; Python's language server doens't support formatting, so a dedicated
    ;; plugin is needed.
    (:after python
        (:map python-mode-map
            :localleader
            :desc "Format with autopep8" "f" #'py-autopep8-buffer)))

(setq which-key-idle-delay 0.5
      which-key-idle-secondary-delay 0)

(setq ivy-posframe-width     100
      ivy-posframe-min-width 100
      ivy-posframe-height     25
      ivy-posframe-min-height 25)
;; (after! ivy
;;     (ivy-posframe-mode -1))

(setq lsp-enable-snippet t
      lsp-idle-delay 0.2)

(setq
      ;; Where to find projects
      projectile-project-search-path
          '("~/repos/")
      ;; Project root patterns
      projectile-project-root-files
          '(".root" "Cargo.toml" "requirements.txt")
      ;; Don't automatically add emacs sources into project list.
      projectile-ignored-projects
          '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
    "Return t if FILEPATH is within any of `projectile-ignored-projects'"
    (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(map! :mode org-mode
      (:localleader
       :desc "Execute buffer" "E" #'org-babel-execute-buffer))

(map! :mode org-mode
      (:localleader
       :desc "Toggle visibility of block" "v" #'org-hide-block-toggle))

(setq org-directory "~/Documents/org/")

(with-eval-after-load 'org
  (defvar-local rasmus/org-at-src-begin -1
    "Variable that holds whether last position was a ")

  (defvar rasmus/ob-header-symbol ?☰
    "Symbol used for babel headers")

  (defun rasmus/org-prettify-src--update ()
    (let ((case-fold-search t)
          (re "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*")
          found)
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward re nil t)
          (goto-char (match-end 0))
          (let ((args (org-trim
                       (buffer-substring-no-properties (point)
                                                       (line-end-position)))))
            (when (org-string-nw-p args)
              (let ((new-cell (cons args rasmus/ob-header-symbol)))
                (cl-pushnew new-cell prettify-symbols-alist :test #'equal)
                (cl-pushnew new-cell found :test #'equal)))))
        (setq prettify-symbols-alist
              (cl-set-difference prettify-symbols-alist
                                 (cl-set-difference
                                  (cl-remove-if-not
                                   (lambda (elm)
                                     (eq (cdr elm) rasmus/ob-header-symbol))
                                   prettify-symbols-alist)
                                  found :test #'equal)))
        ;; Clean up old font-lock-keywords.
        (font-lock-remove-keywords nil prettify-symbols--keywords)
        (setq prettify-symbols--keywords (prettify-symbols--make-keywords))
        (font-lock-add-keywords nil prettify-symbols--keywords)
        (while (re-search-forward re nil t)
          (font-lock-flush (line-beginning-position) (line-end-position))))))

  (defun rasmus/org-prettify-src ()
    "Hide src options via `prettify-symbols-mode'.
  `prettify-symbols-mode' is used because it has uncollpasing. It's
  may not be efficient."
    (let* ((case-fold-search t)
           (at-src-block (save-excursion
                           (beginning-of-line)
                           (looking-at "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*"))))
      ;; Test if we moved out of a block.
      (when (or (and rasmus/org-at-src-begin
                     (not at-src-block))
                ;; File was just opened.
                (eq rasmus/org-at-src-begin -1))
        (rasmus/org-prettify-src--update))
      ;; Remove composition if at line; doesn't work properly.
      ;; (when at-src-block
      ;;   (with-silent-modifications
      ;;     (remove-text-properties (match-end 0)
      ;;                             (1+ (line-end-position))
      ;;                             '(composition))))
      (setq rasmus/org-at-src-begin at-src-block)))

  (defun rasmus/org-prettify-symbols ()
    (mapc (apply-partially 'add-to-list 'prettify-symbols-alist)
          (cl-reduce 'append
                     (mapcar (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                             `(("#+begin_src" . ?➤) ;; ➤ 🖝 ➟ ➤ ✎
                               ("#+end_src"   . ?¶) ;; ⏹
                               ("#+header:" . ,rasmus/ob-header-symbol)
                               ("#+begin_quote" . ?»)
                               ("#+end_quote" . ?«)))))
          (turn-on-prettify-symbols-mode)
          ;;(add-hook 'post-command-hook 'rasmus/org-prettify-src t t)
          )
(add-hook 'org-mode-hook #'rasmus/org-prettify-symbols))

"Done."
