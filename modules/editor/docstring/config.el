;;; editor/docstring/config.el  -*- lexical-binding: t; -*-

(use-package highlight-doxygen
  :straight t
  :hook (ts-docstr-mode . highlight-doxygen-mode))

;; (use-package ts-docstr
;;   :straight (ts-docstr :type git :host github :repo "emacs-vs/ts-docstr"
;;                        :files (:defaults "langs/*.el"))
;;   :hook (tree-sitter-after-on . ts-docstr-mode)
;;   :init
;;   (setq ts-docstr-key-support nil
;;         ts-docstr-desc-summary ""))
