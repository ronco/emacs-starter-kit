(defun timer-markup (start end label)
  ""
  (interactive
   (let ((string (read-from-minibuffer "timer label: ")))
     (list (region-beginning) (region-end) string)))
  (save-excursion
    (goto-char end)
    (insert (concat "[% CALL timer.stop('" label "') %]\n"))
    (goto-char start)
    (insert (concat "[% CALL timer.start('" label "') %]\n"))))
(global-set-key "\M-0" 'timer-markup)

(defun timer-internal-markup (start end label)
  ""
  (interactive
   (let ((string (read-from-minibuffer "timer label: ")))
     (list (region-beginning) (region-end) string)))
  (save-excursion
    (goto-char end)
    (insert (concat "CALL timer.stop('" label "');\n"))
    (goto-char start)
    (insert (concat "CALL timer.start('" label "');\n"))))
(global-set-key "\M-9" 'timer-internal-markup)

(defun timer-perl (start end label)
  ""
  (interactive
   (let ((string (read-from-minibuffer "timer label: ")))
     (list (region-beginning) (region-end) string)))
  (save-excursion
    (goto-char end)
    (insert (concat "$timer->stop('" label "');\n"))
    (goto-char start)
    (insert (concat "$timer->start('" label "');\n"))))
(global-set-key "\M-8" 'timer-perl)

; function for label2fieldlabelrender
(defun label-markup (start end label)
  ""
  (interactive
   (let ((string (read-from-minibuffer "filter: ")))
     (list (region-beginning) (region-end) string)))
  (save-excursion
    (goto-char end)
    (insert (concat "' | " label " %]"))
    (goto-char start)
    (insert "[% '")))
