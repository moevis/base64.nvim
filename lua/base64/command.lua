local module = {}

local encoding = require("base64.encoding")

function module.encode()
  module.process_selection(true)
end

function module.decode()
  module.process_selection(false)
end

local function is_valid(c)
    return c == "=" or encoding.base64bytes[c] ~= nil
end

function module.process_selection(encode_mode)
    local content = ""
    local mode = vim.api.nvim_get_mode().mode
    if mode == "n" then
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row, col = cursor[1], cursor[2]

        local line = vim.api.nvim_get_current_line()
        local right_num = 0
        for i = col + 1, #line do
            local c = line:sub(i, i)
            if is_valid(c) then
                right_num = right_num + 1
                content = content .. c
            else
                break
            end
        end
        local left_num = 0
        for i = col, 1, -1 do
            local c = line:sub(i, i)
            if is_valid(c) then
                left_num = left_num + 1
                content = c .. content
            else
                break
            end
        end
        local ret = ""
        if encode_mode then
            ret = encoding.encode(content)
        else
            ret = encoding.decode(content)
        end
        vim.api.nvim_buf_set_text(0, row - 1, col - left_num, row - 1, col + right_num, {ret})
    else
        local row1, col1 = unpack(vim.fn.getpos("v"), 2, 3)
        local row2, col2 = unpack(vim.api.nvim_win_get_cursor(0))
        content = vim.api.nvim_buf_get_text(0, row1 - 1, col1 - 1, row2 - 1, col2 + 1, {})
        content = table.concat(content, "\n")
        ret = ""
        if encode_mode then
            ret = module.encode(content)
        else
            ret = module.decode(content)
        end
        vim.api.nvim_buf_set_text(0, row1 - 1, col1 - 1, row2 - 1, col2 + 1, {ret})
        vim.api.nvim_win_set_cursor(0, {row1, col1 + #ret - 1})
    end
end

return module
