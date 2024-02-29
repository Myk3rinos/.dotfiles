-- require("exifaudio")

require("glow"):setup {
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
function Status:render() return {} end

local old_manager_render = Manager.render
function Manager:render(area)
	return old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })
end
