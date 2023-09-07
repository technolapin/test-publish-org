(require 'ox-publish) 


(setq org-latex-pdf-process
      '("echo %O >> log.log && pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        ))

(setq org-publish-project-alist
      '(

("org-notes"
 :base-directory "~/Documents/org-test/org/"
 :base-extension "org"
 :publishing-directory "~/Documents/org-test/html/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4
 :auto-preamble t
 )
("org-latex"
 :base-directory "~/Documents/org-test/org/"
 :base-extension "org"
 :publishing-directory "~/Documents/org-test/pdf/"
 :recursive t
 :publishing-function org-latex-publish-to-pdf
 :headline-levels 4
 :auto-preamble t
 )

("org-static"
 :base-directory "~/Documents/org-test/org/"
 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
 :publishing-directory "~/Documents/org-test/html/"
 :recursive t
 :publishing-function org-publish-attachment
 )

("org" :components ("org-latex" "org-notes" "org-static"))

))   
