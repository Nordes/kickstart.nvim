-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    -- https://github.com/toppair/peek.nvim
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup {
        app = 'Microsoft Edge', -- 'webview' | 'browser' | etc.
        theme = 'light', -- dark | light
      }
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
      if vim.bo.filetype == 'markdown' then
        require('which-key').add {
          { '<leader>p', group = '[p]eek (Markdown)' },
        }
        vim.keymap.set('n', '<leader>po', require('peek').open, { desc = 'Peek [o]pen' })
        vim.keymap.set('n', '<leader>pc', require('peek').close, { desc = 'Peek [c]lose' })
      end
    end,
  },
  {
    'nvim-orgmode/telescope-orgmode.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-orgmode/orgmode',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension 'orgmode'

      vim.keymap.set('n', '<leader>r', require('telescope').extensions.orgmode.refile_heading, { desc = '[R]efile heading' })
      vim.keymap.set('n', '<leader>so', require('telescope').extensions.orgmode.search_headings, { desc = '[S]earch [O]rg-Heading' })
      vim.keymap.set('n', '<leader>li', require('telescope').extensions.orgmode.insert_link, { desc = '[I]nsert Link' })
    end,
  },
  {
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = { border = true },
      indent = { enabled = true },
    },
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
        mappings = {
          org = {
            org_toggle_checkbox = '<leader>o\\',
          },
        },
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        ignore_install = { 'org' },
      }
    end,
  },
}
