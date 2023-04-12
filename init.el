;; Increases Garbage Collection During Startup
;; (setq gc-cons-threshold most-positive-fixnum)
;; (setq startup/gc-cons-threshold gc-cons-threshold)
;; (defun startup/reset-gc () (setq gc-cons-threshold startup/gc-cons-threshold))
;; (add-hook 'emacs-startup-hook 'startup/reset-gc)

(setenv "PATH" (concat (getenv "PATH") ":/home/matt/.local/bin:/home/matt/.cabal/bin"))
(setf select-enable-primary t)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")
			 ("org"   . "http://orgmode.org/elpa/")))

(package-initialize)
;; (package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region compilation-filter-start (point))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(add-to-list 'load-path "~/.emacs.d/lisp")
(byte-recompile-directory "~/.emacs.d/lisp" 0)
;; (load "rustc-compile")

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(load "hoon-mode")
(add-hook 'hoon-mode
          (lambda ()
            (define-key hoon-mode-map (kbd "C-c r") 'hoon-eval-region-in-herb)
            (define-key hoon-mode-map (kbd "C-c b") 'hoon-eval-buffer-in-herb)
      	    (setq tab-width 2)))

(setq tramp-auto-save-directory "/tmp")

(use-package fixmee
  :ensure t
  :init
  (require 'fixmee)
  (require 'button-lock))

(use-package yasnippet
  :ensure t
  :hook
  ((lsp-mode . yas-minor-mode)))

(use-package xclip
  :ensure t
  :init (xclip-mode 1))

(use-package vterm
  :ensure t
  :config
  (setq vterm-always-compile-module t))

(use-package avy
  :ensure t)
(global-set-key (kbd "M-s") 'avy-goto-word-1)

(use-package gruber-darker-theme
  :ensure t
  :init
  (load-theme 'gruber-darker t))

;; (use-package zerodark-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zerodark t))


(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

(use-package sly
  :ensure t)

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           'enable-paredit-mode)
  (add-hook 'sly-mrepl-mode-hook        'enable-paredit-mode))
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook       'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook             'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook           'rainbow-delimiters-mode)
  (add-hook 'sly-mrepl-mode-hook        'rainbow-delimiters-mode))


(use-package magit
  :ensure t)

(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; (use-package irony
;;   :ensure t
;;   :init
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook (lambda ()
;;     (define-key irony-mode-map [remap completion-at-point]
;;       'irony-completion-at-point-async)
;;     (define-key irony-mode-map [remap complete-symbol]
;;       'irony-completion-at-point-async)))
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company
  :ensure t
  :init
  ;; (add-hook 'c++-mode-hook #'company-mode)
  ;; (add-hook 'c-mode-hook #'company-mode)
  (add-hook 'emacs-lisp-mode-hook       #'company-mode)
  (add-hook 'lisp-mode-hook             #'company-mode)
  (add-hook 'lisp-interaction-mode-hook #'company-mode)
  (add-hook 'sly-mrepl-mode-hook        #'company-mode)
  (add-hook 'rustic-mode-hook           #'company-mode)
  (setq company-idle-delay 0.05
	company-minimum-prefix-length 3))

;; (use-package company-irony
;;   :ensure t
;;   :init
;;   (eval-after-load 'company
;;   '(add-to-list 'company-backends #'company-irony)))


;; (load "/home/matt/.opam/default/share/emacs/site-lisp/tuareg-site-file")
;; (let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
;;   (when (and opam-share (file-directory-p opam-share))
;;     ;; Register Merlin
;;     (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
;;     (autoload 'merlin-mode "merlin" nil t nil)
;;     ;; Automatically start it in OCaml buffers
;;     (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;     (add-hook 'caml-mode-hook 'merlin-mode t)
;;     ;; Use opam switch to lookup ocamlmerlin binary
;;     (setq merlin-command 'opam)
;;     (with-eval-after-load 'company
;;       (add-to-list 'company-backends 'merlin-company-backend))
;;     (add-hook 'merlin-mode-hook 'company-mode)))


(use-package flycheck
  :ensure t
  :init
  (add-hook 'c++-mode-hook #'flycheck-mode)
  (add-hook 'c-mode-hook #'flycheck-mode))


;; (use-package flycheck-irony
;;   :ensure t
;;   :init
;;   (eval-after-load 'flycheck
;;     '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(add-hook 'c++-mode-hook (lambda () (c-set-offset 'innamespace [0])))

(use-package cmake-mode
  :ensure t)


(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (haskell-mode . lsp)
	 (go-mode . lsp)
	 
         ;; if you want which-key integration
         )
  :commands (lsp lsp-defered))
(setq lsp-enable-snippet 0)
(setq lsp-enable-snippet 0)

(use-package eglot
  :ensure t
  :config
  (add-hook 'eglot--managed-mode-hook (lambda () (flycheck-mode -1)))
  )

(use-package rustic
  :ensure t
  :config
  (setq rustic-analyzer-command '("rust-analyzer"))
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-server 'rust-analyzer)
  (setq rustic-lsp-client 'eglot)
  )

(use-package haskell-mode
  :ensure t)
(use-package go-mode
  :ensure t)

(use-package lsp-haskell
  :ensure t
  :init
  (setq lsp-haskell-server-path (concat (getenv "HOME") "/.cabal/bin/haskell-language-server-wrapper")))

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  ("M-x" . smex))

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer
	switch-window-increase 4
	switch-window-threshold 2
	switch-window-shortcut-style 'qwerty
	switch-window-qwerty-shortcuts '("a" "s" "d" "f" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

(setq display-time-default-load-average nil)
;; (display-time-mode t)

;; (global-linum-mode 1)
(setq scroll-conservatively 10000)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq c-default-style "gnu"
      c-basic-offset 2)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(show-paren-mode 1)
(global-prettify-symbols-mode t)
(setq indent-tabs-mode nil)
;; (setq scheme-program-name "guile")
(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-zsh)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(defun kill-around-characters (char1 char2)
  (kill-region
   (progn
     (search-backward (char-to-string char1) nil nil 1)
     (forward-char)
     (- (point) 1))
   (progn
     (search-forward (char-to-string char2) nil nil 1)
     (point))))

(defun kill-between-characters (char1 char2)
  (kill-region
   (progn
     (search-backward (char-to-string char1) nil nil 1)
     (forward-char)
     (point))
   (progn
     (search-forward (char-to-string char2) nil nil 1)
     (backward-char)
     (point))))

(defun kill-between-quotes ()
  (kill-between-characters ?\" ?\"))
(defun kill-between-parentheses ()
  (kill-between-characters ?\( ?\)))
(defun kill-between-curlies ()
  (kill-between-characters ?{ ?}))
(defun kill-between-angles ()
  (kill-between-characters ?< ?>))
(defun kill-between-squares ()
  (kill-between-characters ?\[ ?\]))

(defun kill-around-quotes ()
  (kill-around-characters ?\" ?\"))
(defun kill-around-parentheses ()
  (kill-around-characters ?\( ?\)))
(defun kill-around-curlies ()
  (kill-around-characters ?{ ?}))
(defun kill-around-angles ()
  (kill-around-characters ?< ?>))
(defun kill-around-squares ()
  (kill-around-characters ?\[ ?\]))



(defun lang-server ()
  (interactive)
  (async-shell-command (concat (concat "langserv " (buffer-file-name)))))
(global-set-key (kbd "M-RET") 'lang-server)

(defun split-and-follow-horiz ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horiz)

(defun split-and-follow-verti ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-verti)

(defun find-file-as-root (file-path)
  (find-file (concat "/su::" (file-truename file-path))))


 ;; I don't know how this should be indented lol
;; (add-hook 'eshell-mode-hook
;; 	  (lambda ()
;; 	    (interactive)
;; 	    (local-set-key (kbd "C-c l")
;; 			   (lambda ()
;; 			     (interactive)
;; 			     (eshell/clear 1)
;; 			     (eshell-send-input)))))

;; (add-hook 'eshell-mode-hook
;; 	  (lambda ()
;; 	    (interactive)
;; 	    (eshell/addpath (concat
;; 			     (file-name-as-directory (getenv "HOME"))
;; 			     ".local/bin"))))

(defun create-new-vterm-buffer ()
  (interactive)
  (vterm "vterm"))

(global-set-key (kbd "<C-return>") 'create-new-vterm-buffer)

(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "C-c k") 'kill-line)
(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-c n") 'next-buffer)
(global-set-key (kbd "C-c p") 'previous-buffer)
(global-set-key (kbd "C-c C-s") 'run-scheme)


(setq ibuffer-expert t)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" default))
 '(package-selected-packages
   '(gruber-darker-theme gruvbox gruvbox-theme vterm go-mode xclip xclip-mode lsp-haskell haskell-language-server pdftools pdf-tools rainbow-delimiters rainbow-delimeters evil haskell-mode paredit hoon-mode magit rust-mode lsp-mode rustic flycheck-irony flycheck cmake-mode company-irony irony avy switch-window smex ido-vertical-mode zerodark-theme use-package))
 '(send-mail-function 'sendmail-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "PfEd" :family "Iosevka")))))

(put 'dired-find-alternate-file 'disabled nil)
