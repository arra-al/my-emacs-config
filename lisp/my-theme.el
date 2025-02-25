;;;; my-theme.el....-*- lexical-binding: t; no-byte-compile: t -*-

(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message "Welcome Arra AL")))

(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

(defvar *my-theme-dark* 'doom-one)
(defvar *my-theme-light* 'doom-one-light)
(defvar *my-current-theme* *my-theme-dark*)

(use-package doom-themes
  :demand
  :config
  (load-theme *my-current-theme* t))
  ;; for treemacs users
;;  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
 ;; (doom-themes-treemacs-config))


;; disable other themes before loading new one
(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))


(defun my-next-theme (theme)
    (disable-theme *my-current-theme*)
    (progn
      (load-theme theme t))
  (setq *my-current-theme* theme))

(defun my-toggle-theme ()
  (interactive)
  (cond ((eq *my-current-theme* *my-theme-dark*) (my-next-theme *my-theme-light*))
        ((eq *my-current-theme* *my-theme-light*) (my-next-theme *my-theme-dark*))))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons)

(use-package nyan-mode
  :init
  (nyan-mode))

(provide 'my-theme)
