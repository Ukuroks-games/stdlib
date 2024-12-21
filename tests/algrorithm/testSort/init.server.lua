local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)

testlib:AddTest(
	function(): boolean 
		local t = {}

		for i = 1, 128, 1 do
			table.insert(t, math.random())
		end

		algorithm.sort(t)

		return algorithm.is_sorted(t)
	end, 
	"Sort"
):Run()