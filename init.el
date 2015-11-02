(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; basic settings.
(define-key mode-specific-map "c" 'compile)
(menu-bar-mode -1)
(setq completion-ignore-case t)
(custom-set-variables
 '(read-file-name-completion-ignore-case t))

(setq-default show-trailing-whitespace t)

;; highlight current line
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "black" :foreground "white"))
    (((class color)
      (background light))
     (:background "Blue"))
    (t
     ()))
           "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; install bundles
(el-get-bundle auto-complete)
(el-get-bundle perl6-mode)
(el-get-bundle go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

;; must have godef command. run 'go get github.com/rogpeppe/godef' to get it.
(add-hook 'go-mode-hook
	  (lambda ()
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (setq-default)
	    (setq tab-width 2)
	    (setq standard-indent 2)
	    (setq indent-tabs-mode nil)))

;;must have go-autocomplete. run 'go get -u github.com/nsf/gocode'
(add-to-list 'load-path (substitute-in-file-name "${GOPATH}/src/github.com/nsf/gocode/emacs"))
(require 'go-autocomplete)
(require 'auto-complete-config)

;; go get -u github.com/dougm/goflymake
(add-to-list 'load-path (substitute-in-file-name "${GOPATH}/src/github.com/dougm/goflymake"))
(require 'go-flymake)

(add-hook 'perl6-mode-hook
	  (lambda ()
	    (set (make-local-variable 'compile-command)
		 (concat "perl6 " buffer-file-name))))

;; C/C++
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

;; git
(el-get-bundle magit)
(require 'magit)

