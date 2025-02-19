local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.algorithm)


testlib:AddTest(
	function(): boolean 
		local t = {
			[0] = 0, 1, 2, 3, 4, 5, 6, 7, 8, [10] =  9
		}

		local result = algorithm.max_element(t)

		return result.Num == 9 and result.Index == 10
	end, 
	script.Name
): Run()
