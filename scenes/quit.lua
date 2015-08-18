require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")
local Gamestate = require("hump.gamestate")

local QuitMenu = Gamestate.new()

function QuitMenu:init()
    self.title = "Are you sure?"
    self.selectedItem = 1
    self.selectableItems = {
        {text="Yes", callback=function()love.event.quit()end},
        --{text="Settings", callback=function()Gamestate.switch(require("scenes.settings"))end},
        {text="No", callback=function()Gamestate.switch(require("scenes.mainmenu"))end}
    }

    self.titleFont = assetManager:loadFont("opensans_light", 48, "ss48")
    self.itemFont = assetManager:loadFont("opensans_semibold", 16, "ss16")

    self.titleColor = {255, 255, 255, 255}
    self.itemColor = {180, 180, 180, 255}
    self.selColor = {255, 80, 0, 255}

    self.titlePosition = vector(20, 8)

    self.itemSpacing = vector(0, 25)
    -- self.itemPosition = vector(20, love.graphics.getHeight() -(self.itemSpacing.y * 3) - 16)
    self.itemPosition = vector(40, 90)
end

function QuitMenu:update(dt)

end

function QuitMenu:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "down" or key == "s" then
        self.selectedItem = self.selectedItem + 1
    end
    if key == "up" or key == "w" then
        self.selectedItem = self.selectedItem - 1
    end
    if self.selectedItem > #self.selectableItems then
        self.selectedItem = 1
    end
    if self.selectedItem < 1 then
        self.selectedItem = #self.selectableItems
    end
    if key == "return" or key == "l" or key == "x" then
        self.selectableItems[self.selectedItem].callback()
    end
end

function QuitMenu:draw()
    love.graphics.setFont(self.titleFont)
    love.graphics.setColor(self.titleColor)
    love.graphics.print(self.title, self.titlePosition.x, self.titlePosition.y)
    local curPos = self.itemPosition
    love.graphics.setFont(self.itemFont)
    for i = 1, #self.selectableItems do
        local item = self.selectableItems[i]
        local col = self.itemColor
        if self.selectedItem == i then
            col = self.selColor
        end
        love.graphics.setColor(col)
        love.graphics.print(item.text, curPos.x, curPos.y)
        curPos = curPos + self.itemSpacing
    end
end

return QuitMenu
