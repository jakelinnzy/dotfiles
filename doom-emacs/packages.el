;; -*- no-byte-compile: t; -*-
;;  $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)

;; not needed
(package! evil-snipe :disable t)

;; View magit diffs with delta
(package! magit-delta
    :recipe (:host github :repo "dandavison/magit-delta")
    :disable t)
;; Display proportional font but use monospace for code, tables, etc
(package! mixed-pitch
    :pin "d305108f9520e196b533f05d1dcc284cf535faaf")
(package! smartparens
    :pin "7f5825dd655942c3d56d14acabab1ffab1aa2ae2")
(package! resize-window
    :recipe (:host github :repo "dpsutton/resize-window")
    :pin "72018aa4d2401b60120588199d4cedd0dc1fbcfb")
;; (package! org-pretty-table
;;     :recipe (:host github :repo "Fuco1/org-pretty-table"))
;; (package! pdf-continuous-scroll-mode
;;     :recipe (:host github :repo "dalanicolai/pdf-continuous-scroll-mode.el"))

;; tree-sitter
(package! tree-sitter)
(package! tree-sitter-langs)

;; Arduino
(package! arduino-mode
    :recipe (:host github :repo "bookest/arduino-mode")
    :pin "3e2bad4569ad26e929e6db2cbcff0d6d36812698")
;; Python LSP doesn't support formatting
;; Use SPC m f to format python code instead.
(package! py-autopep8
    :pin "68e12d8788c91c7ec53a68acf1d23adb2ffa4788")

;; Write emails in org mode
;; (package! org-msg)

;; Absolutely the killer feature of Emacs
(package! xkcd
    :pin "66e928706fd660cfdab204c98a347b49c4267bdf")

;; Fix Chinese font display
;; Doesn't work with Doom, but it is actually not needed (can be replaced by config file)
;; (package! cnfonts)
