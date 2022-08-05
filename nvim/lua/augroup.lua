require('util')
local vimrcAutoCreatefile = vim.api.nvim_create_augroup("vimrcAutoCreatefile", { clear = true })
local memodir = os.getenv("MEMO_DIRECTORY")
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern =  memodir .. '*',
    group = vimrcAutoCreatefile,
    callback = function()
        vim.opt_local.path:append(memodir .. '/**')
        vim.opt.suffixesadd:append('.md')
        local function open_file_or_create_new()
            local path = vim.fn.expand('<cfile>')
            if vim.fn.enpty(path) then
                return
            end
            try_catch{
                try = function()
                    vim.cmd([[exe 'norm!gf']])
                end,
                catch = function(error)
                    print('New File.')
                    new_path= vim.fn.fnamemodify(vim.fn.expand('%:p:h'),'/' .. path , ':p')
                    if not(vim.fn.empty(vim.fn.fnamemodify(new_path,':e'))) then
                        return vim.fn.execute('edit '.. new_path)
                    end
                end
                }
            suffixes = vim.fn.split(vim.opt.suffixesadd,',')

            for i,suffix in ipairs(suffixes) do
                if vim.fn.filereadable(new_path.suffix) then
                    return vim.fn.execute('edit ' .. new_path .. suffix)
                end
            end

            return vim.fn.execute('edit '.. new_path .. suffixes[0])
        end
        vim.keymap.set("n","gf",open_file_or_create_new,{ noremap = true })
    end
})

-- 保存時に存在しないディレクトリを作成
local vimrc_auto_mkdir = vim.api.nvim_create_augroup("vimrc-auto-mkdir", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
{
    group = vimrc_auto_mkdir,
    command = [[
  call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
    ]]
})

-- 末尾の空白削除
local trim_space = vim.api.nvim_create_augroup("trim-space", { clear = true })
vim.api.nvim_create_autocmd(   "FileType" ,
{
    group = trim_space,
    pattern = {"go","sql","python","vim","sh"},
    command = [[autocmd BufWritePre * :%s/\s\+$//ge]]
})

--ファイルをひらいたとき最後にカーソルがあった場所に移動
local restore_cursor = vim.api.nvim_create_augroup("restore-cursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost" ,
{
    group = restore_cursor,
    pattern = "*",
    command = [[if line("'\"") >= 1 && line("'\"") <= line("$")  |   exe "normal! g`\""  | endif]]
})

vim.api.nvim_create_autocmd("BufWinEnter" ,
{
    group = restore_cursor,
    pattern = "*",
    command = [[if empty(&buftype) && line('.') > winheight(0) / 3 * 2 | execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6) | endif]]
})
