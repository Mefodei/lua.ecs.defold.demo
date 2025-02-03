local testFeature = require("ecs.features.test_feature")

local GameEcsFueatures = {}

function GameEcsFueatures:Initialize(world)

	testFeature:Initialize(world)
	
end

return GameEcsFueatures