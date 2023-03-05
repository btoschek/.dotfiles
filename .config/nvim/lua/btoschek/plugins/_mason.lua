require('mason').setup {}

require('mason-lspconfig').setup {
  ensure_installed = {
    'ansiblels',
    'arduino_language_server',
    'jedi_language_server',
    'rust_analyzer',
    'lua_ls',
    'texlab',
  },
}
