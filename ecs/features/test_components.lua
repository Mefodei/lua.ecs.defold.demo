local ECS = require("plugins.ECS")

local TestComponents = {}

TestComponents.ECS = ECS

TestComponents.TestAnimation = ECS.Component({ sign = 1, max = 200, range = 0.0})

return TestComponents