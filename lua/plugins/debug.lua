return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        dependencies = {
            -- UI panels for dap (variables, breakpoints, call stack, watches)
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "folke/neodev.nvim",
            -- Virtual text showing variable values inline
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Wire js-debug-adapter directly (Mason installs pre-built source, no nvim-dap-vscode-js needed)
            local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
            for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node", "chrome" }) do
                dap.adapters[adapter] = {
                    type = "server",
                    host = "localhost",
                    port = "${port}",
                    executable = {
                        command = "node",
                        args = { js_debug, "${port}" },
                    },
                }
            end

            -- Firefox adapter (install via :MasonInstall firefox-debug-adapter)
            dap.adapters.firefox = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
                options = { detached = false },
            }

            -- Configurations for JS/TS file types
            for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
                dap.configurations[ft] = {
                    {
                        -- WSL2: in Firefox open about:config, set devtools.debugger.remote-enabled = true
                        -- then open DevTools (F12) > three-dot menu > Remote Debugging, it listens on 6000
                        -- Windows host IP for WSL2 NAT — replace with "localhost" after enabling mirrored networking
                        type = "firefox",
                        request = "attach",
                        name = "Attach to Firefox (port 6000)",
                        host = "localhost",
                        port = 6000,
                        url = "http://localhost:9000",
                        webRoot = "${workspaceFolder}/src",
                        reAttach = true,
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file (Node)",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach to Node process",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Launch chrome",
                        url = "http://localhost:9000",
                        webRoot = "${workspaceFolder}",
                        sourceMaps = true,
                        sourceMapPathOverrides = {
                            ["webpack://react-ui/*"] = "${webRoot}/*"
                        }
                    }
                }
            end

            -- Auto-open/close the UI when a session starts/ends
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            require("dapui").setup()
            require("nvim-dap-virtual-text").setup()

            local k = vim.keymap.set
            k("n", "<leader>db",  dap.toggle_breakpoint,                          { desc = "Toggle breakpoint" })
            k("n", "<leader>dB",  function()
                dap.set_breakpoint(vim.fn.input("Condition: "))
            end,                                                                   { desc = "Conditional breakpoint" })
            k("n", "<leader>dc",  dap.continue,                                   { desc = "Continue / Start" })
            k("n", "<leader>dn",  dap.step_over,                                  { desc = "Step over" })
            k("n", "<leader>di",  dap.step_into,                                  { desc = "Step into" })
            k("n", "<leader>do",  dap.step_out,                                   { desc = "Step out" })
            k("n", "<leader>dr",  dap.repl.open,                                  { desc = "Open REPL" })
            k("n", "<leader>dl",  dap.run_last,                                   { desc = "Re-run last session" })
            k("n", "<leader>du",  dapui.toggle,                                   { desc = "Toggle DAP UI" })
            k("n", "<leader>dx",  dap.terminate,                                  { desc = "Terminate session" })
        end,
    },
}
