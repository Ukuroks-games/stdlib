local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local math = require(ReplicatedStorage.Packages.stdlib.math)

testlib:AddTest(testlib.test.new("Integer factorial", function (): boolean
	return math.factorial(1) == 1 and math.factorial(2) == 2 and math.factorial(16) == 20_922_789_888_000
end))

testlib:AddTest(testlib.test.new("Float factorial", function (): boolean
	return math.floatcmp(math.factorial(2.5), 3.323_350_970)
		and math.floatcmp(math.factorial(0.5), 0.886_226_9)
		and math.floatcmp(math.factorial(8.5), 119_292.461_994)
end))
