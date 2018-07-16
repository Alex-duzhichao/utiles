let g:proj_path = ''
let g:proj_file = ''

let g:remote_user = 'root'
let g:remote_addr = '119.28.188.108'
let g:remote_port = 22
let g:remote_dir = '~/rsync_dir/'
let g:remote_identity_file = 'C:\Users\alexzcdu\Desktop\zip_file\sshKey\id_rsa'
let g:remote_proxy = ''
let g:remote_callback = ''

let g:cscopes_options =
            \{
            \ 'ExcludeBoost': 1,
            \ 'ExcludeVender': 1,
            \ 'ExcludeModules': 1
            \}

let g:zip_path = ''
let g:zip_exclude = ''
"E.g. "'*mix_api_setmgn*' '*probuf_data*'"


let g:proj_path = substitute(g:proj_path, '\\$', '', 'g')
let g:proj_file = substitute(g:proj_file, '^\\', '', 'g')
let g:proj_type = 'cpp'
if g:proj_file =~# '.*\.(h|hpp|c|cpp)$'
    let g:proj_type = 'cpp'
elseif g:proj_file =~# ".*\.go$"
    let g:proj_type = 'go'
elseif g:proj_file =~# ".*\.js$"
    let g:proj_type = 'js'
elseif g:proj_file =~# ".*\.php$"
    let g:proj_type = 'php'
elseif g:proj_file =~# ".*\.py$"
    let g:proj_type = 'python'
endif

if(empty(g:zip_path))
    let g:zip_path = g:proj_path
endif

execute ":cd ".g:proj_path
execute ":e ".g:proj_file
