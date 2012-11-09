let s:save_cpo = &cpo
set cpo&vim

let s:hook = {
            \ 'config': {
            \     'enable': 0
            \     }
            \ }

function! s:hook.on_success(session, context)
    if a:session.config.cmdopt !~# 'html'
        return
    endif

    let path = fnamemodify(a:session.config.srcfile, ':p:h')
    let file = a:session.config.cmdopt == 'singlehtml' ? 'index' : fnamemodify(a:session.config.srcfile, ':t:r')
    let file .= '.html'
    let doc_path = expand(path . '/_build/' . a:session.config.cmdopt . '/' . file)

    try
        call openbrowser#load()
    catch /E117/
        echomsg 'Needs open-browser.vim.'
        return
    endtry

    let save = g:openbrowser_open_filepath_in_vim
    let g:openbrowser_open_filepath_in_vim = 0
    call openbrowser#open(doc_path)
    let g:openbrowser_open_filepath_in_vim = save
endfunction

function! quickrun#hook#sphinx_open#new()
    return s:hook
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
