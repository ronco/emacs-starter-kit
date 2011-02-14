;; tramp
(setq tramp-default-method "ssh")
;; colors
(color-theme-blackboard)
;; org
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)

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

;; org
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
     
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; buffer window toggling
(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-\M-j"  'bs-cycle-next)
(global-set-key "\M-j"     'bs-cycle-previous)
(global-set-key "\M-o"     'other-window)
