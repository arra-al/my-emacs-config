;;; lang/typescript/config.el  -*- lexical-binding: t; -*-

(my-module-load "lang/js")

;;
;; (@* "Document String" )
;;

(defun my-typescript--ts-docstr-after (node data)
  "Local hook `ts-docstr-after-insert-hook' for TypeScript."
  (insert "@desc "))


;;
;; (@* "Hook" )
;;

(my-add-hook 'typescript-mode-hook
  (add-hook 'ts-docstr-after-insert-hook 'my-typescript--ts-docstr-after nil t)

  ;; File Header
  (my-insert-header-if-valid '("[.]ts")
                              'my-typescript-ask-source
                              :interactive t))
