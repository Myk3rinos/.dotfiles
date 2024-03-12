return {
  "mfussenegger/nvim-dap",  -- Debug Adapter Protocol
  dependencies = {
    -- "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    -- "Pocco81/DAPInstall.nvim",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dap-go").setup()
    require("dapui").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set('n', "<leader>dc", dap.continue, {})
    -- vim.keymap.nnoremap({ "<leader>dc", function()
    --   dap.continue()
    -- end, { noremap = true, silent = true })
    -- require("dapui").setup()
  end,
}
