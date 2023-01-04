if _G.plugin_loaded('mason.nvim') then
  require('mason').setup {}
end

if _G.plugin_loaded('mason-lspconfig.nvim') then
  require('mason-lspconfig').setup {
    ensure_installed = {
      'ansiblels',
      'arduino_language_server',
      'jedi_language_server',
      'rust_analyzer',
      'sumneko_lua',
      'texlab',
    },
  }
end
