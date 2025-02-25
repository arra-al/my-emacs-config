;;; my-module.el --- module
;;; Commentary:
;;; Code:

;;
;; (@* "Module" )
;;

(defconst my-module-preload '("emacs/buffer-menu"
                               "tools/debugger" "tools/lookup")
  "A list of preload modules.")


(defconst my-module-load-alist
  '(
    ;; (keypression                           . "app/keypression")
    ((flycheck flymake)                    . ("checkers/syntax" "ui/sideline"))
    (company                               . "completion/company")
    (vertico                               . "completion/vertico")
;    (turbo-log                             . "editor/debug")
    (tree-sitter                           . ("editor/docstring" "editor/fold"))
;    (expand-region                         . "editor/expand-region")
;    (file-header                           . "editor/file-templates")
                                        ;    (isearch                               . "editor/isearch")
    (c-cpp . "lang/c-cpp")
    (cmake . "lang/cmake")
    ((iedit multiple-cursors)              . "editor/multiple-cursors")
    (move-text . "editor/move-text")
    (yasnippet                             . "editor/snippets")
    ;; (( vs-edit-mode vsc-edit-mode vs-comment-return) . "editor/vs")
    (tree-sitter                           . "tools/tree-sitter")
    (dashboard                             . "ui/dashboard")
    (treemacs                              . "ui/treemacs")
    )
  "Alist of config modules to load.")

;;
;; (@* "Module" )
;;

(defvar my-module-history nil
  "History of the loaded modules.")

(defun my-module--path (module)
  "Return the path to the MODULE config file."
  (let ((root (concat user-emacs-directory "modules/" module)))
    (concat root "/config.el")))

(defun my-module-loaded-p (module)
  "Return non-nil if MODULE has been loaded."
  (member (my-module--path module) my-module-history))

(defun my-module-reload-all ()
  "Reload all modules."
  (dolist (module my-module-history)
    (load module t t)))

(defun my-module-load (modules &optional force)
  "Load MODULES.

If FORCE is non-nil, force load the module even it has been loaded already."
  (if (listp modules)
      (dolist (module modules) (my-module-load module))
    (let ((config (my-module--path modules)))
      (when (or force
                (not (my-module-loaded-p modules)))
        (push config my-module-history)
        (load config t t)))))


(defun my-modules-load-entry ()
  "Evaluate through `my-module-load-alist' for all required modules."
  (dolist (data my-module-load-alist)
    (let ((feats (car data)) (modules (cdr data)))
                                        ; (my-with-eval-after-load feats (my-module-load modules)))))
       (my-module-load modules)
      )))

;(my-modules-load-entry)

(my-add-hook 'after-init-hook
  (my-modules-load-entry))


(provide 'my-module)
;;; my-module.el ends here
