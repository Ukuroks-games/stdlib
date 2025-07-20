local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)

testlib:AddTest(testlib.test.new(script.Name, function (): boolean
	return algorithm.search({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, { 4, 5, 6 }) == 3
end))

testlib:AddTest(testlib.test.new(script.Name .. " on range", function (): boolean
	return algorithm.search({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, { 4, 5, 6 }, 1, 8) == 3
end))
