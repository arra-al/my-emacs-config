(use-package python-black
  :straight t
  :ensure t
  :bind (("C-c b" . python-black-buffer)))

(use-package pyvenv
  :straight t
  :ensure t
  :config
  (pyvenv-mode 1))

(use-package anaconda-mode
  :straight t
  :ensure t
  :bind (("C-c C-x" . next-error))
  :config
  (require 'pyvenv)
  (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-anaconda
  :straight t
  :ensure t
  :config
  (eval-after-load "company"
   '(add-to-list 'company-backends '(company-anaconda :with company-capf))))

(use-package highlight-indent-guides
  :straight t
  :ensure t
  :config
  (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))
