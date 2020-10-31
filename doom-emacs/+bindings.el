;; $DOOMDIR/+bindings.el -*- lexical-binding: t; -*-

(map!
    :n   "f"   #'avy-goto-char
    :n   "s"   #'avy-goto-char-2
    :nm  "M"   #'evil-set-marker
    :nm  "m"   #'evil-scroll-down
    :nm  ","   #'evil-scroll-up
    :n   "RET" #'evil-ex-nohighlight
    :n   "H"   #'beginning-of-line-text
    :n   "L"   #'end-of-line
    ;; M-h/j/k/l moves between splits
    :nvm "M-h" #'windmove-left
    :nvm "M-j" #'windmove-down
    :nvm "M-k" #'windmove-up
    :nvm "M-l" #'windmove-right
    ;; Use C-f/b/p/n in Insert mode
    :i   "C-p" #'previous-line
    :i   "C-n" #'next-line
    ;; SPC l g - Go to definition
    (:leader
        :desc "Format buffer"            "c f" #'lsp-format-buffer
        :desc "Go to definition"         "c g" #'evil-goto-definition
        :desc "Toggle maximized window"  "t M" #'toggle-frame-maximized))

;; Override evil-org's default bahaviour.
(add-hook! 'evil-org-mode-hook
    (defun my-org-mode-bindings ()
        (map!
            (:mode evil-org-mode
                :nvm "M-h" #'windmove-left
                :nvm "M-j" #'windmove-down
                :nvm "M-k" #'windmove-up
                :nvm "M-l" #'windmove-right))))

(map!
    ;; evil-scroll-up/down and Info-scroll-up/down are the opposite. wtf?
    (:mode Info-mode
        :nvm "m" #'Info-scroll-up
        :nvm "," #'Info-scroll-down)

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
            :nm "C" #'dired-create-directory))

    (:after python
        (:map python-mode-map
            :localleader
            :desc "Format with autopep8" "f" #'py-autopep8-buffer))

    ;; Why the f**k is this called pdf-tools not pdf
    (:after pdf-tools
        (:map pdf-view-mode-map
            :nm "m" #'pdf-view-scroll-up-or-next-page
            :nm "," #'pdf-view-scroll-down-or-previous-page)))
