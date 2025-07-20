local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local utility = require(ReplicatedStorage.Packages.stdlib.utility)

testlib:AddTest(testlib.test.new("merge tables", function (): boolean
	local t1 = { a = "a" }
	local t2 = { b = "b" }

	return utility.compare(utility.merge(t1, t2), { a = "a", b = "b" })
end))
