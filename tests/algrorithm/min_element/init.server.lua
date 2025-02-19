local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.algorithm)


testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		local result = algorithm.min_element(t)

		return result.Num == 0 and result.Index == 10
	end, 
	script.Name
): Run()
