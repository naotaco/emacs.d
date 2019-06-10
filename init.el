(setq inhibit-startup-screen t)

;; load el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(el-get-bundle cl-lib)
(el-get-bundle auto-complete)
(el-get-bundle anything)
;; (el-get-bundle perl6-mode)
(el-get-bundle go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

;; basic settings
(define-key mode-specific-map "c" 'compile)
(menu-bar-mode -1)
(setq completion-ignore-case t)

(setq-default show-trailing-whitespace t)

;; highlighted line number settings
(el-get-bundle elpa:hlinum)
(custom-set-faces
 '(linum ((t (:foreground "white"
			  :background "black")))))
(setq linum-format "%4d  ")
(hlinum-activate)
(custom-set-faces
 '(linum-highlight-face ((t (:foreground "pink"
					 :background "black")))))
;; activate settings
(custom-set-variables
 '(read-file-name-completion-ignore-case t)
 '(global-linum-mode t))

;;;; Language specified settings

((lambda ()
   ;; must have godef command. run 'go get github.com/rogpeppe/godef' to get it.
   (add-hook 'go-mode-hook
	     (lambda ()
	       (setq-default)
	       (setq tab-width 2)
	       (setq standard-indent 2)
	       (setq indent-tabs-mode nil)
	       (if (not (string-match "go" compile-command))
		   (set (make-local-variable 'compile-command)
			(concat "go build -v " (buffer-file-name))))
	       (local-set-key (kbd "M-.") 'godef-jump)
	       ))

   ;; must have go-autocomplete. run 'go get -u github.com/nsf/gocode'
   ;; (el-get-bundle elpa:go-autocomplete)
   ;; (require 'go-autocomplete)
   ;; (require 'auto-complete-config)

   ;; get -u github.com/dougm/goflymake
   ;; (add-to-list 'load-path (substitute-in-file-name "/home/nao/go_work/src/github.com/dougm/goflymake")) ;
   ;; (require 'go-flymake)

   ))



;; C/C++
(require 'cc-mode)
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq tab-width 4)
	    (c-set-style
	     "cc-mode")
	    (setq c-basic-offset 4)
	    (indent-tabs-mode nil)
	    )
	  )

;; perl-mode
(add-hook 'perl-mode-hook
	  '(lambda ()
	     (make-local-variable 'compile-command)
	     (setq compile-command
		   (concat "perl " (buffer-file-name)))
	     ))
(add-hook 'perl6-mode-hook
	  '(lambda ()
	     (make-local-variable 'compile-command)
	     (setq compile-command
		   (concat "perl6 " (buffer-file-name)))
	     ))

;; yaml
(el-get-bundle 'yaml-mode)

;; (el-get-bundle magit)
;; (require 'magit)

;; md
(el-get-bundle jrblevin/markdown-mode)

(el-get-bundle dockerfile-mode)

;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(el-get-bundle helm
  (helm-mode 1)
  (require 'helm-config)
  (helm-mode 1)
  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)
  (define-key global-map (kbd "M-r")     'helm-resume)
  (define-key global-map (kbd "C-M-h")   'helm-apropos)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  )


(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; #rust

(el-get-bundle rust-mode)
(el-get-bundle lsp-mode
  (add-hook 'rust-mode 'lsp-mode))
(el-get-bundle lsp-ui)
(el-get-bundle cargo
  (add-hook 'rust-mode 'cargo-minor-mode)
  )

(add-hook 'before-save-hook
          (lambda ()
            (when (eq major-mode 'rust-mode)
              (rust-format-buffer))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; #lsp

;; (use-package lsp-mode
;;   :ensure t
;;   :init (yas-global-mode)
;;   :hook (rust-mode . lsp)
;;   :bind ("C-c h" . lsp-describe-thing-at-point)
;;   :custom (lsp-rust-server 'rust-analyzer))
;; (use-package lsp-ui
;; 	     :ensure t)


(el-get-bundle 'powerline)
(require 'powerline)
(powerline-default-theme)


(load-theme 'deeper-blue)

(set-face-attribute 'default nil :height 160)
>>>>>>> update for desktop env
