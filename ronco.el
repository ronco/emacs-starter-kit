;; tramp
(setq tramp-default-method "ssh")
;; colors
(require 'color-theme)
(if window-system
    (color-theme-blackboard))

;; tabs
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
	(shell-command-on-region (point) (mark) "perltidy -t -nola -q" nil t))
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
  (4x4-tabs)
  (setq cperl-indent-level 4)
  (define-key cperl-mode-map [f5] 'perltidy-defun)
  (define-key cperl-mode-map [f6] 'perltidy-region)
  )


(add-hook 'cperl-mode-hook 'ron-perl-hook)

;; lisp stuff



;; GLOBAL BINDINGS

(fset 'triple-screen
   "\C-x1\C-x3\C-x3\C-x+")
(global-set-key "\M-3"     'triple-screen)
(fset 'twin-screen
   "\C-x1\C-x3\C-x+")
(global-set-key "\M-2"     'twin-screen)
(global-set-key "\C-c/"     'comment-or-uncomment-region)

;; org
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-clock-idle-time 5)
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files (list (concat org-directory "/work.org")
                             (concat org-directory "/home.org")
                             (concat org-directory "/auth_release.org")
                             org-default-notes-file))

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
        (sequence "NEW" "IN PROGRESS" "|" "FIXED" "DECLINED")
        (sequence "|" "CANCELED")))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; buffer window toggling
(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-\M-j"  'bs-cycle-next)
(global-set-key "\M-j"     'bs-cycle-previous)
(global-set-key "\M-o"     'other-window)
