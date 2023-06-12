local opt = vim.opt

opt.conceallevel = 2                      -- Conceal some markers

-- Enable spellchecking for German
vim.cmd [[
  setlocal spell spelllang=de
  set spell
]]
