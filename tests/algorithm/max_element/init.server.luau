local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)

testlib:AddTest(testlib.test.new(script.Name, function (): boolean
	local t = {
		[0] = 0,
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
		[8] = 8,
		[10] = 9,
	}

	local result = algorithm.max_element(t)

	return result.Num == 9 and result.Index == 10
end))
