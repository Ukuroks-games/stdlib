local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.stdlib.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)

testlib:AddTest(testlib.test.new(script.Name, function (): boolean
	local t = {}

	for i = 1, 128, 1 do
		t[i] = math.random()
	end

	return algorithm.min_key(t) == 1
end))
