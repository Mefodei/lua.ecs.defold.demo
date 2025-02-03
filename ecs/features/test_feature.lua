local ECS = require("plugins.ECS")
local Components = require("ecs.components.defaultcomponents")

local System, Query = ECS.System, ECS.Query 

local feature = {}
local gameTime = 0.0

feature.DemoSystem = System("process")

local positionQuery = Query.All(Components.PositionComponent, Components.GameObject).Build()

function feature:Initialize(world)

	print("Now we are calling an initialize test ecs feature")
	
	world:AddSystem(self.DemoSystem)

end

function feature.DemoSystem:Update(time)

	-- DEMO SINGLETON VALUE
	-- local msg = string.format("Demo call from ECS Update system %i", Components.DemoValue)
	-- print(msg)	

	local dt = time.Now - gameTime
	gameTime = time.Now

	for i, entity in self:Result(positionQuery):Iterator() do
		
		local goComponent = entity[Components.GameObject]
		local positionComponent = entity[Components.Position]
		local gameObject = goComponent.value

		print(string.format("Entity GameObject : %s",gameObject.get_id()))
		
		if gameObject then

			local num = math.random() 
			local sign = 1

			if num < 0.5 then
				sign = -1
			end

			local position = gameObject.get_position()
			
			positionComponent.y = positionComponent.y + (dt * 20)
			entity:Set(positionComponent)

			position.y = positionComponent.y
			position.x = positionComponent.x

			gameObject.set_position(position)

			local entityMsg = string.format("DT %f | NOW: %f | ENTITY %i : x = %f y = %f",dt,time.Now,entity.id,position.x,position.y)

			print(entityMsg)

		end
		
	end
	
end

function feature.Log(world)

	print("Demo Call from Local Method")

end

return feature

