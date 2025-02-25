;;; lang/js/config.el
;;
;; (@* "Templates" )
;;

;;
;; (@* "Hook" )
;;

(my-add-hook 'js-mode-hook
  (auto-rename-tag-mode 1)
  (impatient-mode t))


;;
;; (@* "Extensions" )
;;

(use-package flycheck-deno :hook (flycheck-mode . flycheck-deno-setup))
 
