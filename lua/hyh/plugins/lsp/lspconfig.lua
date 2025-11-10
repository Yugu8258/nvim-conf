return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                local opts = { buffer = ev.buf, silent = true }

                -- Keymaps
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", function()
                    vim.lsp.buf.code_action()
                end, opts)

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
            end,
        })

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        }

        -- Set diagnostic config
        vim.diagnostic.config({
            signs = {
                text = signs,
            },
            virtual_text = true,
            underline = true,
            update_in_insert = false,
        })

        -- Setup servers
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Global LSP settings (applied to all servers)
        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        -- Configure and enable LSP servers
        -- lua_ls
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
        vim.lsp.enable("lua_ls")

        -- emmet_language_server
        vim.lsp.config("emmet_language_server", {
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            init_options = {
                includeLanguages = {},
                excludeLanguages = {},
                extensionsPath = {},
                preferences = {},
                showAbbreviationSuggestions = true,
                showExpandedAbbreviation = "always",
                showSuggestionsAsSnippets = false,
                syntaxProfiles = {},
                variables = {},
            },
        })
        vim.lsp.enable("emmet_language_server")

        -- emmet_ls
        vim.lsp.config("emmet_ls", {
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })
        vim.lsp.enable("emmet_ls")

        -- ts_ls (TypeScript/JavaScript)
        vim.lsp.config("ts_ls", {
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
            single_file_support = true,
            init_options = {
                preferences = {
                    includeCompletionsForModuleExports = true,
                    includeCompletionsForImportStatements = true,
                },
            },
        })
        vim.lsp.enable("ts_ls")

        -- gopls
        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })
        vim.lsp.enable("gopls")

        vim.lsp.config("clangd", {
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

            cmd = {
                "/usr/bin/clangd",
                "--background-index",
                "--clang-tidy",
                "--completion-style=detailed",
                "--cross-file-rename",
                "--header-insertion=iwyu",
                "--pch-storage=memory",
                "--enable-config",
                "--offset-encoding=utf-16",
                "--fallback-style=llvm",
            },

            init_options = {
                compilationDatabasePath = "build",
                fallbackFlags = {
                    "-std=c++20",
                    "-std=c17",
                    "-Wall",
                    "-Wextra",
                },
            },
        })
        vim.lsp.enable("clangd")

        vim.lsp.config("rust_analyzer", {
            filetypes = { "rust" },

            cmd = {
                "rust-analyzer",
            },

            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        buildScripts = { enable = true },
                        features = "all",
                        runBuildScripts = true,
                    },

                    checkOnSave = {
                        enable = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    formatting = {
                        enable = true,
                        formatter = {
                            command = "rustfmt",
                        },
                    },

                    analyses = {
                        unusedParams = true,
                        unusedExternCrate = true,
                        unusedImport = true,
                        unusedMut = true,
                        unreachableCode = true,
                    },
                    completion = {
                        autoimport = { enable = true },
                        postfix = { enable = true },
                    },

                    procMacro = {
                        enable = true,
                        ignored = {},
                    },
                    workspace = {
                        symbol = {
                            search = {
                                kind = "all_symbols",
                                limit = 100,
                            },
                        },
                    },
                },
            },
        })
        vim.lsp.enable("rust_analyzer")

        vim.lsp.config("gopls", {
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            cmd = { "gopls" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        unusedwrite = true,
                        fieldalignment = true,
                        nilness = true,
                        shadow = true,
                        unusedvariable = true,
                    },
                    formatting = {
                        style = "goimports",
                    },
                    modules = {
                        autoDetect = true,
                    },
                    staticcheck = true,
                    experimentalPostfixCompletions = true,
                },
            },
        })
        vim.lsp.enable("gopls")

        vim.lsp.config("jdtls", {
            filetypes = { "java" },
            cmd = {
                "jdtls",
                "-data",
                vim.fn.expand("~/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")),
            },
            settings = {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-21",
                                path = "/usr/lib/jvm/java-21-openjdk/",
                            },
                        },
                    },
                    format = {
                        settings = {
                            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = "fernflower" },
                    maven = {
                        downloadSources = true,
                    },
                    imports = {
                        gradle = {
                            enabled = true,
                        },
                        maven = {
                            enabled = true,
                        },
                    },
                },
            },
        })
        vim.lsp.enable("jdtls")

        vim.lsp.config("zls", {
            filetypes = { "zig", "zir" },
            cmd = { "zls" },
            settings = {
                zls = {
                    build_runner = "zig build",
                    enable_format_on_save = true,
                    formatter = {
                        indent_width = 4,
                        line_endings = "lf",
                    },
                    warn_style = true,
                    enable_snippets = true,
                    zig_exe_path = "zig",
                    zig_lib_path = "",
                },
            },
        })
        vim.lsp.enable("zls")

        vim.lsp.config("cmake", {
            filetypes = { "cmake" },
            cmd = { "cmake-language-server" },
            init_options = {
                buildDirectory = "build",
            },
            settings = {
                cmake = {
                    buildDirectory = "${workspaceFolder}/build",
                    buildType = "Debug",
                    cmakePath = "cmake",
                    configureArgs = {
                        "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
                        "-DCMAKE_BUILD_TYPE=Debug"
                    },
                    buildArgs = {
                        "--parallel",
                    },
                    installPrefix = "${workspaceFolder}/install",
                    generator = "Unix Makefiles",
                }
            }
        })
        vim.lsp.enable("cmake")

    end,
}

