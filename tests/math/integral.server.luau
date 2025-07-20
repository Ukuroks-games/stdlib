local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local math = require(ReplicatedStorage.Packages.stdlib.math)

testlib:AddTest(testlib.test.new(script.Name .. " 1", function (): boolean
	return math.floatcmp(
		math.integral(function (_: number): number
			return 1
		end, 0, math.pi),
		math.pi
	)
end))

testlib:AddTest(testlib.test.new(script.Name .. " sin", function (): boolean
	return math.floatcmp(math.integral(math.sin, 0, math.pi / 2), 1)
end))

testlib:AddTest(testlib.test.new(script.Name .. " cos", function (): boolean
	return math.floatcmp(math.integral(math.cos, 0, math.pi), math.pi / 2) -- π/2
end))

testlib:AddTest(testlib.test.new("(x*sinx)²", function (): boolean
	return math.floatcmp(
		math.integral(function (x: number): number
			return math.pow(x * math.sin(x), 2)
		end, 0, math.pi),
		((4 * math.pow(math.pi, 3)) - (6 * math.pi)) / 24
	) -- (4π³ - 6π) / 24
end))

testlib:AddTest(testlib.test.new(script.Name .. " x²", function (): boolean
	return math.floatcmp(
		math.integral(function (x: number): number
			return math.pow(x, 2)
		end, 0, math.pi),
		math.pow(math.pi, 7) / 7
	) -- (π^7)/7
end))

testlib:AddTest(testlib.test.new(script.Name .. " x³", function (): boolean
	return math.floatcmp(
		math.integral(function (x: number): number
			return math.pow(x, 3)
		end, 0, math.pi),
		math.pow(math.pi, 9) / 9
	) -- (π^7)/7
end))
