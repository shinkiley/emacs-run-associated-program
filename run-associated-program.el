;; run-associated-program.el --- 
;;
;; Author: Minae Yui <minae.yui.sain@gmail.com>
;; Version: 0.1
;; URL: 
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; .
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'cl-lib)
(require 's)

(defvar run-associated-program-alist ()
  "")

(defun run-associated-program-clear ()
  ""
  (setq run-associated-program-alist ()))

(defun run-associated-program-register (ext execution-format)
  ""
  (add-to-list 'run-associated-program-alist
               (cons ext execution-format)))

(defun run-associated-program-find-pattern (path)
  "Run program with extension"
  (cl-loop named outer
           for (--fst . --snd) in run-associated-program-alist

           if (and (stringp --fst)
                   (s-ends-with-p --fst path))
           return --snd

           else if (and (functionp --fst)
                        (funcall --fst path))
           return --snd

           else if (listp --fst)
           return (cl-loop for --ext in --fst
                           when (and (stringp --ext)
                                     (s-ends-with-p --ext path))
                           return --snd)))

(defun run-associated-program-run (path)
  ""
  (let* ((--cmd (run-associated-program-find-pattern path)))
    (if --cmd
        (start-process --cmd nil --cmd path)
      (user-error "Can't find executable for %s" path))))

(provide 'run-associated-program)
;;; run-associated-program.el ends here
