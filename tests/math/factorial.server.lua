local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local math = require(ReplicatedStorage.Packages.math)


testlib:AddTest(
	function(): boolean 
		return math.factorial(1) == 1 and
			math.factorial(2) == 2 and 
			math.factorial(16) == 20_922_789_888_000
	end, 
	"Integer factorial"
):Run()

testlib:AddTest(
	function(): boolean 
		return 3.3 < math.factorial(2.5) and math.factorial(2.5) < 3.4 and 
			0.8 < math.factorial(0.5) and math.factorial(0.5) < 0.9 and
			119_292.461 < math.factorial(2.5) and math.factorial(8.5) < 119_292.5
	end,
	"Float factorial"
):Run()
