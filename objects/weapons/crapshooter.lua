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

local CrapShooter = Class{inherits = Weapon, function(self)
    Weapon.construct(self, "Crap Shooter")
    self.cooldown = 0.4
    local p1 = ProjectileType()

    p1.damage = 2
    p1.offset = vector(0, -30)
    p1.velocity = vector(0, -80)

    p1.color = {255, 40, 0, 255}

    self.projectileTypes = {p1}
end}

return CrapShooter
