require("utils")
local vector = require("hump.vector")
local Class = require("hump.class")

local ProjectileType = require("objects.projectiletype")
local Projectile = require("objects.projectile")

local Weapon = Class{function(self, name, projectileTypes, cooldown)
    self.name = name or "Weapon"
    self.projectileTypes = projectileTypes or {ProjectileType()}
    self.cooldown = cooldown or 0.1
end}

function Weapon:fireFrom(ship)
    for i = 1, #self.projectileTypes do
        self.projectileTypes[i]:fireFrom(ship)
    end
    ship.cooldown = self.cooldown
end

return Weapon
