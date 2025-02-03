local ECS = require("plugins.ECS")

local GameECS = {}
local World = ECS.World();
local Step = 0
local Time = 0.0

GameECS.System = ECS.System
GameECS.Query = ECS.Query

-- local fixedTime = 0.0

function final(self)
	-- Add finalization code here
	-- Learn more: https://defold.com/manuals/script/
	-- Remove this function if not needed
end

function GameECS:World() 
	return World
end

function GameECS:ECS() 
	return ECS
end

function GameECS:Update(dt)

	Step = Step+1
	Time = Time+dt
	
	local osTime = os.clock()
	local ecsTime = {}
	ecsTime.Now = osTime
	ecsTime.Delta = dt
	ecsTime.Frame = Step

	--print(string.format("ECS Update: step = %d | time =  %.3f sec | os time : %f",Step, Time,osTime))

	World:Update("process", osTime)

	
end

return GameECS