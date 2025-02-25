(use-package sideline
  :straight (sideline :type git :host github :repo "emacs-sideline/sideline")
  :hook ((flycheck-mode   . sideline-mode)
         (flymake-mode    . sideline-mode)
         ;; Modes
         (emacs-lisp-mode . (lambda ()
                              (when (featurep 'eros) (sideline-mode 1))))
         (lisp-mode       . (lambda ()
                              (when (featurep 'sly) (sideline-mode 1))))
         (scheme-mode     . (lambda ()
                              (when (featurep 'geiser) (sideline-mode 1)))))
  :init
  (setq sideline-delay 0.2
        sideline-backends-left `((sideline-color     . up))
        sideline-backends-right `((sideline-lsp      . up)
                                  (sideline-eglot    . up)
                                  (sideline-flycheck . down)
                                  (sideline-flymake  . down)
                                  (sideline-eros     . down)
                                  (sideline-cider    . down)
                                  (sideline-sly      . down)
                                  ;;(sideline-geiser   . down)
                                  ;; (sideline-racket   . down)
                                  ;;(chatgpt-sideline  . up)
                                  )
        sideline-display-backend-name t
        sideline-display-backend-type 'inner
        sideline-truncate t))

(use-package sideline-flycheck
  :straight (sideline-flycheck :type git :host github :repo "emacs-sideline/sideline-flycheck")
  :hook (flycheck-mode . sideline-flycheck-setup)
  :init
  (setq sideline-flycheck-display-mode 'line))

(use-package sideline-flymake
  :straight (sideline-flymake :type git :host github :repo "emacs-sideline/sideline-flymake")
  :init
  (setq sideline-flymake-display-mode 'line))

(use-package sideline-lsp
  :straight (sideline-lsp :type git :host github :repo "emacs-sideline/sideline-lsp")
  :init
  (setq sideline-lsp-code-actions-prefix ""))

(use-package sideline-eglot
  :straight (sideline-eglot :type git :host github :repo "emacs-sideline/sideline-eglot")
  :init
  (setq sideline-eglot-code-actions-prefix ""))

(use-package sideline-blame
  :straight (sideline-blame :type git :host github :repo "emacs-sideline/sideline-blame")
  :init
  (setq sideline-blame-commit-format "• %s"))

(use-package sideline-color
  :straight (sideline-color :type git :host github :repo "emacs-sideline/sideline-color")
  :hook (after-init . sideline-mode))

(use-package sideline-eros
  :straight (sideline-eros :type git :host github :repo "emacs-sideline/sideline-eros")
  :hook (sideline-mode . sideline-eros-setup))

(use-package sideline-cider
  :straight (sideline-cider :type git :host github :repo "emacs-sideline/sideline-cider")
  :hook (sideline-mode . sideline-cider-setup))

(use-package sideline-sly
  :straight (sideline-sly :type git :host github :repo "emacs-sideline/sideline-sly")
  :hook (sideline-mode . sideline-sly-setup))

;; (use-package chatgpt-sideline
;;   :straight (chatgpt-sideline :type git :host github :repo "emacs-openai/chatgpt-sideline"))
