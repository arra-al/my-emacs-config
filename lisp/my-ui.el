;;; my-ui.el
;;; Commentary:
;;; Code:

;;
;;; General UX

(setq ring-bell-function #'ignore
      visible-bell nil)

(use-package buffer-wrap
  :straight t
  :hook (( backtrace-mode Buffer-menu-mode package-menu-mode)
         . buffer-wrap-mode)
  :config
  (defun my--buffer-wrap--fixed-window-off ()
    "Fixed windows is off after wrapping."
    (let ((max-ln (+ (line-number-at-pos (point-max)) buffer-wrap--relative-max-line)))
      (when (= max-ln (line-number-at-pos (point)))
        (my-recenter-top-bottom 'bottom))))

  (defun my--buffer-wrap--fixed-fake-header ()
    "Fixed line offset consider fake header calculation."
    (when tabulated-list-format
      (unless (ignore-errors (tabulated-list-get-entry))
        (cond ((= 0 buffer-wrap--delta-lines)
               (goto-char (point-min)))
              ((< 0 buffer-wrap--delta-lines)
               (ignore-errors (forward-line 1)))
              (t
               (elenv-goto-line (1- (line-number-at-pos (point-max))))))
        (unless (ignore-errors (tabulated-list-get-entry))
          (ignore-errors (forward-line 1))))))

  (my-add-hook 'buffer-wrap-post-command-hook
    (my--buffer-wrap--fixed-fake-header)
    (my--buffer-wrap--fixed-window-off)))

;;
;;; Highlight

(use-package auto-highlight-symbol
  :straight t
  :bind ( :map auto-highlight-symbol-mode-map
          ("M-S-<right>")
          ("M-S-<left>")
          ("M--")
          ("M-<left>")
          ("M-<right>"))
  :init
  (setq ahs-idle-interval 0.15))

(use-package region-occurrences-highlighter
  :straight t
  :init
  (setq region-occurrences-highlighter-min-size 1
        region-occurrences-highlighter-all-visible-buffers nil))

(use-package highlight-numbers
  :straight t
  :config
  (setq highlight-numbers-generic-regexp "\\_<[[:digit:]]+\\(?:\\.[0-9]*\\)?\\_>"))


;;
;;; Line Numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package line-reminder
  :straight t
  :hook (display-line-numbers-mode
         . (lambda ()
             (when (display-graphic-p)
               (line-reminder-mode (if display-line-numbers-mode 1 -1)))))
  :init
  (setq line-reminder-show-option 'indicators
        line-reminder-thumbnail t)
  (unless (display-graphic-p)
    (setq line-reminder-saved-sign "|"
          line-reminder-modified-sign "|"
          line-reminder-thumb-modified-sign "|"
          line-reminder-thumb-saved-sign "|")))

;;
;;; Columns

(setq-default fill-column 80)
(column-number-mode 1)

;;
;;; Scrolling

(setq mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)

(setq scroll-step 1
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
      auto-window-vscroll nil)

(setq hscroll-margin 2
      hscroll-step 1)


(use-package better-scroll
  :straight t
  :init
  (setq better-scroll-align-type 'relative
        better-scroll-allow-boundary-movement t))

;;
;;; Parenthesis

(use-package paren
  :straight t
  :init
  (setq show-paren-delay 0.1
        show-paren-highlight-openparen t
        show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;;
;;; Whitespace

(use-package whitespace
  :straight t
  :init
  (setq whitespace-line-column nil
        whitespace-style
        '( face indentation tabs tab-mark spaces space-mark newline newline-mark
           trailing lines-tail)
        whitespace-display-mappings
        '((tab-mark ?\t [?› ?\t])
          (newline-mark ?\n [?¬ ?\n])
          (space-mark ?\  [?·] [?.]))))

(use-package whitespace-cleanup-mode
  :straight t
  :init
  (setq whitespace-cleanup-mode-preserve-point t
        whitespace-cleanup-mode-only-if-initially-clean nil
        whitespace-cleanup-mode-ignore-modes
        '( special-mode comint-mode cider-repl-mode haskell-interactive-mode
           text-mode markdown-mode org-mode
           conf-javaprop-mode ini-mode
           view-mode diff-mode
           snippet-mode)))

;;
;;; Image

(setq image-animate-loop t)

;;
;;; Golden ration
(use-package golden-ratio
  :straight t
  :init
  (setq golden-ratio-auto-scale t))

;;
;;; Window

(push '(fullscreen . maximized) default-frame-alist)  ; full screen

(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)

(setq windmove-wrap-around t)


(use-package winum
  :straight t
  :init
  (setq winum-scope 'frame-local))

;;
;;; Dialog

(setq use-file-dialog nil
      use-dialog-box nil)

;;
;;; ^L

(use-package page-break-lines
  :straight t
  :init
  (setq page-break-lines-modes '( browse-kill-ring-mode
                                  emacs-lisp-mode lisp-mode
                                  scheme-mode
                                  outline-mode

                                  help-mode)))


(provide `my-ui)
;;; my-ui.el ends here
