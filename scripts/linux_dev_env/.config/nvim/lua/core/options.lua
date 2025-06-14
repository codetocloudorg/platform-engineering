local vim = vim
local opt = vim.opt

-- Folding

opt.foldenable = false

opt.foldmethod = "manual"

opt.foldlevelstart = 99

-- Completion

opt.completeopt = "menuone,noinsert,noselect"

-- Interface

opt.scrolloff = 2

opt.wrap = false

opt.signcolumn = "yes"

opt.relativenumber = true

opt.number = true

opt.splitright = true

opt.splitbelow = true

-- History and files

opt.undofile = true

-- Indentation and tabs

opt.shiftwidth = 4

opt.softtabstop = 4

opt.tabstop = 4

opt.expandtab = true

-- Search

opt.ignorecase = true

opt.smartcase = true

opt.wildmode = "list:longest"

opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"

-- Appearance

opt.vb = true

opt.textwidth = 80

opt.colorcolumn = "80"

opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

-- Clipboard

opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Other settings

opt.shortmess = "WIcCFS"

-- Diff settings

opt.diffopt:append("iwhite")

opt.diffopt:append("algorithm:histogram")

opt.diffopt:append("indent-heuristic")
