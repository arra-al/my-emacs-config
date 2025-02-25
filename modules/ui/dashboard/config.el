;;; ui/dashboard/config.el  -*- lexical-binding: t; -*-

;; (require 'nerd-icons)

;; (use-package dashboard
;;   :straight t
;;   :bind ( :map dashboard-mode-map
;;           ("<up>"    . previous-line)
;;           ("<down>"  . next-line)
;;           ("C-k C-p" . package-list-packages)
;;           ("M-K"     . my-dashboard-refresh-buffer))
;;   :hook (dashboard-after-initialize
;;          . (lambda ()
;;              (unless noninteractive
;;                ;; Split windows depends on the display size!
;;                (if (elenv-monitor-vertical-p)
;;                    (ignore-errors (split-window-vertically))
;;                  (ignore-errors (split-window-horizontally)))
;;                ;; Switch to scratch buffer for other window
;;                (save-selected-window
;;                  (switch-to-buffer-other-window (get-scratch-buffer-create)))
;;                ;; Make sure dashboard buffer left most!
;;                (centaur-tabs-move-current-tab-to-left)
;;                ;; Make messages buffer to the right most.
;;                (with-current-buffer (messages-buffer)
;;                  (centaur-tabs-move-current-tab-to-right)
;;                  (centaur-tabs-move-current-tab-to-right)))))  :init
;;   (setq dashboard-banner-logo-title
;;         (concat "[MY " (if (display-graphic-p) "•" "-") " E M A C S]")
;;         dashboard-startupify-list '(dashboard-insert-banner
;;                                     dashboard-insert-newline
;;                                     dashboard-insert-banner-title
;;                                     dashboard-insert-newline
;;                                     dashboard-insert-navigator
;;                                     dashboard-insert-newline
;;                                     dashboard-insert-init-info
;;                                     dashboard-insert-items
;;                                     dashboard-insert-newline
;;                                     dashboard-insert-footer)
;;         dashboard-items '((ls-directories . 5)
;;                           (ls-files       . 5)
;;                           (recents        . 5)
;;                           (projects       . 5)
;;                           ;;(bookmarks      . 5)
;;                           ;;(agenda         . 5)
;;                           ;;(registers      . 5)
;;                           )
;;         dashboard-item-shortcuts '((recents        . "r")
;;                                    (bookmarks      . "m")
;;                                    (projects       . "p")
;;                                    (agenda         . "a")
;;                                    (registers      . "e")
;;                                    (ls-directories . "d")
;;                                    (ls-files       . "f"))
;;         dashboard-center-content t
;;         dashboard-vertically-center-content t
;;         dashboard-projects-backend 'project-el
;;         ;; Icons
;;         dashboard-set-heading-icons t
;;         dashboard-set-file-icons nil
;;         dashboard-icon-type 'nerd-icons
;;         dashboard-heading-icons '((recents        . "nf-oct-history")
;;                                   (bookmarks      . "nf-oct-bookmark")
;;                                   (agenda         . "nf-oct-calendar")
;;                                   (projects       . "nf-oct-rocket")
;;                                   (registers      . "nf-oct-database")
;;                                   (ls-files       . "nf-oct-file")
;;                                   (ls-directories . "nf-oct-file_directory"))
;;         dashboard-heading-icon-height 1.0
;;         dashboard-heading-icon-v-adjust 0.0
;;         ;; Navigator
;;         dashboard-navigator-buttons
;;         `(((,(when (display-graphic-p)
;;                (nerd-icons-faicon "nf-fa-github"))
;;             "Homepage" "Browse homepage"
;;             (lambda (&rest _) (browse-url my-homepage)))
;;            (,(when (display-graphic-p)
;;                (nerd-icons-faicon "nf-fae-tools"))
;;             "Settings" "Open custom file"
;;             (lambda (&rest _) (find-file custom-file)))
;;            (,(when (display-graphic-p)
;;                (nerd-icons-mdicon "nf-md-update"))
;;             "Update" "Update my-Emacs"
;;             (lambda (&rest _) (my-update-config)))
;;            (,(if (display-graphic-p)
;;                  (nerd-icons-faicon "nf-fa-question")
;;                "?")
;;             "" "Help (?/h)"
;;             (lambda (&rest _) (help))
;;             font-lock-string-face)))
;;         ;; Truncate style
;;         dashboard-path-style 'truncate-middle
;;         dashboard-recentf-show-base 'align
;;         dashboard-projects-show-base 'align
;;         dashboard-bookmarks-show-base 'align
;;         dashboard-bookmarks-item-format "%s  %s"
;;         dashboard-shorten-by-window-width t
;;         dashboard-shorten-path-offset 15
;;         ;; Footer
;;         dashboard-footer-icon (if (display-graphic-p)
;;                                   (nerd-icons-octicon "nf-oct-heart" :face 'error)
;;                                 "")
;;         dashboard-footer-messages
;;         `(,(concat "I showed you my source code, pls respond"
;;                    "\n\n"
;;                    (when (display-graphic-p) " ")
;;                    "       "
;;                    (format "Powered by %s, %s"
;;                            "Jen-Chieh"
;;                            (format-time-string "%Y"))))
;;         dashboard-navigation-cycle t
;;         dashboard-remove-missing-entry t
;;         dashboard-buffer-name "*my-dashboard*")
;;   :config
;;   (my-add-hook 'my-after-load-theme-hook
;;     (setq dashboard-startup-banner (my-dashboard--get-banner-path))
;;     (my-dashboard-refresh-buffer))

;;   (dashboard-setup-startup-hook))

;; ;;
;; ;; (@* "Entry" )
;; ;;

;; (defun my-dashboard ()
;;   "Jump to dashboard buffer; if doesn't exists create one."
;;   (interactive)
;;   (switch-to-buffer dashboard-buffer-name)
;;   (unless (eq major-mode 'dashboard-mode) (dashboard-mode))
;;   (my-dashboard-refresh-buffer))

;; (defun my-dashboard-other-window ()
;;   "Switch to dashboard buffer on other window."
;;   (interactive)
;;   (my-with-other-window (my-dashboard)))

;; (defun my-dashboard-refresh-buffer ()
;;   "Refresh dashboard buffer."
;;   (interactive)
;;   (my-when-buffer-window dashboard-buffer-name
;;     (my-with-dashboard-last-path
;;       (msgu-silent
;;         (elenv-save-window-excursion (dashboard-refresh-buffer))))))

;; (my-advice-add 'dashboard-remove-item-under :around
;;   (my-with-dashboard-last-path (apply arg0 args)))

;; (defun my-dashboard--get-banner-path ()
;;   "Return banner path."
;;   (concat
;;    user-emacs-directory "banners/"
;;    (cond ((display-graphic-p) (if (my-light-theme-p) "sink/black.png" "sink/white.png"))
;;          (t "sink.txt"))))

;; ;;
;; ;; (@* "Util" )
;; ;;

;; (defmacro my-with-dashboard-last-path (&rest body)
;;   "Execute BODY with preserving dashboard current path."
;;   (declare (indent 0) (debug t))
;;   `(let ((dashboard-ls-path (if-let* ((buffers (nth 0 (my-valid-buffer-list))))
;;                                 (file-name-directory (buffer-file-name buffers))
;;                               default-directory)))
;;      ,@body))

;; ;;
;; ;; (@* "Refresh" )
;; ;;

;; (my-advice-add 'dashboard-insert-startupify-lists :before
;;   ;; Execution before dashboard setup.
;;   (my-dashboard-init-info))

;; (my-advice-add 'dashboard-insert-startupify-lists :after
;;   ;; Execution after dashboard setup.
;;   (with-current-buffer dashboard-buffer-name
;;     (setq-local revert-buffer-function 'my-dashboard-revert)))

;; (defun my-dashboard-init-info ()
;;   "Initialize startup information for variable `dashboard-init-info'."
;;   (setq dashboard-init-info
;;         (format "%s packages loaded in %0.1f seconds"
;;                 (length package-activated-list)
;;                 (string-to-number (emacs-init-time)))))

;; (defun my-dashboard-revert (&rest _)
;;   "Revert for dashboard buffer."
;;   (unless (active-minibuffer-window) (my-dashboard-refresh-buffer)))

;; ;;
;; ;; (@* "Truncate" )
;; ;;

;; (defun my-dashboard-current-list (name)
;;   "Return the list of current dashboard by NAME."
;;   (cl-case name
;;     (`recents recentf-list)
;;     (`bookmarks (bookmark-all-names))
;;     (`projects (dashboard-projects-backend-load-projects))
;;     (`ls-directories (mapcar #'f-slash (f-directories dashboard-ls--record-path)))
;;     (`ls-files (f-files dashboard-ls--record-path))
;;     (t (user-error "Unknown section for search: %s" name))))

;; (defun my-dashboard-current-item-in-path ()
;;   "Return the path from current dashboard section in path."
;;   (let ((section (dashboard--current-section)) path)
;;     (cl-case section
;;       (`bookmarks (setq path (bookmark-get-filename path)))
;;       (t
;;        (let ((lst (my-dashboard-current-list section))
;;              (index (my-dashboard-current-index section)))
;;          (setq path (nth index lst)))))
;;     path))

;; (defun my-dashboard--goto-section (name)
;;   "Move to section NAME declares in variable `dashboard-item-shortcuts'."
;;   (my-fboundp-apply (intern (format "dashboard-jump-to-%s" name))))

;; (defun my-dashboard-current-index (name &optional pos)
;;   "Return the idex by NAME from POS."
;;   (let (target-ln section-line)
;;     (save-excursion
;;       (when pos (goto-char pos))
;;       (setq target-ln (line-number-at-pos))
;;       (my-dashboard--goto-section name)
;;       (setq section-line (line-number-at-pos)))
;;     (my-re-enable-mode 'global-hl-line-mode)
;;     (- target-ln section-line)))

;; (defun my-dashboard--on-path-item-p ()
;;   "Return non-nil if current point is on the item path from dashboard."
;;   (save-excursion
;;     (when (eolp) (ignore-errors (forward-char -1)))
;;     (my-current-point-face 'dashboard-items-face)))

;; (my-advice-add 'ffap-guesser :around
;;   ;; This advice is used when function `counsel--preselect-file' trying to
;;   ;; get the truncate path from dashboard buffer (ffap)
;;   (cl-case major-mode
;;     (`dashboard-mode
;;      (or (and (my-dashboard--on-path-item-p)
;;               (my-dashboard-current-item-in-path))
;;          (apply arg0 args)))  ; fallback
;;     (t (apply arg0 args))))

;; ;;
;; ;; (@* "Registry" )
;; ;;

;; (defvar my-dashboard--last-window-width -1
;;   "Record the last window width from dashbord buffer.")

;; (defun my-dashboard--window-width ()
;;   "Return dashboard buffer's window width."
;;   (my-when-buffer-window dashboard-buffer-name (window-width)))

;; (my-add-hook 'window-size-change-functions
;;   (when-let* ((new-ww (my-dashboard--window-width)))
;;     (unless (= new-ww my-dashboard--last-window-width)
;;       (setq my-dashboard--last-window-width new-ww)
;;       (my-dashboard-refresh-buffer))))

(use-package dashboard
  :straight t
  :ensure t
  :init
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard"
        dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5))
        dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (agenda    . "a")
                                 (registers . "e"))
        dashboard-display-icons-p t
        dashboard-icon-type 'nerd-icons
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-modify-heading-icons '((recents   . "nf-oct-file_text")
                                  (bookmarks . "nf-oct-book"))
        dashboard-navigator-buttons
        `(((,(when (display-graphic-p)
               (nerd-icons-faicon "nf-fa-github"))
            "Homepage" "Browse homepage"
            (lambda (&rest _) (browse-url my-homepage)))
           (,(when (display-graphic-p)
               (nerd-icons-faicon "nf-fae-tools"))
            "Settings" "Open custom file"
            (lambda (&rest _) (find-file custom-file)))
           (,(when (display-graphic-p)
               (nerd-icons-mdicon "nf-md-update"))
            "Update" "Update my-Emacs"
            (lambda (&rest _) (my-update-config)))
           (,(if (display-graphic-p)
                 (nerd-icons-faicon "nf-fa-question")
               "?")
            "" "Help (?/h)"
            (lambda (&rest _) (help))
            font-lock-string-face)))
        dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer)
        )
  (dashboard-setup-startup-hook))
