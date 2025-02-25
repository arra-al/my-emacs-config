;;; editor/multiple-cursors/config.el  -*- lexical-binding: t; -*-

(use-package iedit
  :straight t
  :init
  (setq iedit-toggle-key-default nil
        iedit-auto-save-occurrence-in-kill-ring nil))

(use-package multiple-cursors
  :straight t
  :bind (("C-M-j" . 'mc/mark-all-dwim)
   ("C-M-c" . 'mc/edit-lines)
   ("C->" . 'mc/mark-next-like-this)
   ("C-<" . 'mc/mark-previous-like-this)
   ("C-c C-<" . 'mc/mark-all-like-this)))

;; (use-package vsc-multiple-cursors
;;   :straight t
;;   :hook (multiple-cursors-mode . vsc-multiple-cursors-mode)
;;   :bind ( :map mc/keymap
;;           ("<escape>" . mc/keyboard-quit)
;;           ("<return>")
;;           ("C-v"      . vsc-edit-yank)
;;           ("C-:")
;;           ("C-'"))
;;   :init
;;   (setq vsc-multiple-cursors-cancel-commands
;;         '( block-travel-down block-travel-up
;;            ;; isearch-forward-symbol-at-point
;;            ;; jcs-isearch-backward-thing-at-point
;;            ;; isearch-forward-thing-at-point
;;            ;; jcs-isearch-repeat-backward jcs-isearch-repeat-forward
;;            ;; isearch-project-forward-symbol-at-point
;;            ;; jcs-isearch-project-backward-thing-at-point
;;            ;; isearch-project-forward-thing-at-point
;;            ;; jcs-isearch-project-repeat-backward
;;            ;; jcs-isearch-project-repeat-forward)
;;         )))
