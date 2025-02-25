;;; editor/debug/config.el  -*- lexical-binding: t; -*-

(use-package turbo-log
  :straight t
  :init
  (setq turbo-log-allow-insert-without-tree-sitter-p t))