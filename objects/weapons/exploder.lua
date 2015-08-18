require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local ProjectileType = require("objects.projectiletype")
local Projectile = require("objects.projectile")
local Weapon = require("objects.weapon")

    --[[ 

    size
    offset
    velocity
    cooldown
    damage
    angle
    fixang
    useParentVelocity
    color
    lifetime
    fadetime
    density

    ]]--

local Exploder = Class{inherits = Weapon, function(self)
    Weapon.construct(self, "Exploder")
    local ang = (2 * math.pi) / 6

    local npts = 128
    for i = 1, npts do
        local p = ProjectileType()
        p.angle = ((math.pi * 2) / npts) * i
        p.color = {255, 150, 0, 200}
        p.velocity = vector(0, -30000)
        p.offset = vector(0, -32)
        p.lifetime = 0.8
        p.fadetime = 0.02
        p.size = vector(10, 1)
        p.density = 200
        p.damage = 1
        -- p.fadetime = 0.1
        self.projectileTypes[i] = p
    end
    self.cooldown = 0.5
end}

return Exploder
