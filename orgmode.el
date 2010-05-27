;; Copyright (c) 2010 Charles Cave
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use,
;; copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following
;; conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;; OTHER DEALINGS IN THE SOFTWARE.

;; .emacs file     Selected entries from ~/.emacs.el
;; file of Charles Cave to run org-mode
;; Modified by Sam Ritchie, 2010, uploaded to GitHub

;; Set the default tab width. Not sure if I like this.
(setq-default tab-width 3)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done nil)
(setq org-agenda-include-diary nil)
(setq org-deadline-warning-days 7)
(setq org-timeline-show-empty-dates t)
(setq org-insert-mode-line-in-empty-file t)

;; Hides depends tasks in agenda view. C-c C-x o add the ordered property to a project.
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-enforce-todo-checkbox-dependencies t)

;;
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(setq org-remember-templates
     '(
       ("Inbox" ?i "* TODO %^{Brief Description} %^g\n%?Added: %U" "~/org/GTD/gtd.org" "Inbox")
       ("Todo" ?t "* TODO %^{Brief Description} %^g\n%?Added: %U" "~/org/GTD/gtd.org" "Tasks")
       ("Calendar" ?c "* %^{Brief Description} %^{Date}t\n%?Added: %U" "~/org/GTD/gtd.org" "Calendar")
       ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "~/org/GTD/privnotes.org")
      ))

(define-key global-map [f9] 'remember)
(define-key global-map [f10] 'remember-region)

(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (htmlize-output-type 'css)))

;; iCal Sync Settings
(setq org-combined-agenda-icalendar-file
      "~/Library/Calendars/OrgMode.ics")
(add-hook 'org-after-save-iCalendar-file-hook
          (lambda ()
            (shell-command
             "osascript -e 'tell application \"iCal\" to reload calendars'")))

;; org stuck projects settings
(setq org-stuck-projects
(quote
("+PROJECT/-DONE-CANCELLED" nil ("NEXT" "TODO" "STARTED" "WAITING" "APPT") "")
))

;; there is, of course, a far better way to do this, I just don't know it yet
(setq org-agenda-custom-commands
'(
  
("W" "Office & Work Lists"
 ((agenda "" ((org-agenda-ndays 1)))
  (tags-todo "OFFICE"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))
  (tags-todo "PHONE"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))  
  (tags-todo "EMAIL"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))  
  (tags-todo "COMPUTER"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))  
  (tags-todo "EMACS"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))  
  ))

("H" "Home List"
 ((agenda "" ((org-agenda-ndays 1)))
  (tags-todo "HOME" ((org-agenda-skip-function (quote (org-agenda-skip-entry-if 'scheduled 'deadline))))
             )
  (tags-todo "COMPUTER"((org-agenda-skip-function (quote (org-agenda-skip-entry-if 'scheduled 'deadline))))
             )
  (tags-todo "ONLINE"((org-agenda-skip-function (quote (org-agenda-skip-entry-if 'scheduled 'deadline))))
             )
  (tags-todo "READING" ((org-agenda-skip-function (quote (org-agenda-skip-entry-if 'scheduled 'deadline))))
             )
))

("E" "Errands"
 ((tags-todo "ERRANDS")
  (tags-todo "PHONE")
  (tags-todo "VIRGINIA")
  (tags-todo "ONLINE"
             ((org-agenda-skip-function
               (quote
                (org-agenda-skip-entry-if 'scheduled 'deadline))
               )))
  ))

("T" "People Agendas"
 ((tags-todo "AGENDA")
  (todo "WAITING")))


("D" "Daily Action List"
     (
          (agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))

("A" "Tasks to be Archived" tags "LEVEL=2/DONE|CANCELLED" nil)
))

(defun gtd ()
    (interactive)
    (find-file "~/org/GTD/gtd.org")
)
(global-set-key (kbd "C-c g") 'gtd)

(add-hook 'org-agenda-mode-hook 'hl-line-mode)

; org mode start - added 20 Feb 2006
;; The following lines are always needed. Choose your own keys.

(global-set-key "\C-x\C-r" 'prefix-region)
(global-set-key "\C-x\C-l" 'goto-line)
(global-set-key "\C-x\C-y" 'copy-region-as-kill)
