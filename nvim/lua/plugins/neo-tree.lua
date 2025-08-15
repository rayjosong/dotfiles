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
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
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
      mappings = {
        -- RE-ENABLE SEARCH FUNCTIONALITY (but hide the visual bar)
        ["/"] = "fuzzy_finder",
        ["#"] = "fuzzy_finder_directory", 
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
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
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["i"] = "show_file_details",
      }
    },
  },
}