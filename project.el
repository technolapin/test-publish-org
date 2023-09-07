(require 'ox-publish) 


(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        ))

(setq org-publish-project-alist
      '(

("org-compile-html"
 :base-directory "~/Documents/test-publish-org/org/"
 :base-extension "org"
 :publishing-directory "~/Documents/test-publish-org/html/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4
 :auto-preamble t
 )

("org-copy-to-build"
 :base-directory "~/Documents/test-publish-org/org/"
 :base-extension any
 :publishing-directory "~/Documents/test-publish-org/build/"
 :recursive t
 :publishing-function org-publish-attachment
 )

("org-compile-latex"
 :base-directory "~/Documents/test-publish-org/build/"
 :base-extension "org"
 :publishing-directory "~/Documents/test-publish-org/pdf/"
 :recursive t
 :publishing-function org-latex-publish-to-pdf
 :headline-levels 4
 :auto-preamble t
 )

("org-copy-assets"
 :base-directory "~/Documents/test-publish-org/org/"
 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
 :publishing-directory "~/Documents/test-publish-org/html/"
 :recursive t
 :publishing-function org-publish-attachment
 )

 ("org-latex" :components ("org-copy-to-build" "org-compile-latex"))
 ("org-html"  :components ("org-compile-html" "org-copy-assets"))
 
 ("org" :components ("org-latex" "org-html"))

))   
