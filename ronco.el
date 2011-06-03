;; tramp
(setq tramp-default-method "ssh")
;; colors
(require 'color-theme)
(if window-system
    (color-theme-blackboard))

;; behavioral stuff

(setq ns-pop-up-frames 'nil)

;; tabs
(defun 4x4-spaces ()
  "Setting to use spaces for tabs at a width of 4"
  (setq indent-tabs-mode nil)
  (setq tab-width 4))
(defun 4x4-tabs ()
  "Setting to use tabs at a width of 4"
  (setq indent-tabs-mode t)
  (setq tab-width 4))

;; This is perl related stuff

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (if (use-region-p)
      (save-excursion
	(shell-command-on-region (point) (mark) "perltidy -l=90 -nola -q" nil t))
      (save-excursion (mark-whole-buffer) (perltidy-region))
    )
  )
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
        (perltidy-region)))

(defun ron-perl-hook ()
  "My perl settings"
  (cperl-set-style "BSD")
  (4x4-spaces)
  (setq cperl-indent-level 4
        cperl-indent-parens-as-block t
        cperl-close-paren-offset -4)
  (define-key cperl-mode-map [f5] 'perltidy-defun)
  (define-key cperl-mode-map [f6] 'perltidy-region)
  )


(add-hook 'cperl-mode-hook 'ron-perl-hook)

;; TT stuff
(require 'mumamo-fun)
(setq auto-mode-alist (append '(("\\.tt$" . tt-html-mumamo)) auto-mode-alist))
(defun ron-tt-html-mumamo-hook
  (local-set-key (kbd "M-TAB") 'nxml-complete)
  (local-set-key (kbd "C-ci") 'indent-region)
  (local-set-key (kbd "C-cC-i") 'indent-buffer)
  )

(add-hook 'tt-html-mumamo-mode 'ron-tt-html-mumamo-hook)

;; Obj-c stuff
(defun ron-objc-hook ()
  "My Objective-C settings"
  (c-set-style "BSD")
  (4x4-tabs)
  (local-set-key (kbd "RET") 'newline-and-indent)
  )

(add-hook 'objc-mode-hook 'ron-objc-hook)


;; lisp stuff


;; Modes
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; MAGIT
(require 'magit)
(require 'magit-svn)

;; GLOBAL BINDINGS

(fset 'triple-screen
   "\C-x1\C-x3\C-x3\C-x+")
(global-set-key "\M-3"     'triple-screen)
(fset 'twin-screen
   "\C-x1\C-x3\C-x+")
(global-set-key "\M-2"     'twin-screen)
(fset 'triple-u-screen
      "\C-x1\C-x2\C-x3\C-u15\C-x^")
(global-set-key "\M-4"     'triple-u-screen)
(global-set-key "\C-c/"     'comment-or-uncomment-region)

;; org
(setq org-clock-idle-time 5)
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list (concat org-directory "/work.org")
                             (concat org-directory "/home.org")
                             (concat org-directory "/someday.org")
                             org-default-notes-file))
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
        (sequence "NEW" "IN PROGRESS" "|" "FIXED" "DECLINED")
        (sequence "|" "CANCELED")))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(add-hook 'text-mode-hook 'turn-on-orgtbl)

;; buffer window toggling
(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-\M-j"  'bs-cycle-next)
(global-set-key "\M-j"     'bs-cycle-previous)
(global-set-key "\M-o"     'other-window)
