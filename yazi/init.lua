require("test").setup {
	key1 = "value1",
	key2 = "value2",
	-- ...
}

require("max-preview")


require("glow").setup {
  enable = true,
  -- colors = { bg = "#1e222a", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
  -- colors = { bg = "#282c34", fg = "#abb2bf" },
}
require("status")

------ No Status Bar ------
-- function Status:render() return {} end
--
-- local old_manager_render = Manager.render
-- function Manager:render(area)
-- 	return old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })
-- end
--
-- function Status:name()
--  		return ui.Span("")
--  	end
--
-- local linked = ""
-- if h.link_to ~= nil then
--  	linked = " -> " .. tostring(h.link_to)
-- end
-- return ui.Span(" " .. h.name .. linked)
-- end


-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- local opts = {}
--
-- --require("lazy").setup(plugins, opts)
-- require("vim-options")
-- require("lazy").setup("plugins")
