;;; my-window.el --- Window related  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;
;; (@* "Window" )
;;

(defun my-get-largest-window (&optional all-frames dedicated not-selected no-other)
  "Like function `get-largest-window' but esure return a valid window."
  (or (get-largest-window all-frames dedicated not-selected no-other)
      (progn
        (split-window-sensibly)
        (get-largest-window all-frames dedicated not-selected no-other))))

;;
;; (@* "Frame" )
;;

(defun my-make-frame ()
  "Select new frame after make frame."
  (interactive)
  (let ((new-frame (call-interactively #'make-frame)))
    (select-frame-set-input-focus new-frame)
    (my-theme-refresh)
    (split-window-horizontally)))

;;
;; (@* "Navigation" )
;;

(cl-defun my-jump-to-buffer-windows (buffer &key success error type)
  "Safely jump to BUFFER's window and execute SUCCESS operations.

If BUFFER isn't showing; then execute ERROR operations instead.

For argument TYPE; see function `my-string-compare-p' description."
  (if-let* ((windows (my-window-list buffer type)))
      (dolist (win windows)
        (with-selected-window win
          (when success (funcall success))))
    (when error (funcall error))))

(defun my-switch-to-buffer-other-window (buffer-or-name &optional norecord)
  "Same with function `switch-to-buffer-other-window' but also consider
larger window height in the calculation.

See function `switch-to-buffer-other-window' description for arguments
BUFFER-OR-NAME and NORECORD."
  (select-window (my-get-largest-window nil nil t))
  (pop-to-buffer-same-window buffer-or-name norecord))

(defun my-switch-to-next-valid-buffer ()
  "Switch to the previous buffer that are not nil."
  (interactive)
  (when-let* ((lst (my-valid-buffer-list))
              (target-index 1)
              (target-buffer (or (nth target-index lst) (nth 0 lst))))
    (switch-to-buffer target-buffer)))

(defun my-switch-to-prev-valid-buffer ()
  "Switch to the previous buffer that are not nil."
  (interactive)
  (when-let* ((lst (my-valid-buffer-list))
              (target-index (1- (length lst)))
              (target-buffer (or (nth target-index lst) (nth 0 lst))))
    (switch-to-buffer target-buffer)))

(defun my-window-list (query &optional type ignore-case)
  "Return window list by it's QUERY.

For argument TYPE and IGNORE-CASE; see function `my-string-compare-p' description."
  (cl-remove-if-not
   (lambda (win)
     (my-string-compare-p query (buffer-name (window-buffer win)) type ignore-case))
   (window-list)))

(defun my-buffer-visible-list ()
  "List of buffer that current visible in frame."
  (mapcar (lambda (win) (buffer-name (window-buffer win))) (window-list)))

(defun my-buffer-shown-count (buf-name &optional type)
  "Return the count of the IN-BUF-NAME shown.

For argument TYPE; see function `my-string-compare-p' description."
  (length (my-window-list buf-name type)))

(defun my-buffer-list-shown-p (buf-lst &optional type)
  "Return non-nil if BUF-LST shown in the program.

For argument TYPE; see function `my-string-compare-p' description."
  (cl-some (lambda (buf) (my-buffer-shown-p buf type)) buf-lst))

(defun my-buffer-shown-p (buf-name &optional type)
  "Return non-nil if IN-BUF-NAME shown in the program.

For argument TYPE; see function `my-string-compare-p' description."
  (>= (my-buffer-shown-count buf-name type) 1))

(defun my-buffer-shown-in-multiple-window-p (buf-name &optional type)
  "Check if IN-BUF-NAME shown in multiple windows.

For argument TYPE; see function `my-string-compare-p' description."
  (>= (my-buffer-shown-count buf-name type) 2))

;;
;; (@* "Deleting" )
;;

(defun my-delete-window ()
  "Better UX of function `delete-window'."
  (interactive)
  (let ((next (or (window-in-direction 'above)
                  (window-in-direction 'below)
                  (window-in-direction 'right)
                  (window-in-direction 'left)
                  (window-prev-sibling (selected-window)))))
    (delete-window)
    (when next (select-window next))))

(defun my-delete-window-downwind ()
  "Delete window in downwind order."
  (interactive)
  (other-window -1) (save-selected-window (other-window 1) (delete-window)))

;;
;; (@* "Util" )
;;

(defun my-move-to-upmost-window ()
  "Move to the upmost window."
  (interactive)
  (while (ignore-errors (select-window (window-in-direction 'above)))))

(require 'winum)
(set-face-attribute 'winum-face nil :weight 'bold)
(setq winum-format                      " %s "
      winum-mode-line-position          1
      winum-ignored-buffers             '(" *which-key*")
      winum-ignored-buffers-regexp      '(" \\*Treemacs-.*"))
(winum-mode)


(require 'golden-ratio)

(defadvice winum-select-window-by-number
    (after golden-ratio-resize-window)
  (golden-ratio) nil)

(golden-ratio-mode 1)

(if golden-ratio-mode (progn (ad-activate 'winum-select-window-by-number)))

;;
;;; window move (shift + arrow [up, right, bottom, left]

(global-set-key [s-left] (my-ignore-error-wrapper 'windmove-left))
(global-set-key [s-right] (my-ignore-error-wrapper 'windmove-right))
(global-set-key [s-up] (my-ignore-error-wrapper 'windmove-up))
(global-set-key [s-down] (my-ignore-error-wrapper 'windmove-down))


(provide 'my-window)
;;; my-window.el ends here
