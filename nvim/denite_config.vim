" denite

" INTERFACE
call denite#custom#option('_', {
            \ 'prompt': 'λ:',
            \ 'empty': 0,
            \ 'winheight': 16,
            \ 'source_names': 'short',
            \ 'vertical_preview': 1,
            \ 'auto-accel': 1,
            \ 'auto-resume': 1,
            \ })

call denite#custom#option('list', {})

call denite#custom#option('mpc', {
            \ 'quit': 0,
            \ 'mode': 'normal',
            \ 'winheight': 20,
            \ })

" MATCHERS
" Default is 'matcher_fuzzy'
call denite#custom#source('tag', 'matchers', ['matcher_substring'])
if has('nvim') && &runtimepath =~# '\/cpsm'
    call denite#custom#source(
                \ 'buffer,file_mru,file_old,file_rec,grep,mpc,line',
                \ 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])
endif

" SORTERS
" Default is 'sorter_rank'
" call denite#custom#source('z', 'sorters', ['sorter_z'])

" CONVERTERS
" Default is none
call denite#custom#source(
            \ 'buffer,file_mru,file_old',
            \ 'converters', ['converter_relative_word'])

" FIND and GREP COMMANDS
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

if executable('ag')
    " The Silver Searcher
    call denite#custom#var('file_rec', 'command',
                \ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])


    " Setup ignore patterns in your .agignore file!
    " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage

    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts',
                \ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])

elseif executable('ack')
    " Ack command
    call denite#custom#var('grep', 'command', ['ack'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--match'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts',
                \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
                \ '--nopager', '--nocolor', '--nogroup', '--column'])
endif

" KEY MAPPINGS
let insert_mode_mappings = [
            \  ['jj', '<denite:enter_mode:normal>', 'noremap'],
            \  ['<Esc>', '<denite:enter_mode:normal>', 'noremap'],
            \  ['<C-N>', '<denite:assign_next_matched_text>', 'noremap'],
            \  ['<C-P>', '<denite:assign_previous_matched_text>', 'noremap'],
            \  ['<Up>', '<denite:assign_previous_text>', 'noremap'],
            \  ['<Down>', '<denite:assign_next_text>', 'noremap'],
            \  ['<C-Y>', '<denite:redraw>', 'noremap'],
            \ ]

let normal_mode_mappings = [
            \   ["'", '<denite:toggle_select_down>', 'noremap'],
            \   ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
            \   ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
            \   ['gg', '<denite:move_to_first_line>', 'noremap'],
            \   ['st', '<denite:do_action:tabopen>', 'noremap'],
            \   ['sg', '<denite:do_action:vsplit>', 'noremap'],
            \   ['sv', '<denite:do_action:split>', 'noremap'],
            \   ['sc', '<denite:quit>', 'noremap'],
            \   ['r', '<denite:redraw>', 'noremap'],
            \ ]

for m in insert_mode_mappings
    call denite#custom#map('insert', m[0], m[1], m[2])
endfor
for m in normal_mode_mappings
    call denite#custom#map('normal', m[0], m[1], m[2])
endfor

nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh<CR>
nnoremap <silent><LocalLeader>f :<C-u>Denite file_rec<CR>

nnoremap <silent> <C-p> :<C-u>Denite
            \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file_old -default-action=switch<CR>
nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec -default-action=cd<CR>
nnoremap <silent><LocalLeader>v :<C-u>Denite register -buffer-name=register<CR>
xnoremap <silent><LocalLeader>v :<C-u>Denite register -buffer-name=register -default-action=replace<CR>
nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list<CR>
nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list<CR>
nnoremap <silent><LocalLeader>n :<C-u>Denite dein<CR>
nnoremap <silent><LocalLeader>g :<C-u>Denite grep<CR>
nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file_point<CR>
nnoremap <silent><LocalLeader>o :<C-u>Denite outline<CR>
nnoremap <silent><LocalLeader>s :<C-u>Denite session -buffer-name=list<CR>
nnoremap <silent><expr> <LocalLeader>t &filetype == 'help' ? "g\<C-]>" :
            \ ":\<C-u>DeniteCursorWord -buffer-name=tag
            \  tag:include\<CR>"
nnoremap <silent><expr> <LocalLeader>p  &filetype == 'help' ?
            \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
nnoremap <silent><LocalLeader>m :<C-u>Denite mpc -buffer-name=mpc<CR>
nnoremap <silent><LocalLeader>/ :<C-u>Denite line<CR>
nnoremap <silent><LocalLeader>* :<C-u>DeniteCursorWord line<CR>
nnoremap <silent><LocalLeader>z :<C-u>Denite z<CR>
nnoremap <silent><LocalLeader>; :<C-u>Denite command command_history<CR>

" chemzqm/denite-git
nnoremap <silent> <Leader>gl :<C-u>Denite gitlog:all<CR>
nnoremap <silent> <Leader>gs :<C-u>Denite gitstatus<CR>
nnoremap <silent> <Leader>gc :<C-u>Denite gitbranch<CR>

" Open Denite with word under cursor or selection
nnoremap <silent> <Leader>gf :DeniteCursorWord file_rec<CR>
nnoremap <silent> <Leader>gg :DeniteCursorWord grep<CR>
vnoremap <silent> <Leader>gg
            \ :<C-u>call <SID>get_selection('/')<CR>
            \ :execute 'Denite grep:::'.@/<CR><CR>

function! s:get_selection(cmdtype)
    let temp = @s
    normal! gv"sy
    let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
    let @s = temp
endfunction "}}}
