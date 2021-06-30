-- local lsp = require('lspconfig')
-- require("nvim-ale-diagnostic")

-- -- limit the diagnostic messages
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = false,
--     virtual_text = false,
--     signs = true,
--     update_in_insert = false,
--   }
-- )

-- local on_attach = function(client, bufnr)
--   -- Keybindings for LSPs
--   vim.fn.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true, silent = true})
--   vim.fn.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap = true, silent = true})
-- end


local on_attach = function(client, bufnr)
  require('completion').on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<leader>f','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      buf_set_keymap("n", "=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      buf_set_keymap("n", "=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end


  -- -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --     require('lspconfig').util.nvim_multiline_command [[
  --     :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --     augroup lsp_document_highlight
  --         autocmd!
  --         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --     ]]
  -- end
end




-- local map = function(type, key, value)
-- 	vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
-- end

-- local custom_attach = function(client)
-- 	print("LSP started.");
-- 	require'completion'.on_attach(client)

-- 	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
-- 	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
-- 	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
-- 	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
-- 	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- 	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
-- 	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- 	map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
-- 	map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
-- 	map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
-- 	map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
-- 	map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
-- 	map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
-- 	map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- 	map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
-- 	map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
-- end


-- lsp.pyls.setup{
--   on_attach=on_attach,
--   cmd = { "/home/e367212/.local/share/vim-lsp-settings/servers/pylsp-all/venv/bin/pylsp"},
-- }

-- -- cmd = { "/home/e367212/.local/share/vim-lsp-settings/servers/clangd/bin/clangd","--background-index"},
-- lsp.clangd.setup{
--   on_attach=on_attach,
--   cmd = { "/opt/tbs/bin/clangd","--background-index"},
-- }

-- Uncomment to execute the extension test mentioned above.
-- local function custom_codeAction_callback(_, _, action)
-- 	print(vim.inspect(action))
-- end

-- vim.lsp.callbacks['textDocument/codeAction'] = custom_codeAction_callback
--


-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "clangd")
  table.insert(servers, "sourcekit")
  table.insert(servers, "pyright-langserver")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "sourcekit" then
      config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
    end
    if server == "pyright-langserver" then
      config.filetypes = {"python"}; -- we don't want c and cpp!
    end
    if server == "clangd" then
      config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
