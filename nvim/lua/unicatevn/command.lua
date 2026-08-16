vim.api.nvim_create_user_command("ReplaceLeetArray", function ()
  vim.cmd('s/\\[/{/g')
  vim.cmd('s/\\]/}/g')
end, {})
