-- Neo-tree file explorer customization - Remove search bar completely
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- Hide the header/filter bar completely
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    enable_normal_mode_for_inputs = false,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    -- Hide the filter message/input display
    hide_root_node = true,
    retain_hidden_root_indent = false,
    
    -- Keep search functionality but hide the visual search bar
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
        },
      },
      follow_current_file = {
        enabled = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = "disabled",
      use_libuv_file_watcher = true,
      -- Keep search functionality but hide the UI
      find_by_full_path_words = true,
      search_limit = 50,
      never_show_by_pattern = {
        "*.meta",
        "*/src/*/tsconfig.json",
      },
      -- Configure finder command (fd is installed via homebrew)
      find_command = "/opt/homebrew/bin/fd",
      find_args = {
        "/opt/homebrew/bin/fd",
        "--type", "f",
        "--hidden",
        "--follow",
        "--exclude", ".git",
        "--exclude", "node_modules",
      },
      -- Custom components to hide filter display
      components = {
        name = function(config, node, state)
          local text = node.name
          local highlight = "NeoTreeFileName"
          if node.type == "directory" then
            highlight = "NeoTreeDirectoryName"
          end
          return {
            text = text,
            highlight = highlight,
          }
        end,
        -- Remove the filter component to hide the search bar
      },
    },
    
    -- Disable sources except filesystem
    sources = { "filesystem" },
    source_selector = {
      winbar = false,
      statusline = false,
      show_scrolled_off_parent_node = false,
      content_layout = "start",
      tabs_layout = "equal",
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
      },
    },
    
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      -- Hide the filter/search display bar at the top
      diagnostics = {
        symbols = {
          hint = "󰌶",
          info = "",
          warn = "",
          error = "",
        },
        highlights = {
          hint = "DiagnosticSignHint",
          info = "DiagnosticSignInfo",
          warn = "DiagnosticSignWarn",
          error = "DiagnosticSignError",
        },
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "*",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added     = "",
          modified  = "",
          deleted   = "✖",
          renamed   = "󰁕",
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
      -- Remove file_size component to keep it clean
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
      created = {
        enabled = false,
      },
      symlink_target = {
        enabled = false,
      },
    },
    
    window = {
      position = "left",
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      -- Ensure proper buffer settings to avoid 'modifiable' issues
      auto_expand_width = false,
      mappings = {
        -- RE-ENABLE SEARCH FUNCTIONALITY (but hide the visual bar)
        ["/"] = "fuzzy_finder",
        ["#"] = "fuzzy_finder_directory", 
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["H"] = "toggle_hidden",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        -- Keep useful mappings
        ["<space>"] = { 
          "toggle_node", 
          nowait = false,
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["a"] = { 
          "add",
          config = {
            show_path = "none"
          }
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = {
          "copy_to_clipboard",
          config = {
            show_path = "relative"
          }
        },
        ["x"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local filename = vim.fn.fnamemodify(path, ":t")

            -- Simple cut: just store the path for later move
            vim.g.neo_tree_cut_source = path
            vim.g.neo_tree_operation = "cut"

            -- Also copy path to clipboard for manual operations
            vim.fn.setreg("+", path)

            vim.notify("✂️  Cut: " .. filename, vim.log.levels.INFO)
          end,
          desc = "Cut file/folder"
        },
        ["p"] = {
          function(state)
            local node = state.tree:get_node()
            local target_dir = node:get_id()

            -- If pasting on a file, use its parent directory
            if node.type ~= "directory" then
              target_dir = vim.fn.fnamemodify(target_dir, ":h")
            end

            -- Check for pending cut operation
            if vim.g.neo_tree_cut_source and vim.g.neo_tree_operation == "cut" then
              local source = vim.g.neo_tree_cut_source
              local filename = vim.fn.fnamemodify(source, ":t")
              local destination = target_dir .. "/" .. filename

              -- Use vim.fn.rename for simplicity (works like mv command)
              local result = vim.fn.rename(source, destination)

              if result == 0 then
                vim.notify("📋 Moved: " .. filename, vim.log.levels.INFO)
                -- Clear cut operation
                vim.g.neo_tree_cut_source = nil
                vim.g.neo_tree_operation = nil
                -- Refresh tree
                vim.cmd("Neotree refresh")
              else
                vim.notify("❌ Failed to move: " .. filename, vim.log.levels.ERROR)
              end
            else
              -- No cut operation, try regular paste
              vim.notify("ℹ️  No cut operation pending. Use 'x' to cut first.", vim.log.levels.WARN)
            end
          end,
          desc = "Paste cut file"
        },
        ["c"] = {
          "copy",
          config = {
            show_path = "relative"
          }
        },
        ["m"] = {
          "move",
          config = {
            show_path = "relative"
          }
        },
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",
        -- Enhanced copy-paste commands for better macOS compatibility
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            -- Copy absolute path to system clipboard
            vim.fn.setreg("+", path)
            vim.notify("Copied path: " .. path, vim.log.levels.INFO)
          end,
          desc = "Copy absolute path to clipboard"
        },
        ["<leader>y"] = {
          function(state)
            local node = state.tree:get_node()
            local name = node.name
            -- Copy just the filename to system clipboard
            vim.fn.setreg("+", name)
            vim.notify("Copied filename: " .. name, vim.log.levels.INFO)
          end,
          desc = "Copy filename to clipboard"
        },
        -- Cancel cut operation
        ["<Esc>"] = {
          function(state)
            if vim.g.neo_tree_cut_source then
              local filename = vim.fn.fnamemodify(vim.g.neo_tree_cut_source, ":t")
              vim.g.neo_tree_cut_source = nil
              vim.g.neo_tree_operation = nil
              vim.notify("🚫 Cancelled cut: " .. filename, vim.log.levels.INFO)
            else
              -- Default escape behavior
              require("neo-tree.ui.inputs").cancel()
            end
          end,
          desc = "Cancel cut operation or close"
        },
        -- Show current cut status
        ["?"] = {
          function(state)
            if vim.g.neo_tree_cut_source then
              local filename = vim.fn.fnamemodify(vim.g.neo_tree_cut_source, ":t")
              vim.notify("✂️  Cut pending: " .. filename .. " (press 'p' to paste, ESC to cancel)", vim.log.levels.INFO)
            else
              -- Show default help
              require("neo-tree.sources.filesystem.commands").show_help(state)
            end
          end,
          desc = "Show help or cut status"
        },
      }
    },
  },
}