local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)

testlib:AddTest(testlib.test.new(script.Name, function (): boolean
	local t = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		0,
	}

	local result = algorithm.min_element(t)

	return result.Num == 0 and result.Index == 10
end))
