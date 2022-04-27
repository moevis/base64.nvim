local base64 = require("command")

vim.api.nvim_create_user_command("Base64Decode", function()
	base64.decode()
end, { bang = true, desc = "decode content under the cursor" })

vim.api.nvim_create_user_command("Base64Encode", function()
	base64.encode()
end, { bang = true, desc = "decode content under the cursor" })
