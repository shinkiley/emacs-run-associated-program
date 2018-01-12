;; run-associated-program-test.el --- 
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

(require 'buttercup)
(require 'run-associated-program)


(describe "run-associated-program-find-pattern"
  (before-each
    (run-associated-program-clear))

  (defmacro define-simple-test (desc condition path)
    ""
    `(it ,desc
       (let ((--pattern "smplayer")
             (--ext     ,condition)
             (--path    ,path))
         (run-associated-program-register --ext --pattern)
         (expect (run-associated-program-find-pattern --path)
                 :to-equal --pattern))))

  (define-simple-test "Finds pattern by extension name"
    "mkv"
    "/home/rrinko/nyan.mkv")

  (define-simple-test "Finds pattern by lambda"
    (lambda (path)
      (s-ends-with-p ".mkv" path))
    "/home/rrinko/nyan.mkv")

  (define-simple-test "Finds pattern by list of one item"
    (list "mkv")
    "/home/rrinko/nyan.mkv")

  (define-simple-test "Finds pattern by list of many items"
    (list "avi" "mkv" "flv")
    "/home/rrinko/nyan.mkv"))


;; Local Variables:
;; eval: (put 'describe    'lisp-indent-function 'defun)
;; eval: (put 'it          'lisp-indent-function 'defun)
;; eval: (put 'before-each 'lisp-indent-function 'defun)
;; eval: (put 'after-each  'lisp-indent-function 'defun)
;; eval: (put 'before-all  'lisp-indent-function 'defun)
;; eval: (put 'after-all   'lisp-indent-function 'defun)
;; End:
