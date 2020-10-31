;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name    "Ziyang Lin"
      user-mail-address "jakelinnzy@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13 :weight 'regular)
    doom-variable-pitch-font (font-spec :family "Noto Sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one
      doom-one-brighter-comments t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq undo-limit 100000000            ;; Raise undo limit to 100MB
      ;; -want-fine-undo t           ;; More granular undo
      truncate-string-ellipsis "…")   ;; Display unicode clipsis

;; Maximize the Emacs window on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq evil-shift-width 4
      evil-split-window-below t
      evil-vsplit-window-right t)

;; which-key
(setq which-key-idle-delay 0.5
      which-key-idle-secondary-delay 0)


;; lsp-mode
(setq lsp-enable-snippet t
    lsp-idle-delay 0.2)

;; ivy
(setq ivy-posframe-width 100
    ivy-posframe-height 25)

;; projectile
;; Where to find projects
(setq projectile-project-search-path
    '("~/repos/"))
;; Project root patterns
(setq projectile-project-root-files
    '(".root" "Cargo.toml" "requirements.txt"))
;; Don't automatically add emacs sources into project list.
(setq projectile-ignored-projects
    '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
    "Return t if FILEPATH is within any of `projectile-ignored-projects'"
    (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

;; avy (Emacs style EasyMotion equivalent)
;; Use all lowercase leters plus semicolon
(setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l
                 ?q ?w ?e ?r ?t ?y ?u ?i ?o ?p
                 ?z ?x ?c ?v ?b ?n ?m 59))

;; duplicate functionality as avy
(after! evil-snipe
    (evil-snipe-mode -1))

;; ;; Show snippets in company's completion list
;; (after! yasnippet
;;     (defvar company-mode/enable-yas t
;;         "Enable yasnippet for all backends")
;;     (defun company-mode/backend-with-yas (backend)
;;         (if (or (not company-mode/enable-yas)
;;                 (and (listp backend) (member 'company-yasnippet backend)))
;;             backend
;;             (append (if (consp backend) backend (list backend))
;;                 '(:with company-yasnippet))))
;;     (setq company-backends
;;         (mapcar #'company-mode/backend-with-yas company-backends)))

;; don't show fill column indicator by default
(setq display-fill-column-indicator nil)

;; Treat underscore as a part of word
(modify-syntax-entry ?_ "w")

(load! "+bindings")
