;;; ob-d2.el --- org-babel functions for d2

;; Copyright (C) 2022-2023 Xavier Capaldi

;; Author: Xavier Capaldi
;; Keywords: d2, literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Org-Babel support for evaluating d2 diagram scripting source code.
;;
;; d2 differs from most standard languages in that:
;;
;; 1) there is no such thing as a "session" in d2
;;
;; 2) we are only going to return results of type "file"
;;
;; 3) you can specify `:flags' headers to be passed to the `d2' command
;;
;; 4) there are no variables (at least for now)

;;; Requirements:

;; - You must have d2 installed and d2 should be in your `exec-path'. If not,
;;   feel free to modify `org-babel-d2-command' to the location of your d2
;;   command.
;;
;; - `d2-mode' is also recommended for syntax highlighting and formatting,
;;   however it is not required.

;;; TODO

;; - Provide better error feedback.

;;; Code:
(require 'ob)
(require 'org-compat)

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("d2" . "d2"))

(defvar org-babel-default-header-args:d2
  '((:results . "file")
    (:exports . "results"))
  "Default arguments for evaluating a d2 source block.")

(defvar org-babel-d2-command "d2"
  "The d2 command to use to compile and run the d2 code.")

(defun org-babel-execute:d2 (body params)
  "Execute a block of d2 code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((out-file (or (cdr (assq :file params))
		       (error
			"d2 code block requires :file header argument")))
	 (flags (cdr (assq :flags params)))
	 (in-file (org-babel-temp-file "d2-src-" ".d2"))
	 (cmd (concat org-babel-d2-command
		          " " flags
                  " " (org-babel-process-file-name in-file)
                  " " (org-babel-process-file-name out-file))))
    
    (with-temp-file in-file (insert body))
    (message cmd)
    (shell-command cmd)
    nil))

(defun org-babel-prep-session:d2 (session params)
  "Return an error because d2 does not support sessions."
  (error "d2 does not support sessions"))

(provide 'ob-d2)

;;; ob-d2.el ends here
