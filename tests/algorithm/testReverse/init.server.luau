local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)
local utility = require(ReplicatedStorage.Packages.stdlib.utility)

testlib:AddTest(testlib.test.new(script.Name, function (): boolean
	local Table = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
	local reveced = { 9, 8, 7, 6, 5, 4, 3, 2, 1 }

	algorithm.reverse(Table)

	return utility.compare(Table, reveced)
end))
