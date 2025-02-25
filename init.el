(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)

(when (featurep 'esup-child) (setq gc-cons-threshold most-positive-fixnum))


;; (add-to-list 'exec-path "C:/Users/User/apps/w64devkit/bin")
;; (setenv "PATH" (mapconcat #'identity exec-path path-separator))
;; (setq explicit-shell-file-name "C:/Users/User/apps/w64devkit/bin/sh.exe")
;; (setq shell-file-name "sh")

(setq load-path
      (append (mapcar
               (lambda (dir) (concat user-emacs-directory dir))
               '("lisp/"
                 "lisp/lib/"))
              load-path))

;;; Initialize
(require 'my-package)
(require 'my-util)
(require 'my-theme)
(require 'my-ui)
(require 'my-window)
(require 'my-project)
(require 'my-module)
