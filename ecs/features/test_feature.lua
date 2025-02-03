local ECS = require("plugins.ECS")
local System, Query = ECS.System, ECS.Query 
local Components = require("ecs.components.defaultcomponents")

local feature = {}

feature.DemoSystem = System("process")

local positionQuery = Query.All(Components.PositionComponent).Build()

function feature:Initialize(world)

	print("Now we are calling an initialize test ecs feature")
	
	world:AddSystem(self.DemoSystem)

end

function feature.DemoSystem:Update(time)

	-- DEMO SINGLETON VALUE
	-- local msg = string.format("Demo call from ECS Update system %i", Components.DemoValue)
	-- print(msg)	

	for i, entity in self:Result(positionQuery):Iterator() do
		local positionComponent = entity[Components.PositionComponent]
		local entityMsg = string.format("ENTITY %i : x = %f y = %f", entity.id,positionComponent.x,positionComponent.y)
		print(entityMsg)
	end
	
end

function feature.Log(world)

	print("Demo Call from Local Method")

end

return feature

