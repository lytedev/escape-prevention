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

local ThreeShot = Class{inherits = Weapon, function(self)
    Weapon.construct(self, "Three Shot")
    local p1 = ProjectileType()
    local p2 = ProjectileType()
    local p3 = ProjectileType()

    p1.damage = 10

    p1.offset = vector(-10, -20)
    p2.offset = vector(0, p1.offset.y + p1.offset.x / 2)
    p3.offset = vector(-p1.offset.x, p1.offset.y)

    p1.velocity = vector(0, -100)
    p2.velocity = p1.velocity
    p3.velocity = p1.velocity

    p1.color = {0, 150, 255, 255}
    p2.color = p1.color
    p3.color = p1.color

    self.projectileTypes = {p1, p2, p3}
end}

return ThreeShot
