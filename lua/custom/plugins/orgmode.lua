return {
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
    'lukas-reineke/headlines.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      config = true,
    },
  },
  {
    'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup {
        -- stuff can here
      }
    end,
  },
  {
    'chipsenkbeil/org-roam.nvim',
    tag = '0.1.0',
    dependencies = {
      {
        'nvim-orgmode/orgmode',
        --    tag = "0.3.4",
      },
    },
    config = function()
      require('org-roam').setup {
        directory = '~/org_roam_files',
        -- optional
        org_files = {
          '~/orgfiles/**/*',
          --  "~/some/folder/*.org",
          --  "~/a/single/org_file.org",
        },
      }
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
        org_capture_templates = {
          a = {
            description = 'Agenda item',
            template = '* %?\nSCHEDULED: %^{Scheduled date}t',
            target = '~/orgfiles/calendar.org',
            headline = 'one-time',
          },
          e = {
            description = 'Event',
            subtemplates = {
              r = {
                description = 'recurring',
                template = '** %?\n %T',
                target = '~/orgfiles/calendar.org',
                headline = 'recurring',
              },
              o = {
                description = 'one-time',
                template = '** %?\n %T',
                target = '~/orgfiles/calendar.org',
                headline = 'one-time',
              },
            },
          },
        },
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
