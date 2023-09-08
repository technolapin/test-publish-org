(require 'ox-publish) 
(setq root-dir default-directory)
(setq org-dir (concat root-dir "org/"))
(setq build-dir (concat root-dir "build/"))
(setq pdf-dir (concat root-dir "pdf/"))
(setq html-dir (concat root-dir "html/"))

(defun create-missing-dir (dir)
  (unless (file-exists-p dir)
  (message (concat "Creating missing " dir " directory..."))
  (make-directory dir t) ))

;; root is supposed to exists since that's where this file is
(create-missing-dir org-dir)
(create-missing-dir build-dir)
(create-missing-dir pdf-dir)
(create-missing-dir html-dir)

;; the pdflatex/biber pipeline to correctly generate a pdf
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-publish-project-alist
      `(

        ("org-compile-html"
         :base-directory ,org-dir
         :base-extension "org"
         :publishing-directory ,html-dir
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t
         )

        ("org-copy-to-build"
         :base-directory ,org-dir
         :base-extension any
         :publishing-directory ,build-dir
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-compile-latex"
         :base-directory ,build-dir
         :base-extension "org"
         :publishing-directory ,pdf-dir
         :recursive t
         :publishing-function org-latex-publish-to-pdf
         :headline-levels 4
         :auto-preamble t
         )

        ("org-copy-assets"
         :base-directory ,org-dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory ,html-dir
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-latex" :components ("org-copy-to-build" "org-compile-latex"))
        ("org-html"  :components ("org-compile-html" "org-copy-assets"))
        
        ("org" :components ("org-latex" "org-html"))

        ))   
