(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)


  (setq tree-sitter-debug-jump-buttons t
        tree-sitter-debug-highlight-jump-region t
        major-mode-remap-alist
        '((yaml-mode . yaml-ts-mode)
          (bash-mode . bash-ts-mode)
          (js2-mode . js-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (json-mode . json-ts-mode)
          (css-mode . css-ts-mode)
          (python-mode . python-ts-mode)
          (c-mode . c-ts-mode)))

  (my-advice-add 'tree-sitter-debug--setup :after
    (with-current-buffer tree-sitter-debug--tree-buffer
      (highlight-indent-guides-mode 1)))


  (defun my--tree-sitter-hl-mode-hook ()
    "Hook for `tree-sitter-hl-mode'."
    (remove-hook 'tree-sitter-hl-mode-hook #'my--tree-sitter-hl-mode-hook)
    (tree-sitter-hl-mode 1))  ; re-enable it once
  (add-hook 'tree-sitter-hl-mode-hook #'my--tree-sitter-hl-mode-hook)





;; (defcustom treesit-auto-fallback-alist
;;   (mapcar
;;    (lambda (elt)
;;      (cons (purecopy (car elt)) (cdr elt)))
;;    `((toml-ts-mode . conf-toml-mode)
;;      (c-ts-mode . cc-mode)
;;      (c-or-c++-ts-mode . c-or-c++-mode)
;;      (java-ts-mode . java-mode)
;;      (js-ts-mode . (javascript-mode js-mode))
;;      (python-ts-mode . python-mode)
;;      ;; TODO: I do not know if the future treesitter mode for HTML will be called html-ts-mode or mhtml-mode
;;      (html-ts-mode . mhtml-mode)
;;      ;; See deprecation note in their README: https://github.com/emacs-typescript/typescript.el#a-short-note-on-development-halt
;;      (typescript-ts-mode . nil)
;;      (tsx-ts-mode . nil)))
;;   "Alist mapping treesitter modes to their respective fallback modes.
;; If the CDR of the association is nil, then no fallback will be
;; attempted when encountering a tree-sitter mode that is missing an
;; installation of its respecitve grammar.  If the CDR is non-nil,
;; then a fallback attempt is made to the specified mode.

;; If a treesitter mode is omitted from the keys of this alist
;; entirely, then a fallback is attempted by using the same name
;; prefix (e.g. `python-ts-mode' will attempt a fallback to
;; `python-mode').

;; In any case, if the fallback mode does not
;; exist (e.g. go-mod-mode is not installed but that would be the
;; automatic fallback for `go-mod-ts-mode'), then no fallback is
;; attempted."
;;   :type '(alist (symbol) (function))
;;   :group 'treesit)

;; (defun treesit-auto--remap-language-source (language-source)
;;   "Determine mode for LANGUAGE-SOURCE.
;; If the grammar is installed, remap the base mode to its
;; tree-sitter variant in `major-mode-remap-alist'.  Otherwise,
;; remap the tree-sitter variant back to the default mode."
;;   (let* ((name (car language-source))
;;          (name-ts-mode (intern (concat (symbol-name name) "-ts-mode")))
;;          (fallback-assoc (assq name-ts-mode treesit-auto-fallback-alist))
;;          (fallback-name (cdr fallback-assoc))
;;          (name-mode (or fallback-name
;;                         (intern (concat (symbol-name name) "-mode"))))
;;          (name-mode-bound-p (fboundp name-mode))
;;          (skip-remap-p (and fallback-assoc
;;                             (not (cdr fallback-assoc)))))
;;     (and (not skip-remap-p)
;;          (fboundp name-ts-mode)
;;          (if (treesit-ready-p name t)
;;              (add-to-list 'major-mode-remap-alist `(,name-mode . ,name-ts-mode))
;;            (when name-mode-bound-p
;;              (add-to-list 'major-mode-remap-alist `(,name-ts-mode . ,name-mode)))))))

;; (defun treesit-auto-apply-remap ()
;;   "Adjust `major-mode-remap-alist' using installed tree-sitter grammars."
;;   (mapcar 'treesit-auto--remap-language-source treesit-language-source-alist))

;; (advice-add 'treesit-install-language-grammar :after (lambda (&rest _r) (treesit-auto-apply-remap)))
;; (treesit-auto-apply-remap)

