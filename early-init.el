;;; early-init.el --- Early initialization  -*- lexical-binding: t -*-;
;;; Commentary:;
; Code:

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; prevent package.el loading packages prior to their init-file loading.
(setq package-enable-at-startup nil)

;; Faster to disable these here (before they've been initialized)
(setq default-frame-alist
      (append
       '((menu-bar-lines . 0)
         (tool-bar-lines . 0)
         (vertical-scroll-bars))
       (when (featurep 'ns)
         '((ns-transparent-titlebar . t)))
       default-frame-alist))


;;; Bootstrap

;; Contrary to what many Emacs users have in their configs, you don't need
;; more than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")

;; set-language-enviornment sets default-input-method, which is unwanted
(setq default-input-method nil)

;;
;;; Set Custom file
(setq-default custom-file (concat user-emacs-directory "site-lisp/custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(provide 'early-init)
;;; early-init.el ends here
