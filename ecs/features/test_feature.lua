local ECS = require("plugins.ECS")
local Components = require("ecs.components.defaultcomponents")
local TestComponents = require("ecs.features.test_components")

local System, Query = ECS.System, ECS.Query 
local feature = {}
local gameTime = 0.0
local positionQuery = Query.All(Components.Position, Components.GameObject).Build()



-- SYSTEMS
feature.DemoSystem = System("process")



function feature:Initialize(world)

	print("Now we are calling an initialize test ecs feature")
	
	world:AddSystem(feature.DemoSystem)

end

function feature.DemoSystem:Update(time)

	-- DEMO SINGLETON VALUE
	-- local msg = string.format("Demo call from ECS Update system %i", Components.DemoValue)
	-- print(msg)	
	
	local dt = time.Now - gameTime
	gameTime = time.Now

	self:Result(positionQuery):ForEach(function(entity)

		local goComponent = entity[Components.GameObject]
		local goId = goComponent.id
		local positionComponent = entity[Components.Position]
		local animationComponent = entity[TestComponents.TestAnimation]
		local go = goComponent.value
		local gameObjectId = go.get_id()

		print(string.format("Entity GameObject ID: %s",goId))
		print(string.format("Entity GameObject : %s",goComponent.value.get_id()))
		print(string.format("Entity GameObject : %s",gameObjectId))

		if go then

			local position = go.get_position(goId)
			local sign = animationComponent.sign
			local distance = (dt * 50 * sign)
			
			local range = animationComponent.range + math.abs(distance)
			
			if range > animationComponent.max then
				animationComponent.sign = animationComponent.sign * -1
				animationComponent.range = 0
				distance = -distance
				range = math.abs(distance)
			end

			animationComponent.range = range
			
			local newPosY =  positionComponent.y + distance
			positionComponent.y = newPosY
			
			entity:Set(positionComponent)

			position.y = positionComponent.y
			position.x = positionComponent.x

			go.set_position(position,goId)

			local entityMsg = string.format("DT %f | NOW: %f | ENTITY %i : x = %f y = %f",dt,time.Now,entity.id,position.x,position.y)

			print(entityMsg)

		end

	end)
	
	-- for i, entity in self:Result(positionQuery):Iterator() do
		--- not woorking

	
	-- end
	
end

return feature

