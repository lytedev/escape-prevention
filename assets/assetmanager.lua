require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local AssetManager = Class{function(self)
    local imgData = love.image.newImageData(1, 1)
    imgData:setPixel(0, 0, 0, 0, 0, 0)
    self.blankImage = love.graphics.newImage(imgData)

    self.assetRoot = "assets/"
    self.imageFolder = "img/"
    self.fontFolder = "font/"

    self.images = {}
    self.fonts = {}
end}

function AssetManager:init()

end

function AssetManager:getImage(key)
    return self.images[key]
end

function AssetManager:getFont(key)
    return self.fonts[key]
end

function AssetManager:loadImage(file, key)
    local key = key or file
    file = string.gsub(file, "[\\.]", "/")
    if not self.images[key] then
        self.images[key] = love.graphics.newImage(self.assetRoot .. self.imageFolder .. file .. ".png")
    end
    return self.images[key]
end

function AssetManager:loadFont(file, size, key)
    local key = key or (file .. tostring(size))
    file = string.gsub(file, "\\.", "/")
    if not self.fonts[key] then
        self.fonts[key] = love.graphics.newFont(self.assetRoot .. self.fontFolder .. file .. ".ttf", size)
    end
    return self.fonts[key]
end

function AssetManager:clearCache()
    self:clearImages()
    self:clearFonts()
end

function AssetManager:clearImages()
    self.image = {}
end

function AssetManager:clearFonts()
    self.fonts = {}
end

return AssetManager
