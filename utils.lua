function rerequire(module)
    package.loaded[module] = nil
    return require(module)
end

local __newImage = love.graphics.newImage -- old function
function love.graphics.newImage( ... ) -- new function that sets nearest filter
   local img = __newImage( ... ) -- call old function with all arguments to this function
   img:setFilter( 'nearest', 'nearest' )
   return img
end
function love.graphics.newSmoothImage( ... )
    return __newImage( ... )
end

alignments = {
    topleft = 1,
    top = 2,
    topright = 3,
    left = 4,
    center = 5,
    right = 6,
    bottomleft = 7,
    bottom = 8,
    bottomright = 9,
}

function getAlignedDimensions(position, size, bounds, alignment)
    local dimension = {0, 0, 0, 0}

    if alignment <= 3 then
        dimension[4] = size.y
        dimension[2] = bounds[2] + position.y
    elseif alignment <= 6 then
        dimension[4] = size.y
        dimension[2] = bounds[2] + (bounds[4] / 2) - (dimension[4] / 2) + position.y
    else
        dimension[4] = size.y
        dimension[2] = bounds[2] + bounds[4] - dimension[4] - position.y
    end
    if alignment % 3 == 1 then
        dimension[3] = size.x
        dimension[1] = bounds[1] + position.x
    elseif alignment % 3 == 2 then
        dimension[3] = size.x
        dimension[1] = bounds[1] + (bounds[3] / 2) - (dimension[3] / 2) + position.x
    elseif alignment % 3 == 0 then
        dimension[3] = size.x
        dimension[1] = bounds[1] + bounds[3] - dimension[3] - position.x
    end

    return dimension
end

function table.copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end
