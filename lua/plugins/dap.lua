return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			dap.set_log_level("DEBUG")

			local function get_project_root()
				local cwd = vim.fn.getcwd()
				local root_files = { "package.json", "tsconfig.json", ".git" }

				for _, file in ipairs(root_files) do
					local found = vim.fn.findfile(file, cwd .. ";")
					if found ~= "" then
						return vim.fn.fnamemodify(found, ":p:h")
					end
				end

				return cwd
			end

			-- Node.js adapter configuration
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = 9229,
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path()
							.. "/js-debug/src/dapDebugServer.js",
						"9229",
					},
				},
			}

			dap.adapters["chrome"] = {
				type = "executable",
				command = "node",
				args = {
					require("mason-registry").get_package("chrome-debug-adapter"):get_install_path()
						.. "/out/src/chromeDebug.js",
				},
			}

			-- Configuration for launching Node.js
			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch TypeScript Program",
					program = function()
						return "${file}"
					end, -- Point to src/index.ts
					cwd = get_project_root(), -- Automatically set the project root as cwd
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					runtimeExecutable = "node",
					runtimeArgs = { "-r", "ts-node/register", "--project", "${workspaceFolder}/tsconfig.json" }, -- Use the specific tsconfig.json
					logLevel = "debug",
					skipFiles = { "<node_internals>/**" },
				},
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = get_project_root(), -- Automatically set the project root as cwd
					name = "Attach Chrome",
					url = "http://localhost:5173",
					sourceMaps = true,
					protocol = "inspector",
					logLevel = "debug",
					webRoot = "${workspaceFolder}",
					port = 9222,
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to Process",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					skipFiles = { "<node_internals>/**" },
				},
			}
		end,
	},

	-- nvim-dap-ui for better debugging UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")

			-- Automatically open dap-ui when debugging starts
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
