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
