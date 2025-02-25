;;; my-util.el --- All utilities put here  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;
;; (@* "Advice" )
;;

(defun my-advice-ignore-errors (fnc)
  "Ignore errors for FNC."
  (my-advice-add fnc :around (ignore-errors (apply arg0 args))))

;;
;; (@* "Macro" )
;;

(defmacro my-advice-add (symbols where &rest body)
  "Global advice-add utility."
  (declare (indent 2))
  `(cond ((listp ,symbols)
          (dolist (symbol ,symbols)
            (advice-add symbol ,where (lambda (&optional arg0 &rest args) ,@body))))
         (t (advice-add ,symbols ,where (lambda (&optional arg0 &rest args) ,@body)))))

(defmacro my-add-hook (hooks &rest body)
  "Global add-hook utility."
  (declare (indent 1))
  `(cond ((listp ,hooks)
          (dolist (hook ,hooks)
            (add-hook hook (lambda (&optional arg0 arg1 arg2 &rest args) ,@body))))
         (t (add-hook ,hooks (lambda (&optional arg0 arg1 arg2 &rest args) ,@body)))))

(defmacro my-when-buffer-window (buffer-or-name &rest body)
  "Execute BODY in window BUFFER-OR-NAME."
  (declare (indent 1) (debug t))
  `(when-let* ((win (ignore-errors (get-buffer-window-list ,buffer-or-name))))
     (with-selected-window (nth 0 win) ,@body)))

(defmacro my-if-buffer-window (buffer-or-name then &rest else)
  "Execute THEN in window BUFFER-OR-NAME; otherwise ELSE will be executed."
  (declare (indent 2) (debug t))
  `(if-let* ((win (ignore-errors (get-buffer-window-list ,buffer-or-name))))
       (with-selected-window (nth 0 win) ,then)
     ,@else))

(defmacro my-with-other-window (&rest body)
  "Temporary replace all switch file functions with other window during BODY
execution."
  (declare (indent 0) (debug t))
  `(noflet ((switch-to-buffer (&rest args) (apply #'my-switch-to-buffer-other-window args))
            (find-file (&rest args) (apply #'find-file-other-window args)))
     ,@body))



(defmacro my-require (feature &optional filename noerror)
  "Require FEATURE; it can be a list."
  (declare (indent -1))
  `(cond ((listp ,feature) (dolist (module ,feature) (require module ,filename ,noerror)))
         ((symbolp ,feature) (require ,feature ,filename ,noerror))
         (t (user-error "Unknown type to require %s" (type-of ,feature)))))

(defmacro my-with-eval-after-load (files &rest body)
  "Execute BODY after one of the FILES is loaded."
  (declare (indent 1) (debug t))
  `(cond
    ((listp ,files) (dolist (file ,files) (with-eval-after-load file ,@body)))
    (t (with-eval-after-load ,files ,@body))))

;;
;; (@* "Pass" )
;;

(defun my-auth-source-get (host)
  "Basic value getter by HOST."
  (when-let* ((info (auth-source-search :max 1 :host host))
              (info (car info)))
    (or (plist-get info :value)
        (plist-get info :key)
        (plist-get info :secret)
        (plist-get info :password))))

(defun my-ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))

(provide 'my-util)
;;; my-util.el ends here
