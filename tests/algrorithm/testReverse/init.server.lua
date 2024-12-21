local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)
	
testlib:AddTest(
	function(): boolean 
		local Table = {1,2,3,4,5,6,7,8,9}
		local reveced = {9,8,7,6,5,4,3,2,1}

		local result = algorithm.reverse(Table)

		return reveced == result 
	end, 
	"Reverse"
):Run()
