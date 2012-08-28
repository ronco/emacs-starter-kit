;; tramp
(setq tramp-default-method "ssh")
;; colors
(require 'color-theme)
(if window-system
    (color-theme-blackboard))

;; package repos
;; (add-to-list 'package-archives '("org-odt-repo" . "http://repo.or.cz/w/org-mode/org-jambu.git/blob_plain/HEAD:/packages/"))

;; behavioral stuff

(setq ns-pop-up-frames 'nil)

; code templates
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; tabs & spaces
(defun 4x4-spaces ()
  "Setting to use spaces for tabs at a width of 4"
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4))
(defun 4x4-tabs ()
  "Setting to use tabs at a width of 4"
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq c-basic-offset 4))

(setq nxml-indent 4)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Ediff
(setq ediff-diff-options "-w")

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

(defun ron-php-hook ()
  "My php settings"
  (c-set-style "k&r")
  (4x4-spaces)
  (c-set-offset 'comment-intro 0)
  )

(defun ron-js-hook ()
  "My JS settings"
  (whitespace-mode)
  )


(add-hook 'cperl-mode-hook 'ron-perl-hook)
(add-hook 'php-mode-hook 'ron-php-hook)
(add-hook 'js-mode-hook 'ron-js-hook)

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

(load "nxhtml/autostart.el")

(setq auto-mode-alist
      (append
       '(
         ("\\.logconfig$" . conf-javaprop-mode)
         ("\\.php$" . php-mode)
         ("\\.tpl$" . smarty-html-mumamo)
         ("\\.jstemplate$" . smarty-html-mumamo)
         ) auto-mode-alist))

(setq warning-minimum-level :error)

;; MAGIT

(require 'magit)

;; Mercurial
;; (require 'mercurial)
;; (require 'ahg)
(load-file "/usr/local/share/emacs/site-lisp/dvc/dvc-load.el")

;; GLOBAL BINDINGS

(fset 'triple-screen
   "\C-x1\C-x3\C-x3\C-x+")
(fset 'twin-screen
   "\C-x1\C-x3\C-x+")
(fset 'triple-u-screen
      "\C-x1\C-x2\C-x3\C-u15\C-x^")

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

;; start emacs server
(server-start)

;; yasnippet support defuns
(defun rcw/uc-first (string)
  (concat
   (upcase (substring string 0 1))
   (substring string 1)
   )
  )

(defun rcw/buff-ns-as-list ()
  (interactive)
  (let
      (
       (path (split-string (directory-file-name (file-name-directory (buffer-file-name))) "/"))
       )
    (rcw/remove-lib path)
      )
  )

(defun rcw/buff-as-full-class ()
  (mapconcat 'identity (rcw/buff-class-as-list) "_")
  )

(defun rcw/buff-class-as-list ()
  (interactive)
  (let
      (
       (path (split-string (file-name-sans-extension (buffer-file-name)) "/"))
       )
    (rcw/remove-lib path)
    )
  )

(defun rcw/buff-ns-as-ns ()
  (mapconcat 'identity (rcw/buff-ns-as-list) "\\")
  )

(defun rcw/remove-lib (directory-list)
  (if directory-list
      (if (equal (car directory-list) "lib")
          (cdr directory-list)
        (rcw/remove-lib (cdr directory-list))
        )
    '("")
    )
  )

;; Remote shell commands
(defun dev-shell (&optional buffer-name)
  "start or switch to a shell buffer on dev02"
  (interactive
   (list
    (and current-prefix-arg
         (read-buffer "Shell buffer: "
                      (generate-new-buffer-name "*dev02-shell*"))))
   )
  (tramp-shell "/ssh:rowhite@den3dev02:/home/ldap/rowhite/pbcode/dev" (or buffer-name "*dev02-shell*"))
  )

(defun tramp-shell (tramp-path buffer-name)
  "start or switch to a shell running in a tramp remote directory"
  (let
      ( (default-directory tramp-path) )
    (shell buffer-name )
    )
  )

;;; db routine template
;; (defun shared-db ()
;; "start a mysql buffer for shared_dev db"
;; (interactive)
;; (setq buffer-name "*shared-db*")
;; (if (comint-check-proc buffer-name)
;;     (pop-to-buffer buffer-name)
;;   (let (
;;         (default-directory "/ssh:shell_server:/home/dir")
;;         (sql-user "shared_devuser")
;;         (sql-password "shared_devuser")
;;         (sql-database "shared_dev_shard1")
;;         (sql-server "db_server")
;;         )
;;     (sql-mysql)
;;     (rename-buffer "*shared-db*")
;;    )
;;   )
;; )

