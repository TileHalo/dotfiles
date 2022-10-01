setlocal formatprg=prettier\ --no-config\ --stdin\ --parser=babel
setlocal makeprg=eslint\ --format\ compact

setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

setlocal path=.,front/src/js/,src/
setlocal suffixesadd+=.js
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
