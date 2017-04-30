(require 'package)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

;;     (add-to-list 'load-path "~/.emacs.d/evil") 
     (require 'evil)
     (evil-mode 1)

(require 'mu4e)
;; something about ourselves
(setq mu4e-reply-to-address "tony.cheneau@amnesiak.org"
   user-mail-address "tony.cheneau@amnesiak.org"
   user-full-name  "Tony Cheneau")

 (setq mu4e-maildir "~/Maildir-mbsync/")

(setq mu4e-headers-date-format "%Y-%m-%d %H:%M")

(setq mu4e-view-show-addresses 't)


(setq mu4e-sent-folder "/Sent"
mu4e-drafts-folder "/Drafts"
mu4e-trash-folder "/Trash")

;; am using nullmailer, so my mail sending just became STUPID fast
(setq message-send-mail-function 'message-send-mail-with-sendmail)

(setq mu4e-get-mail-command "mbsync amnesiak-inbox")

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/Sent Items"   . ?s)
         ("/Trash"       . ?t)
         ("/Drafts"    . ?d)))


(setq mu4e-html2text-command "w3m -T text/html")
(setq mu4e-view-prefer-html t)


;;; message view action in external browser (Google Chrome)
(defun mu4e-msgv-action-view-in-external-browser (msg)
  "View the body of the message in a external web browser."
  (interactive)
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (unless html (error "No html part for this message"))
    (with-temp-file tmpfile
      (insert
       "<html>"
       "<head><meta http-equiv=\"content-type\""
       "content=\"text/html;charset=UTF-8\">"
       html))
    (browse-url (concat "file://" tmpfile))))

(add-to-list 'mu4e-view-actions
             '("Chromium external browser" . mu4e-msgv-action-view-in-external-browser) t)

    (setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "chromium-browser")
;;show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(add-hook 'after-init-hook #'global-flycheck-mode)

(defun my-go-mode-hook ()
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
     (require 'go-autocomplete))
