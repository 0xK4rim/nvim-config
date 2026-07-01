local M = {}

function M.load(path)
    path = path or vim.fn.expand(
        "~/.local/state/quickshell/user/generated/terminal/kitty-theme.conf"
    )

    local palette = {}

    for line in io.lines(path) do
        local key, value = line:match("^([%w_]+)%s+(#%x+)")
        if key and value then
            palette[key] = value
        end
    end

    return palette
end

return M
