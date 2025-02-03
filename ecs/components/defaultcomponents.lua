local ECS = require("plugins.ECS")

local Components = {}

Components.SpriteComponent = ECS.Component({	sprite = nil})
Components.PositionComponent = ECS.Component({x = 0, y = 0})
Components.DemoValue = 1;

return Components