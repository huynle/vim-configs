-- not loading correctly just yet
--
--
--
require('telescope').load_extension('dap')
-- require('dap-python').setup('$(which python)')
require('dap-python').setup('/root/.pyenv/shims/python')
require('dap-python').test_runner = 'pytest'

