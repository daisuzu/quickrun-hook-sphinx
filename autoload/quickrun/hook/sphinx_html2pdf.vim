let s:save_cpo = &cpo
set cpo&vim

let s:hook = {
            \ 'config': {
            \     'enable': 0,
            \     'options': []
            \     }
            \ }

function! s:hook.on_success(session, context)
    if a:session.config.cmdopt != 'singlehtml'
        return
    endif

    if !executable('wkhtmltopdf')
        echomsg 'Needs wkhtmltopdf.'
        return
    endif

    let path = fnamemodify(a:session.config.srcfile, ':p:h')
    let file = a:session.config.cmdopt == 'singlehtml' ? 'index' : fnamemodify(a:session.config.srcfile, ':t:r')
    let file .= '.html'
    let doc_path = expand(path . '/_build/' . a:session.config.cmdopt . '/' . file)

    let opt = ''
    if len(self.config.options)
        let opt = join(self.config.options, ' ')
    endif
    call system('wkhtmltopdf ' . opt . ' ' . shellescape(doc_path) . ' ' . shellescape(fnamemodify(doc_path, ':p:r') . '.pdf'))
    echomsg 'wkhtmltopdf ' . opt . shellescape(doc_path) . ' ' . shellescape(fnamemodify(doc_path, ':p:r') . '.pdf')

endfunction

function! quickrun#hook#sphinx_html2pdf#new()
    return s:hook
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
