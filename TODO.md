# Neovim todolist
## Done
 - [x] LSP trouble
 - [x] Packer Compile autocommand
 - [x] TrueZen
 - [x] Indent blankline
 - [x] Statusline middle and right components
 - [x] Check the telescope-fzy-native configuration
 - [x] Neogit - NvimTree conflict
 - [x] Symbols outline
    - [x] Look into the issues with this not behaving as expected
 - [x] Replace kommentary with [comment.nvim](https://github.com/numToStr/Comment.nvim)
 - [x] Install and configure [Telescope Symbols](https://github.com/nvim-telescope/telescope-symbols.nvim)
 - [x] Get borders working on Diagnostics popups, see this [reddit thread](https://www.reddit.com/r/neovim/comments/ovbje7/comment/h789qdh/?utm_source=share&utm_medium=web2x&context=3)
 - [x] tree-sitter `foldexpr` see `:h nvim_treesitter#foldexpr()`
 - [x] tree-sitter `statsline` component see `:h nvim_treesitter#statsline()`
 - [x] Make neovim config reloadable
 - [x] Try [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) again
 - [x] Properly understand how removing an autocommand works
    - see [this](https://learnvimscriptthehardway.stevelosh.com/chapters/14.html)
 - [x] Properly configure [dap-ui](https://github.com/rcarriga/nvim-dap-ui)
 - [x] Install [nvim-notify](https://github.com/rcarriga/nvim-notify)
 - [x] Refactor Lsp configuration into smaller modules
 - [x] Investigate [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)
    - see [author's config](https://github.com/williamboman/nvim-config/blob/main/lua/wb/lsp/init.lua)
 - [x] Investigate [vim-ultest](https://github.com/rcarriga/vim-ultest)
 - [x] Use telescope's file browser and the cursor theme to make a local directory browser

## In progress

## Blocked
 - [ ] Orgmode
    - [ ] Possibly use Neorg instead
    - [x] Install [Orgmode.nvim](https://github.com/kristijanhusak/orgmode.nvim/tree/tree-sitter)
    - [x] Set up the [tree-sitter grammar](https://github.com/milisims/tree-sitter-org)
    - [ ] Correctly configure it
    - [ ] Figure out how to integrate sniprun with the codeblocks
 - [ ] Telescope frecency workspaces
    - [x] Check configuration
    - [ ] Pull down and test plugin locally
 - [ ] DenoLS
    - [x] Install DenoLS
    - [ ] Look into getting it to work with Node projects
 - [ ] Colourscheme
    - [x] Diagnostics highlights background
    - [x] Generate alacritty colour scheme from lush
    - [x] Statusline colours
    - [ ] Auto-switching
    - [ ] Light theme refresh/update

## Backlog
 - [ ] Look into [rest.nvim](https://github.com/NTBBloodbath/rest.nvim)
 - [ ] Install [sniprun](https://github.com/michaelb/sniprun)
 - [ ] Get vim-ultest to run typescript mocha test files
    - [ ] This requires configuration of the underlying [vim-test](https://github.com/vim-test/vim-test/issues/209)

## Review
 - [ ] Install and configure [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
    - Looks as if this would be early adoption, revisit this later
 - [ ] Auto-documenting via [nvim-tree-docs](https://github.com/nvim-treesitter/nvim-tree-docs)
---
 - [ ] Figure out how to get Sonarlint to play nicely with Neovim, possibly via the [language server](https://github.com/SonarSource/sonarlint-language-server)

---
 - [ ] Move `typescript.ts` to an org file from the system tests repo

# Tmux todolist
 - [x] Simplify the Statusline

# Git todolist
 - [ ] Investigate [git bare repositories](https://www.atlassian.com/git/tutorials/dotfiles)
