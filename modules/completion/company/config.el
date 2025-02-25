;;; completion/company/config.el  -*- lexical-binding: t; -*-

(use-package company
  :straight t
  :bind ( :map company-active-map
          ([tab] . vsc-edit-tab)
          ("TAB" . vsc-edit-tab)
          ("C-s" . my-save-buffer))
  :init
  (setq company-frontends '(company-pseudo-tooltip-frontend)
        company-require-match nil
        company-tooltip-align-annotations t
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-eclim-auto-save nil
        company-minimum-prefix-length 0
        company-idle-delay 0.07
        company-selection-wrap-around 'on
        company-format-margin-function #'company-detect-icons-margin)
  (setq company-backends
        '( company-capf company-semantic
           company-keywords
           company-abbrev company-dabbrev company-dabbrev-code
           company-etags company-gtags
           company-yasnippet))
  :config
  (unless (display-graphic-p)
    (push 'company-echo-metadata-frontend company-frontends))

  ;; XXX: The variable `company-continue-commands' is in the not clause;
  ;; therefore, these are commands that are not continuable.
  (nconc company-continue-commands
         '( kill-region
            whole-line-or-region-kill-region)))

(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode)
  :init
  (setq company-box-backends-colors nil
        company-box-frame-behavior 'point
        company-box-scrollbar 'right
        company-box-doc-delay 0.3
        company-box-doc-text-scale-level -2))

;; (setq tab-always-indent 'complete)
;; (add-to-list 'completion-styles 'initials t)

;; (use-package company-fuzzy
;;   :straight t
;;   :hook (company-mode . company-fuzzy-mode)
;;   :init
;;   (setq company-fuzzy-sorting-backend 'flx
;;         company-fuzzy-prefix-on-top nil
;;         company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@" "::" ":")
;;         company-fuzzy-reset-selection t))

;; (use-package company-files
;;   :straight t
;;   :init
;;   (setq company-files-chop-trailing-slash nil))

;; (use-package company-paths
;;   :straight t
;;   :init
;;   (setq company-paths-continue-completing t))

(use-package company-emojify
  :straight t
  :init
  (setq company-emojify-annotation (if (display-graphic-p) 'image 'unicode)
        company-emojify-emoji-styles '(github)))

(add-hook 'after-init-hook 'global-company-box-mode)

(my-advice-add 'company-complete-selection :around
  (let ((company-dabbrev-downcase t)) (apply arg0 args)))
