;;; emacs/buffer-menu/config.el  -*- lexical-binding: t; -*-

(use-package diminish-buffer
  :straight t
  :init
  (setq diminish-buffer-list
        '("[*]my"  ; config wise
          "[*]Echo Area" "[*]Minibuf-"
          "[*]helm" "[*]esup" "[*]quelpa-"
          "[*]easky" "[*]quickrun"
          "[*]Apropos[*]" "[*]Backtrace[*]" "[*]Compile-Log[*]"
          "[*]Ibuffer[*]"
          "[*]Bug Help[*]"
          "[*]Warnings[*]"
          "[*]vc" "[*]VC-history[*]"
          "[*]CPU-Profiler-Report" "[*]Memory-Profiler-Report"
          "[*]Process List[*]"
          "[*]Checkdoc " "[*]Elint[*]" "[*]Package-Lint[*]" "[*]relint[*]"
          "[*]Finder[*]"
          "[*]Async Shell Command[*]" "[*]shell" "[*]eshell" "bshell<"
          "[*]envrc"
          "[*]eww" "[*]ESS[*]"
          "[*]Ping"
          "[*]emacs[*]"  ; From `async'
          "[*]sly"
          "[*]cider-" "[*]nrepl-server"
          "[*]timer"
          ;; `LSP'
          "[*]lsp-" "[*]LSP[ ]+" "[*]eglot"
          "[*][[:ascii:]]*ls[*:]" "[*][[:ascii:]]+::stderr[*]"
          "[*]clang-" "[*]clangd"
          "[*]csharp[*]"
          "[*]cogru"
          "[*]cucumber"
          "[*]dart"
          "[*]perlnavigator"
          "[*]lua-"
          "[*]iph[*]"
          "[*]rust-analyzer[*:]"
          "[*]zig-"
          "[*]Coursier log[*]"
          "[*]tcp-server-"
          "[*]Python" "[*]pyright[*]"
          "[*]tree-sitter" "tree-sitter-tree:"
          "[*]company"
          "[*]eldoc"
          "[*]editorconfig"
          "[*]prettier"
          "[*]Local Variables[*]"
          "[*]Kill Ring[*]"  ; From `browse-kill-ring'
          "[*]SPEEDBAR"
          "[*]Flycheck" "[*]Flymake"
          "[*]httpd[*]" "[*]HTTP Response[*]"
          "[*]helpful" "[*]suggest[*]"
          "[*]ert[*]" "[*]indent-lint"
          "[*]elfeed-"
          "magit[-]*[[:ascii:]]*[:]"  ; From `magit'
          "[*]openai" "[*]codegpt" "[*]ChatGPT" "[*]copilot" "[*]google-gemini"
          "[*]Most used words[*]"
          "[*]manage-minor-mode"
          "[*]Free keys[*]"
          "[*]Test SHA[*]"
          "[*]RE-Builder"
          "[*]xref" "[*]define-it: tooltip[*]" "[*]preview-it" "[*]gh-md"
          "[*]wclock[*]"
          "[*]Clippy[*]"
          "[*]CMake Temporary[*]"
          "[*]org-src-fontification"
          "[*]ASCII[*]"
          "[*]e2ansi"
          "[*]npm:" "[*]hexo"
          "[*]Flutter"
          "[*]emp"
          "[*]snow[*]")
        diminish-buffer-mode-list '("buffer-menu-mode"
                                    "completion-list-mode"
                                    "compilation-mode" "comint-mode"
                                    "dired-mode"
                                    "help-mode" "custom-mode"
                                    "list-environment-mode"
                                    "shell-mode" "eshell-mode"
                                    "sqlite-mode"
                                    "checkdoc-output-mode"
                                    "proof-splash-mode")))

;;
;; (@* "Hook" )
;;

(diminish-buffer-mode 1)  ; enable by default

(my-add-hook 'diminish-buffer-mode-hook
  (setq centaur-tabs-groups-hash (make-hash-table :test 'equal)
        centaur-tabs-hide-hash (make-hash-table :test 'equal)))
