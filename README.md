quickrun-hook-sphinx
====================
quickrunhooksphinx is a quickrun hook plugin.

This plugin provides:

    * open html
    * convert html to pdf(singlehtml only)


Example Settings
----------------
Add g:quickrun_config['rst'] in vimrc as following.

    let g:quickrun_config['rst'] = {
                \ 'command': 'make',
                \ 'hook/sphinx_open/enable': 1,
                \ 'hook/sphinx_html2pdf/enable': 1,
                \ 'cmdopt': 'singlehtml',
                \ 'exec': '%c %o'
                \ }
