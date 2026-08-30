vim9script

# =============================================================================
# Vim 9.1+ macOS — builtins first; minimal maintained plugins
# Langs: Java / JS / TS / Swift / C / C++ / Rust
# =============================================================================


#---------------------------------------------------------------------------
# bootstrap
#---------------------------------------------------------------------------
# enable builtin packages     
packadd! comment
packadd! cfilter
packadd! hlyank
packadd! matchit
packadd! editorconfig

# load vimdefaults config 
unlet! g:skip_defaults_vim
source $VIMRUNTIME/defaults.vim

g:mapleader = ' '
g:maplocalleader = '\'

# global vim config      
set mouse=                      # defaults enables mouse; keyboard-only
set ttimeoutlen=50              # defaults=100; snappier Esc + IME switch
set number 
set cursorline
set signcolumn=auto
set sidescrolloff=8
set hidden
set hlsearch
set ignorecase smartcase
set belloff=all
set shortmess+=c
set wildoptions=fuzzy,pum
set wildmode=noselect:lastused,full
set path=.,,**
set wildignore+=*/.git/*,*/node_modules/*,*/build/*,*/dist/*,*/target/*,*.o,*.class,*.swp
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent
set clipboard^=unnamed,unnamedplus
set completeopt=menuone,noselect,noinsert,popup
set splitbelow splitright
set laststatus=2               
set noshowmode
set updatetime=300
set timeoutlen=400
set foldenable
set foldmethod=indent      # 通用、无插件
set foldlevel=99
set foldlevelstart=99      # 打开文件时展开；需要再手动折
set foldnestmax=10
set foldcolumn=1           # 左侧 1 列显示折叠层级；不想要就 =0
set foldminlines=2         # 太短的块不折
set fillchars+=fold:·      # 折叠行填充（可选）
set undofile
&undodir = expand('~/.vim/undodir')
if !isdirectory(&undodir)
  mkdir(&undodir, 'p')
endif

set tags=./tags;,tags;          # upward search (;); defaults lack ;

# indent by filetype 
augroup LangIndent
  autocmd!
  autocmd FileType javascript,typescript,typescriptreact,javascriptreact,json,swift
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType java,c,cpp,objc,objcpp
        \ setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType make setlocal noexpandtab
  autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

# statusline 
def g:LspDiagStatus(): string
  try
    var c = lsp#lsp#ErrorCount()
    var e = get(c, 'Error', 0)
    var w = get(c, 'Warn', 0)
    if e == 0 && w == 0
      return ''
    endif
    return $' E:{e} W:{w}'
  catch
    return ''
  endtry
enddef
&statusline = ' %{mode()} | %f%m%r%h%w %= %{&filetype} | %l:%c/%L%{g:LspDiagStatus()} '

# ---------------------------------------------------------------------------
# files — netrw
# <Space>e  侧栏    <Space>E  全窗口
# ---------------------------------------------------------------------------
g:netrw_banner = 0
g:netrw_liststyle = 3
g:netrw_browse_split = 4
g:netrw_altv = 1
g:netrw_winsize = 22
nnoremap <Leader>e <Cmd>Lexplore<CR>
nnoremap <Leader>E <Cmd>Explore<CR>

# ---------------------------------------------------------------------------
# windows / buffers
# <C-h/j/k/l>  <Space>w  sv/sh/q  bd/bn/bp/<Tab>  <Space>/ 
# ---------------------------------------------------------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>w <C-w>w
nnoremap <Leader>sv <Cmd>vsplit<CR>
nnoremap <Leader>sh <Cmd>split<CR>
nnoremap <Leader>q <Cmd>close<CR>
nnoremap <Leader>bd <Cmd>bdelete<CR>
nnoremap <Leader>bn <Cmd>bnext<CR>
nnoremap <Leader>bp <Cmd>bprevious<CR>
nnoremap <Leader><Tab> <Cmd>bnext<CR>
nnoremap <Leader>/ <Cmd>nohlsearch<CR>
nnoremap ]q <Cmd>cnext<CR>
nnoremap [q <Cmd>cprev<CR>

# ---------------------------------------------------------------------------
# find — fzf + fzf.vim（pack/start 自动加载）
# ff 文件  fg 内容  fb buffer  fh 历史  fl 当前行  fc 命令  fF :find
# --------------------------------------------------------------------------- 
nnoremap <Leader>ff <Cmd>Files<CR>
nnoremap <Leader>fg <Cmd>Rg<CR>
nnoremap <Leader>fb <Cmd>Buffers<CR>
nnoremap <Leader>fh <Cmd>History<CR>
nnoremap <Leader>fl <Cmd>BLines<CR>
nnoremap <Leader>fc <Cmd>Commands<CR>
nnoremap <Leader>fF :find **/*

# ---------------------------------------------------------------------------
# motion — justinmk/vim-sneak
# s/S 双向跳    f/F/t/T 增强原生命令
# ---------------------------------------------------------------------------
g:sneak#use_ic_scs = 1
g:sneak#label = 1
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
xmap <leader>s <Plug>Sneak_s
xmap <leader>S <Plug>Sneak_S
omap <leader>s <Plug>Sneak_s
omap <leader>S <Plug>Sneak_S

# ---------------------------------------------------------------------------
# ime - chenqingze/smartim (macOS only)
# ---------------------------------------------------------------------------
g:smartim_default = 'com.apple.keylayout.ABC'

# ---------------------------------------------------------------------------
# edit — surround + repeat + visual-multi
# cs/ds/ys  tpope/vim-surround    .  tpope/vim-repeat
# <C-n>     mg979/vim-visual-multi
# gc/gcc    内置 comment
# ---------------------------------------------------------------------------
g:VM_maps = {}
g:VM_maps['Find Under']         = '<C-n>'
g:VM_maps['Find Subword Under'] = '<C-n>'
# surround + repeat: no extra maps

# ---------------------------------------------------------------------------
# run / debug — terminal + termdebug
# tt 终端  d/td 调试  b 断点  rs 停止
# ---------------------------------------------------------------------------
nnoremap <Leader>tt <Cmd>terminal<CR>
nnoremap <Leader>td <Cmd>Termdebug<CR>
nnoremap <Leader>d  <Cmd>Termdebug<CR>
nnoremap <Leader>b  <Cmd>Break<CR>
nnoremap <Leader>rs <Cmd>Stop<CR>
nnoremap <Leader>tg <Cmd>!ctags -R .<CR>
tnoremap <Esc> <C-\><C-n>

# ---------------------------------------------------------------------------
# lsp — yegappan/lsp
# gd/gD/gi/gy/gr/K  rn/ca/lf/o  [g ]g  xx  a(头↔源)
# ---------------------------------------------------------------------------
g:lsp_options = {
  autoComplete: true,
  autoHighlightDiags: true,
  showDiagWithVirtualText: true,
  showDiagInPopup: true,
  showSignature: true,
  completionMatcher: 'fuzzy',
  usePopupInCodeAction: true,
  ignoreMissingServer: true,
}
g:lsp_servers = [
  {
    name: 'clangd',
    filetype: ['c', 'cpp', 'objc', 'objcpp'],
    path: 'clangd',
    args: ['--background-index', '--clang-tidy'],
    rootSearch: ['compile_commands.json', 'compile_flags.txt', '.git/'],
  },
  {
    name: 'typescriptlang',
    filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
    path: 'typescript-language-server',
    args: ['--stdio'],
    rootSearch: ['package.json', 'tsconfig.json', 'jsconfig.json', '.git/'],
  },
  {
    name: 'jdtls',
    filetype: ['java'],
    path: 'jdtls',
    args: [],
    rootSearch: ['pom.xml', 'build.gradle', 'build.gradle.kts', '.git/'],
    syncInit: true,
  },
  {
    name: 'sourcekit',
    filetype: ['swift'],
    path: 'sourcekit-lsp',
    args: [],
    rootSearch: ['Package.swift', '*.xcodeproj/', '*.xcworkspace/', '.git/'],
  },
  {
    name: 'rustanalyzer',
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true,
    rootSearch: ['Cargo.toml', 'Cargo.lock', 'rust-project.json', '.git/'],
    workspaceConfig: {
      'rust-analyzer': {
        cargo: { allFeatures: true },
        check: { command: 'clippy' },
        inlayHints: {
          typeHints: { enable: true },
          parameterHints: { enable: true },
        },
      },
    },
  },
]

packadd lsp

def OnLspAttached()
  setlocal tagfunc=lsp#lsp#TagFunc
  setlocal formatexpr=lsp#lsp#FormatExpr()
  nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
  nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
  nnoremap <buffer> gy <Cmd>LspGotoTypeDef<CR>
  nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
  nnoremap <buffer> K  <Cmd>LspHover<CR>
  nnoremap <buffer> <Leader>rn <Cmd>LspRename<CR>
  nnoremap <buffer> <Leader>ca <Cmd>LspCodeAction<CR>
  nnoremap <buffer> <Leader>lf <Cmd>LspFormat<CR>
  nnoremap <buffer> <Leader>o  <Cmd>LspOutline<CR>
  nnoremap <buffer> [g <Cmd>LspDiag prev<CR>
  nnoremap <buffer> ]g <Cmd>LspDiag next<CR>
  nnoremap <buffer> <Leader>xx <Cmd>LspDiag show<CR>
  nnoremap <buffer> <Leader>a <Cmd>LspSwitchSourceHeader<CR>
enddef

augroup LspMaps
  autocmd!
  autocmd User LspAttached OnLspAttached()
augroup END

# ---------------------------------------------------------------------------
# Colorscheme 
# ---------------------------------------------------------------------------
if has('termguicolors')
  set termguicolors
endif
set background=dark
syntax enable
colorscheme habamax

