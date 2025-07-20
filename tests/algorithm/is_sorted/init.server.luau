local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)

testlib:AddTest(testlib.test.new(script.Name .. 1, function (): boolean
	local t = {
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
	}

	table.sort(t)

	return algorithm.is_sorted(t)
end))

testlib:AddTest(testlib.test.new(script.Name .. 2, function (): boolean
	local t = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		0,
	}

	return not algorithm.is_sorted(t)
end))

testlib:AddTest(testlib.test.new(script.Name .. 3, function (): boolean
	local t = {
		434,
		314224,
		2222,
		4,
		21311,
		1,
	}

	return not algorithm.is_sorted(t)
end))
