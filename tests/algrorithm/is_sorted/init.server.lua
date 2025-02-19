local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.algorithm)


testlib:AddTest(
	function(): boolean 
		local t = {
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		table.sort(t)

		return algorithm.is_sorted(t)
	end, 
	script.Name..1
): Run()


testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		return not algorithm.is_sorted(t)
	end, 
	script.Name..2
): Run()
