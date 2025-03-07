;;; editor/fold/config.el  -*- lexical-binding: t; -*-

(straight-use-package '(ts-fold-indicators :type git :host github :repo "emacs-tree-sitter/ts-fold"))

(use-package ts-fold
  :straight (ts-fold :type git :host github :repo "emacs-tree-sitter/ts-fold")
  :hook (tree-sitter-after-on . ts-fold-line-comment-mode)
  :hook (tree-sitter-after-on . ts-fold-indicators-mode)
  :hook (ts-fold-on-fold      . sideline-render-this)
  :init
  (setq ts-fold-indicators-fringe 'left-fringe
        ts-fold-indicators-face-function
        (lambda (pos &rest _)
          ;; Return the face of it's function.
          (line-reminder--get-face (line-number-at-pos pos t))))
  :config
  (require 'line-reminder)
  (setq line-reminder-add-line-function
        (lambda (&rest _)
          (null (ts-fold--overlays-in 'ts-fold-indicators-window (selected-window)
                                      (line-beginning-position) (line-end-position))))))
