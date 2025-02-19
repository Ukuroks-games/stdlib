local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.algorithm)


testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		return algorithm.find(t, 0) == 10
	end, 
	script.Name
): Run()

testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		return algorithm.find(t, 0, 5, 10) == 10
	end, 
	script.Name
): Run()

testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		return algorithm.find_if(
			t,
			function(value: number): boolean
				return value == 0
			end
		) == 10
	end, 
	script.Name.."_if"
): Run()

testlib:AddTest(
	function(): boolean 
		local t = {
			[10] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
		}

		return not algorithm.find_if_not(
			t,
			function(value: number): boolean
				return not (value == 0)
			end,
			1, 9
			) 
	end, 
	script.Name.."_if_not"
): Run()
