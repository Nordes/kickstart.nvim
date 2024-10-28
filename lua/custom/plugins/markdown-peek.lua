return {
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
}
