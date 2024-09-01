return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      local function get_project_root()
        local cwd = vim.fn.getcwd()
        local root_files = { 'package.json', 'tsconfig.json', '.git' }

        for _, file in ipairs(root_files) do
          local found = vim.fn.findfile(file, cwd .. ';')
          if found ~= '' then
            return vim.fn.fnamemodify(found, ':p:h')
          end
        end

        return cwd
      end

      -- Node.js adapter configuration
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = {
          require('mason-registry')
          .get_package("js-debug-adapter")
          :get_install_path() .. "/js-debug/src/dapDebugServer.js"
        },
      }

      -- Configuration for launching Node.js
      dap.configurations.typescript = {
        {
          type = 'node2',
          request = 'launch',
          name = 'Launch TypeScript Program',
          program = '${workspaceFolder}/src/index.ts', -- Point to src/index.ts
          cwd = get_project_root(),                    -- Automatically set the project root as cwd
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          runtimeExecutable = 'node',
          runtimeArgs = { '-r', 'ts-node/register', '--project', '${workspaceFolder}/tsconfig.json' }, -- Use the specific tsconfig.json
          logLevel = 'debug',
          skipFiles = { '<node_internals>/**' },
        },
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach to Process',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          skipFiles = { '<node_internals>/**' },
        },
      }
    end
  },

  -- nvim-dap-ui for better debugging UI
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
      local dap, dapui = require('dap'), require('dapui')

      -- Automatically open dap-ui when debugging starts
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end
  },
}
