
;; [Fri Jun  3 15:01:46 2011]: 	0 of which are not already in DB
;; [Fri Jun  3 15:01:46 2011]: starting processing of address trackvia@nationalfutures.com in dataset 2000050244

;; Remote shell commands
(defun dev-shell (&optional buffer-name)
  "start or switch to a shell buffer on dev02"
  (interactive
   (list
    (and current-prefix-arg
         (read-buffer "Shell buffer: "
                      (generate-new-buffer-name "*dev02-shell*"))))
   )
  (tramp-shell "/ssh:dev02.int.trackvia.com#33322:/home/rwhite/trackvia" (or buffer-name "*dev02-shell*"))
  )


(defun prod-shell (path buffer-name)
  "start a shell on an arbitrary production server"
  (interactive
   (let ((server-name (read-from-minibuffer "prod server: ")))
     (let ((tramp-path (concat "/ssh:trackvia@" server-name ".int.trackvia.com#33322:/home/trackvia/trackvia"))
           (default-buffer-name (concat "*" server-name "-shell*")))
       (list tramp-path (read-buffer "Shell buffer name: " (generate-new-buffer-name default-buffer-name)))
       )
     )
   )
  (tramp-shell path buffer-name)
  )


(defun tramp-shell (tramp-path buffer-name)
  "start or switch to a shell running in a tramp remote directory"
  (let 
      ( (default-directory tramp-path) )
    (shell buffer-name )
    )
  )

;; db commands
(defun beta-db ()
  "start a mysql buffer for beta db"
  (interactive)
  (setq buffer-name "*beta-db*")
  (if (comint-check-proc buffer-name)
      (pop-to-buffer buffer-name)
    (let (
          (default-directory "/ssh:dev02.int.trackvia.com#33322:/home/rwhite")
          (sql-user "betauser")
          (sql-password "betauser")
          (sql-database "beta2_shard1")
          (sql-server "dev01.int.trackvia.com")
          )
      (sql-mysql)
      (rename-buffer "*beta-db*")
     )
    )
  )

(defun shared-db ()
  "start a mysql buffer for shared_dev db"
  (interactive)
  (setq buffer-name "*shared-db*")
  (if (comint-check-proc buffer-name)
      (pop-to-buffer buffer-name)
    (let (
          (default-directory "/ssh:dev02.int.trackvia.com#33322:/home/rwhite")
          (sql-user "shared_devuser")
          (sql-password "shared_devuser")
          (sql-database "shared_dev_shard1")
          (sql-server "dev02.int.trackvia.com")
          )
      (sql-mysql)
      (rename-buffer "*shared-db*")
     )
    )
  )

