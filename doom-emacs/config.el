;; Generated by doom-emacs/config.org    -*- lexical-binding: t; -*-

(setq user-full-name    "Ziyang Lin"
      user-mail-address "jakelinnzy@gmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font"
                           :size 13 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Apercu" :size 14)

      ;; This fixes CJK alignment issues on macOS
      ;; TODO make it also work on Linux
      doom-unicode-extra-fonts
      '("PingFang SC"
        "Weather Icons" "github-octicons" "FontAwesome"
        "all-the-icons" "file-icons" "Apple Color Emoji" "Menlo")
      face-font-rescale-alist '(("PingFang SC" . 1.25)))

;; (doom/reload-font)

;; load theme from user config directory
(add-to-list 'custom-theme-load-path doom-private-dir)
(setq doom-theme 'my-doom-ayu-mirage
      my-doom-ayu-mirage-brighter-comments t)

(setq display-line-numbers-type 'relative)
;; Disable line number for text mode
;; (remove-hook! '(text-mode-hook) #'display-line-numbers-mode)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq frame-title-format '("" "%b [%m] - Emacs"))

(setq fancy-splash-image
      (concat doom-private-dir "assets/emacs-icon-200x200.png"))

;; (setq indent-guide-char "│")
(setq highlight-indent-guides-method 'bitmap
      highlight-indent-guides-bitmap-function
      #'highlight-indent-guides--bitmap-line)

(defun my/doom-modeline-conditional-buffer-encoding ()
  "Hide the encoding information when it is not LF UTF-8."
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'my/doom-modeline-conditional-buffer-encoding)

(setq auto-save-default t             ;; enable autosave for file-buffers
      delete-by-moving-to-trash t     ;; sudo rm -rf /
      undo-limit (* 100 1024 1024)    ;; Raise undo limit to 100MB
      evil-want-fine-undo t           ;; More granular undo in insert state
      truncate-string-ellipsis "…"    ;; Display unicode elipsis
      ;; Don't pollute the system clipboard
      save-interprogram-paste-before-kill t
      ;; Don't compact font caches during GC, will improve performance of the modeline plugin
      inhibit-compacting-font-caches t
      ring-bell-function #'ignore     ;; Disable bell completely
      )

;; Enable soft wrapping by default (toggle with SPC t w), except in temp
;; buffers e.g. Dired, ibuffer
(add-hook! '(prog-mode-hook text-mode-hook)
           #'visual-line-mode)

;; This makes emacs-mac-port behave like any other Mac app in multiple
;; workspaces. e.g. when you are in another workspace and click Emacs' icon
;; in the Dock, you switch to the workspace Emacs is in.
(menu-bar-mode 1)

(setq tab-width 4
      evil-shift-width 4)
(setq-default indent-tabs-mode nil)

(setq evil-split-window-below t
      evil-vsplit-window-right t
      ;; :s command has the global flag by default, adding /g cancels the flag.
      evil-ex-substitute-global t
      ;; keep 5 lines from the margin
      scroll-margin 5
      ;; scroll-step 1
      )

(modify-syntax-entry ?_ "w")

(setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l
                 ?q ?w ?e ?r ?t ?y ?u ?i ?o ?p
                 ?z ?x ?c ?v ?b ?n ?m 59))

(after! evil-snipe
    (evil-snipe-mode -1))

;; In packages.el:
;;     (package! smartparens)
(require 'smartparens-config)
(after! smartparens-config
  ;; Enable triple backtick (markdown style quote)
  (sp-local-pair '(prog-mode text-mode) "```" "```"))
(after! smartparens-org
  ;; Disable ' in org-mode
  (sp-local-pair 'org-mode "'" nil :actions nil))

;; Yes I'm lazy
(setq company-minimum-prefix-length 1)

(add-hook 'doom-scratch-buffer-hook #'text-mode)

(defvar my-top-level-mode-map (make-sparse-keymap)
  "M-h/j/k/l to move between split windows.")
(map!
 (:map my-top-level-mode-map
  :nvm "M-h" #'windmove-left
  :nvm "M-j" #'windmove-down
  :nvm "M-k" #'windmove-up
  :nvm "M-l" #'windmove-right))
(define-minor-mode my-top-level-mode
  "Allows to use M-h/j/k/l to move between split windows."
  ;; The initial value
  :init-value t
  ;; Indicator for mode line
  :lighter " my-top-level"
  ;; The minor mode map
  :keymap my-top-level-mode-map)
(define-globalized-minor-mode global-my-top-level-mode
  my-top-level-mode my-top-level-mode)
;; This makes it take precedence over any other minor mode.
(add-to-list 'emulation-mode-map-alists
             `((my-top-level-mode . ,my-top-level-mode-map)))
(provide 'my-top-level-mode)

(map!
 :nm  "m"   #'evil-scroll-down
 :nm  ","   #'evil-scroll-up
 ;; m sets marker by default, move it to M
 :nm  "M"   #'evil-set-marker

 (:after info
  (:mode Info-mode
   :nm "m" #'evil-scroll-down
   :nm "," #'evil-scroll-up))

 ;; Why the f**k is this called pdf-tools not pdf
 (:after pdf-tools
  (:map pdf-view-mode-map
   :nm "m" #'pdf-view-scroll-up-or-next-page
   :nm "," #'pdf-view-scroll-down-or-previous-page)))

(map!
 ;; map j and k only in normal mode, so v10j works as expected.
 :n   "j"   #'evil-next-visual-line
 :n   "k"   #'evil-previous-visual-line
 :n   "RET" #'evil-ex-nohighlight
 ;; Home row keys jump to beginning and end of line
 :nvmo "H"   #'evil-first-non-blank
 :nvmo "L"   #'evil-end-of-line

 :nvo "f"   #'evil-avy-goto-char
 :n   "s"   #'evil-avy-goto-char-2
 ;; Use C-f/b/p/n in Insert mode
 :i   "C-p" #'previous-line
 :i   "C-n" #'next-line


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
   :desc "Open treemacs"           "t" #'treemacs
   :desc "Add project to treemacs" "T" #'treemacs-add-project-to-workspace))
 (:after treemacs
  (:map evil-treemacs-state-map
   "p"    nil
   "p a"  #'treemacs-add-project-to-workspace
   "p d"  #'treemacs-remove-project-from-workspace
   "m"    #'treemacs-move-file
   "v"    #'treemacs-peek
   "M-h"  nil
   "M-j"  nil
   "M-k"  nil
   "M-l"  nil))

 ;; Dired: 'c f' creates empty file, 'c d' creates directory
 ;; Make it consistent with treemacs
 (:after dired
  (:map dired-mode-map
   :nm "c"   nil
   :nm "c f" #'dired-create-empty-file
   :nm "c d" #'dired-create-directory)))

(defun my/toggle-vterm ()
  (interactive)
  (evil-force-normal-state)
  (+vterm/toggle nil)
  ;; Scroll to bottom and enter insert state when switching into the terminal
  (when (eq major-mode 'vterm-mode)
    (evil-insert-state)))

(map!
 ;; nvim
 :nvim "s-`" #'my/toggle-vterm)

(map!
 ;; SPC l g - Go to definition
 (:leader
  :desc "Format buffer"            "c f" #'lsp-format-buffer
  :desc "Go to definition"         "c g" #'evil-goto-definition
  :desc "Toggle maximized window"  "t M" #'toggle-frame-maximized
  :desc "Toggle monospace font"    "t m" #'mixed-pitch-mode
  :desc "Move workspace left"  "TAB <" #'+workspace/swap-left
  :desc "Move workspace right" "TAB >" #'+workspace/swap-right))

(setq which-key-idle-delay 0.5
      which-key-idle-secondary-delay 0)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

(setq treemacs-width 30)

(setq ivy-posframe-width     130
      ivy-posframe-min-width 130
      ivy-posframe-height     18
      ivy-posframe-min-height 10)
;; (after! ivy
;;   (ivy-posframe-mode -1))

(after! ivy
  (map! :map ivy-minibuffer-map
        "C-d" #'ivy-immediate-done
        "<S-Return>" #'ivy-immediate-done))

(after! magit
  ;; log output of all git commands
  (setq magit-git-debug nil)
  (map! :mode magit-mode
        :g "m" #'evil-scroll-down
        :g "," #'evil-scroll-up
        :g "M" #'magit-merge
        :g "R" #'magit-remote))
;; By default Magit is invoked with SPC g (a/b/c...)
;; These bindings can be directly accessed within the Magit status buffer
(map! :leader
      "g" nil
      :desc "Magit" "g" #'magit-status)

(after! ibuffer
  (map! :mode ibuffer-mode
        :i "j" #'evil-next-line
        :i "k" #'evil-previous-line
        :n "?" #'describe-mode))

(setq
 ;; Where to find projects
 projectile-project-search-path '("~/repos/")
 ;; Project root patterns
 projectile-project-root-files-bottom-up '(".root" "Cargo.toml" "requirements.txt")
 ;; Don't automatically add emacs sources into project list.
 projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))

(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(map! :map prog-mode-map
      :leader
      :desc "Run last make task" "c m" #'+make/run-last
      :desc "Run make task" "c M" #'+make/run)

;; (use-package taskrunner
;;   :commands (ivy-taskrunner))

(map! :leader
      :desc "resize-mode" "w e" #'resize-window)

;; redifine the keymap to be consistent with evil
(after! resize-window
  (setq resize-window-dispatch-alist
        '((?j resize-window--enlarge-down          " Resize - Expand down" t)
          (?k resize-window--enlarge-up            " Resize - Expand up" t)
          (?l resize-window--enlarge-horizontally  " Resize - horizontally" t)
          (?h resize-window--shrink-horizontally   " Resize - shrink horizontally" t)
          (?r resize-window--reset-windows         " Resize - reset window layout" nil)
          (?w resize-window--cycle-window-positive " Resize - cycle window" nil)
          (?W resize-window--cycle-window-negative " Resize - cycle window" nil)
          (?s split-window-below " Split window horizontally" nil)
          (?v split-window-right " Split window vertically" nil)
          (?k resize-window--delete-window " Delete window" nil)
          (?K resize-window--kill-other-windows " Kill other windows (save state)" nil)
          (?y resize-window--restore-windows " (when state) Restore window configuration" nil)
          (?? resize-window--display-menu          " Resize - display menu" nil))))
;;   List of actions for `resize-window-dispatch-default.
;;   Main data structure of the dispatcher with the form:
;;   \(char function documentation match-capitals\)

;; (after! pdf-view
;;   (require 'pdf-continuous-scroll-mode)
;;   (add-hook 'pdf-view-mode-hook #'pdf-continuous-scroll-mode))

(setq lsp-enable-snippet t
      lsp-idle-delay 1.0
      lsp-modeline-diagnostics-message t
      lsp-modeline-diagnostics-scope :file
      ;; improve performance by allowing to read more frequently
      ;; doom already takes care of gc
      read-process-output-max (* 5 1024 1024))

(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(after! spell-fu
  (remove-hook 'text-mode-hook
               #'spell-fu-mode))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs (concat doom-private-dir "snippets")))

(after! python
  (setq python-prettify-symbols-alist '(("lambda" . 955)))
  ;; Use Doom's format plugin instead of LSP
  (setq-hook! 'python-mode-hook
    +format-with-lsp nil
    +format-with 'black)
  (map! :mode python-mode
        :localleader
        "f" #'py-autopep8-buffer))
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

(setq +latex-viewers '(skim evince sumatrapdf zathura okular pdf-tools))
(after! latex
  (defun my/apply-tex-mode-maps ()
    "Apply tex-mode maps"
    (map! :map evil-tex-mode-map
          :nm "m" #'evil-scroll-down
          :nm "," #'evil-scroll-up
          :nm "M" #'evil-scroll-down
          (:localleader
           "a" #'TeX-command-run-all
           "b" #'TeX-command-buffer)))
  (add-hook 'LaTeX-mode-hook #'my/apply-tex-mode-maps))

(after! markdown-mode
  (map! :mode markdown-mode
        :localleader
        ;; consistent with org-mode
        :desc "Toggle hiding links" "l t" #'markdown-toggle-url-hiding))

(add-to-list 'load-path "~/.doom.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(setq org-directory "~/Documents/org/")

(setq org-ellipsis "▼"
      ;; Hides *bold* /italic/ etc.
      org-hide-emphasis-markers nil)

(map! :after org
      :mode org-mode
      (:localleader
       ;; Toggle visibility of current block
       :desc "Toggle visibility of block" "v" #'org-hide-block-toggle
       ;; Execute all code blocks in the org buffer
       :desc "Execute buffer" "E" #'org-babel-execute-buffer))

(after! org
  (add-hook! '(org-mode-hook dired-mode-hook)
             #'org-download-enable))

(setq my/enable-org-title-size nil)
(after! org
  ;; give titles different font size
  (when my/enable-org-title-size
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.0)
                    (org-level-6 . 1.0)
                    (org-level-7 . 1.0)
                    (org-level-8 . 1.0)))
      (set-face-attribute (car face) nil :font doom-variable-pitch-font :weight 'bold :height (cdr face))))
  ;; prettify symbols
  (defun my/prettify-org-setup ()
    (setq-local prettify-symbols-alist
                '(("#+begin_src" . ?➤) ;; ➤ 🖝 ➟ ➤ ✎
                  ("#+end_src"   . ?¶) ;; ⏹
                  ("#+header:" . ,rasmus/ob-header-symbol)
                  ("#+begin_quote" . ?»)
                  ("#+end_quote" . ?«)
                  ("#+begin_example" . ?➟)
                  ("#+end_example" . ?¶))
                prettify-symbols-unprettify-at-point 'right-edge)
    (prettify-symbols-mode 1))
  (add-hook 'org-mode-hook #'my/prettify-org-setup))

(after! org
  (load! "vendor/org-return-dwim" doom-private-dir)
  (map! :map evil-org-mode-map  ;; this overrides evil's default binding
        :i "RET"    #'unpackaged/org-return-dwim
        :i [return] #'unpackaged/org-return-dwim))

(after! org
  (load! "vendor/org-fix-blank-lines" doom-private-dir)
  (map! :mode org-mode
        :localleader
        :desc "Fix blank lines" "z" #'unpackaged/org-fix-blank-lines))

"Done."
