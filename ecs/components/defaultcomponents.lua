local ECS = require("plugins.ECS")

local Components = {}

Components.ECS = ECS

-- Sprite data component
Components.Sprite = ECS.Component({	sprite = nil})

-- Vector position component
Components.Position = ECS.Component({x = 0, y = 0, z = 0})

-- Game Object Component
Components.GameObject = ECS.Component({id = "", value = nil})
Components.DemoValue = 1;

return Components