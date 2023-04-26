-- ---------------------------------------------
--   Heirline: Status line and tab/buffer line
-- ---------------------------------------------
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    bg = "#1c1c1c",
    fg = "#dfdfaf",
    red = "#af5f5f",
    green = "#87875f",
    blue = "#878787",
    gray = "#262626",
    lightgray = "#424242",
    orange = "#dfaf87",
    yellow = "#af875f",
    purple = "#875f5f",
    cyan = "#87afaf",
}
require('heirline').load_colors(colors)

--   Statusline
-- --------------

local mode_status = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()

    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*:*o",
            command = 'redrawstatus'
        })
        self.once = true
    end
end

local mode_colors = {
    n = "red",
    i = "blue",
    v = "yellow",
    V = "yellow",
    ["\22"] = "cyan",
    c = "orange",
    s = "orange",
    S = "orange",
    ["\19"] = "purple",
    R = "purple",
    r = "purple",
    ["!"] = "red",
    t = "green",
}

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = mode_status,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {},
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    provider = " ■ ",
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = "#1c1c1c", bg = mode_colors[mode], bold = true }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- This is not required in any way, but it's there, and it's a small
    -- performance improvement.
    update = {
        "ModeChanged",
    },
    {
        init = mode_status,
        -- Now we define some dictionaries to map the output of mode() to the
        -- corresponding string and color. We can put these into `static` to compute
        -- them at initialisation time.
        static = {
            mode_names = { -- change the strings if you like it vvvvverbose!
                n = " NORMAL ",
                no = " NORMAL ",
                nov = " NORMAL ",
                noV = " NORMAL ",
                ["no\22"] = " NORMAL ",
                niI = " NORMAL ",
                niR = " NORMAL ",
                niV = " NORMAL ",
                nt = " NORMAL ",
                v = " VISUAL ",
                vs = " VISUAL ",
                V = " VISUAL ",
                Vs = " VISUAL ",
                ["\22"] = " VISUAL ",
                ["\22s"] = " VISUAL ",
                s = " SELECT ",
                S = " SELECT ",
                ["\19"] = " SELECT ",
                i = " INSERT ",
                ic = " INSERT ",
                ix = " INSERT ",
                R = " REPLACE ",
                Rc = " REPLACE ",
                Rx = " REPLACE ",
                Rv = " REPLACE ",
                Rvc = " REPLACE ",
                Rvx = " REPLACE ",
                c = " COMMAND ",
                cv = " Ex ",
                r = " ... ",
                rm = " MORE ",
                ["r?"] = " ? ",
                ["!"] = " ! ",
                t = " TERMINAL ",
            },
        },
        -- We can now access the value of mode() that, by now, would have been
        -- computed by `init()` and use it to index our strings dictionary.
        -- note how `static` fields become just regular attributes once the
        -- component is instantiated.
        -- To be extra meticulous, we can also add some vim statusline syntax to
        -- control the padding and make sure our string is always at least 2
        -- characters long. Plus a nice Icon.
        provider = function(self)
            return self.mode_names[self.mode]
        end,
        -- Same goes for the highlight. Now the foreground will change according to the current mode.
        hl = { fg = "#dfdfaf", bg = "#262626", bold = true, },
        -- Re-evaluate the component only on ModeChanged event!
        -- This is not required in any way, but it's there, and it's a small
        -- performance improvement.
        update = {
            "ModeChanged",
        },
    }
}
local Align = { provider = "%=" }

local Gap = {
    provider = " ",
    hl = { fg = "fg", bg = "bg" },
}

local Git = {
    init = mode_status,
    condition = conditions.is_git_repo,
    provider = "  ",
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = colors["lightgray"], fg = mode_colors[mode] }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- This is not required in any way, but it's there, and it's a small
    -- performance improvement.
    update = {
        "ModeChanged",
    },
    {
        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                self.status_dict.changed ~= 0
        end,

        hl = { fg = "fg", bg = "gray" },


        { -- git branch name
            provider = function(self)
                return "" .. self.status_dict.head .. " "
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("+" .. count .. " ")
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("-" .. count .. " ")
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("~" .. count .. " ")
            end,
        },
        {
            provider = " ",
            hl = { fg = "fg", bg = "bg" },
        },
    }
}

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    init = mode_status,
    provider = "  ",
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = colors["lightgray"], fg = mode_colors[mode] }
    end,
    {
        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,

        update = { "DiagnosticChanged", "BufEnter" },
        hl = { fg = "fg", bg = "gray" },

        {
            provider = " ",
        },
        {
            provider = function(self)
                -- 0 is just another output, we can decide to print it or not!
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
            end,
        },
        {
            provider = " ",
            hl = { fg = "fg", bg = "bg" },
        },
    },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = "gray" },
}
-- We can now define some children separately and add them later

local FileName = {
    init = mode_status,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = colors["lightgray"], fg = mode_colors[mode] }
    end,
    provider = "  ",

    {
        provider = function(self)
            -- first, trim the pattern relative to the current directory. For other
            -- options, see :h filename-modifers
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then return " [No Name] " end
            -- now, if the filename would occupy more than 1/4th of the available
            -- space, we trim the file path to its initials
            -- See Flexible Components section below for dynamic truncation
            if not conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return " " .. filename .. " "
        end,
        hl = { fg = "fg", bg = "gray" },
    },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "● ",
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
    },
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileName,
    unpack(FileFlags), -- A small optimisation, since their parent does nothing
    { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
)

local FileType = {
    init = mode_status,
    condition = function()
        return vim.bo.filetype ~= ""
    end,
    {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
            self.icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, { default = true })
        end,
        provider = function(self)
            return self.icon and (" " .. self.icon .. " ")
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { bg = colors["lightgray"], fg = mode_colors[mode] }
        end
    },
    {
        provider = function()
            return " " .. vim.bo.filetype .. " "
        end,
        hl = { fg = "fg", bg = "gray" },
    }
}

local FileFormat = {
    init = mode_status,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = colors["lightgray"], fg = mode_colors[mode] }
    end,
    provider = function()
        local os = vim.bo.fileformat:upper()
        local icon
        if os == "UNIX" then
            icon = ""
        elseif os == "MAC" then
            icon = ""
        else
            icon = ""
        end
        return " " .. icon .. " "
    end,
    {
        provider = function()
            local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
            return " " .. enc .. " "
        end,
        hl = { fg = "fg", bg = "gray" },
    },
}

local Ruler = {
    init = mode_status,
    provider = "  ",
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = colors["lightgray"], fg = mode_colors[mode] }
    end,

    {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %P = percentage through file of displayed window
        provider = " %l:%c %P ",
        hl = { fg = "fg", bg = "gray" },
    }
}

local statusline = { ViMode, Gap, Git, Diagnostics, FileNameBlock, Gap, Align, FileType, Gap, FileFormat, Gap,
    Ruler }

--  Tabline
-- ---------

local TablineBufnr = {
    provider = function(self)
        return " " .. tostring(self.bufnr) .. " "
    end,
    hl = function(self)
        if self.is_active then
            return { fg = "bg", bg = "red", bold = true }
        else
            return { fg = "bg", bg = "lightgray" }
        end
    end,
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
    provider = function(self)
        -- self.filename will be defined later, just keep looking at the example!
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return " " .. filename .. " "
    end,
    hl = { fg = "fg", bg = "gray" },
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_buf_get_option(self.bufnr, "modified")
        end,
        provider = "● ",
        hl = { fg = "fg", bg = "gray" },
    },
    {
        condition = function(self)
            return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
                or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
        end,
        provider = function(self)
            if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
                return " "
            else
                return " "
            end
        end,
        hl = { fg = "orange" },
    },
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    {
        provider = "✖ ",
        hl = { fg = "green", bg = "gray" },
        on_click = {
            callback = function(_, minwid)
                vim.api.nvim_buf_delete(minwid, { force = false })
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback",
        },
    },
    { provider = " ", hl = { bg = "bg" } },
}

-- Here the filename block finally comes together
local TablineBufferBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    on_click = {
        callback = function(_, minwid, _, button)
            if (button == "m") then -- close on mouse middle click
                vim.api.nvim_buf_delete(minwid, { force = false })
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    TablineFileName,
    TablineFileFlags,
    TablineCloseButton
}

-- Get number of listed buffers
local function get_bufs()
    local bufs = vim.tbl_filter(function(bufnr)
        return vim.api.nvim_buf_get_option(bufnr, "buflisted")
    end, vim.api.nvim_list_bufs())
    return #bufs > 1 and bufs or {}
end

-- and here we go
local Bufferline = {
    utils.make_buflist(
        TablineBufferBlock,
        {
            provider = "  ",
            hl = { fg = "fg", bg = "gray" },
            {
                provider = " ",
                hl = { bg = "bg" }
            }
        },
        {
            provider = "  ",
            hl = { fg = "fg", bg = "gray" },
            {
                provider = " ",
                hl = { bg = "bg" }
            }
        }, get_bufs
    )
}

local Tabpage = {
    provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
    hl = function(self)
        if not self.is_active then
            return { fg = "fg", bg = "gray" }
        else
            return { fg = "bg", bg = "red" }
        end
    end,
    { provider = " ", hl = { bg = "bg" } },
}

local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(Tabpage),
}

local TabLineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        if vim.bo[bufnr].filetype == "NvimTree" then
            self.title = "NvimTree"
            return true
            -- elseif vim.bo[bufnr].filetype == "TagBar" then
            --     ...
        end
    end,

    provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
            return { fg = "purple", bg = "bg" }
        else
            return { fg = "lightgray", bg = "bg" }
        end
    end,
}

local tabline = { TabLineOffset, Bufferline, TabPages }

require 'heirline'.setup({
    statusline = statusline,
    tabline = tabline
})
