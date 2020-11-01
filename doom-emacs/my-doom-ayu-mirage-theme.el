;;; my-doom-ayu-mirage-theme.el -*- no-byte-compile: t; -*-
;;; Based on ayu-mirage color scheme and doom-one
(require 'doom-themes)

;;
(defgroup my-doom-ayu-mirage-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom my-doom-ayu-mirage-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'my-doom-ayu-mirage-theme
  :type 'boolean)

;; (defcustom my-doom-ayu-mirage-comment-bg my-doom-ayu-mirage-brighter-comments
;;   "If non-nil, comments will have a subtle, darker background. Enhancing their
;; legibility."
;;   :group 'my-doom-ayu-mirage-theme
;;   :type 'boolean)

(defcustom my-doom-ayu-mirage-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'my-doom-ayu-mirage-theme
  :type '(choice integer boolean))

;;
(def-doom-theme my-doom-ayu-mirage
  "A dark theme inspired by Atom One Dark"

  ;; name        default   256       16
  ((bg         '("#1f2430" nil       nil            ))
   (bg-alt     '("#191e2a" nil       nil            ))
   (base0      '("#1B2229" "black"   "black"        ))
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"  ))
   (base2      '("#202328" "#2e2e2e" "brightblack"  ))
   (base3      '("#23272e" "#262626" "brightblack"  ))
   (base4      '("#3f444a" "#3f3f3f" "brightblack"  ))
   (base5      '("#5c6773" "#525252" "brightblack"  ))
   (base6      '("#7c8793" "#6b6b6b" "brightblack"  ))
   (base7      '("#9ca0a4" "#979797" "brightblack"  ))
   (base8      '("#DFDFDF" "#dfdfdf" "white"        ))
   (fg         '("#cbccc6" "#bfbfbf" "brightwhite"  ))
   (fg-alt     '("#707a8c" "#2d2d2d" "white"        ))
   (accent     '("#ffcc66" "#ecbe7b" "yellow"       ))
   (accent1    '("#ffd57f" "#ffd700" "yellow"       ))
   (accent2    '("#ffc44c" "#ffd75f" "yellow"       ))
   (accent3    '("#ffae57" "#ffaf87" "yellow"       ))

   (grey       base4)
   (red        '("#ff3333" "#ff6655" "red"          ))
   (orange     '("#ffa759" "#dd8844" "brightred"    ))
   (green      '("#bae67e" "#99bb66" "green"        ))
   (teal       '("#95e6cb" "#44b9b1" "brightgreen"  ))
   (yellow     '("#ffd580" "#ECBE7B" "yellow"       ))
   (blue       '("#73d0ff" "#51afef" "brightblue"   ))
   (dark-blue  '("#39bae6" "#2257A0" "blue"         ))
   (magenta    '("#f28779" "#c678dd" "brightmagenta"))
   (coral      '("#f29e74" "#ff8787" "brightmagenta"))
   (violet     '("#d4bfff" "#a9a1e1" "magenta"      ))
   (cyan       '("#5ccfe6" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#39bae6" "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      accent)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if my-doom-ayu-mirage-brighter-comments base6 base5))
   (doc-comments   (doom-lighten (if my-doom-ayu-mirage-brighter-comments base6 base5) 0.25))
   (constants      violet)
   (functions      accent1)
   (keywords       accent3)
   (methods        accent1)
   (operators      coral)
   (type           cyan)
   (strings        green)
   (variables      fg)
   (numbers        violet)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-pad
    (when my-doom-ayu-mirage-padded-modeline
      (if (integerp my-doom-ayu-mirage-padded-modeline) my-doom-ayu-mirage-padded-modeline 4)))

   (modeline-fg     fg)
   (modeline-fg-alt base5)

   (modeline-bg
    (if nil
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if nil
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg-alt)))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   (evil-goggles-default-face :inherit 'region :background (doom-blend region bg 0.5))

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)

   ;; (font-lock-comment-face
   ;;  :foreground comments
   ;;  :background (if my-doom-ayu-mirage-comment-bg (doom-lighten bg 0.05)))
   ;; (font-lock-doc-face
   ;;  :inherit 'font-lock-comment-face
   ;;  :foreground doc-comments)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground accent)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; Doom modeline
   (doom-modeline-bar :background accent)
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;; ivy-mode
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; LaTeX-mode
   (font-latex-math-face :foreground green)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ()
  )

;;; my-doom-ayu-mirage-theme.el ends here
