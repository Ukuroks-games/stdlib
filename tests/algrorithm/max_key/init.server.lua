local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)



testlib:AddTest(
	function(): boolean 
		local t = {}

		for i = 1, 128, 1 do
			t[i] = math.random()
		end

		return algorithm.max_key(t) == 128
	end, 
	script.Name
):Run()
