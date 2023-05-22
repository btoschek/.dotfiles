require('bufferline').setup {
  options = {
    custom_filter = function(buf_number, buf_numbers)
      if vim.fn.bufname(buf_number):find('^oil://') == nil then
        return true
      end
    end,
  },
}
