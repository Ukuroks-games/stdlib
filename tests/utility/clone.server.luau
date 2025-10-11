local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local utility = require(ReplicatedStorage.Packages.stdlib.utility)

local listTables = {
	{
		22, 5352, 25,3, 32, "525", 434634, 6.5, "touch grass && cat grass"
	},
	{
		22, Instance.new("BoolValue"), 25,3, 32, "525", 434634, 6.5, "touch grass && cat grass"
	},
}

for i, v in pairs(listTables) do
	testlib:AddTest(testlib.test.new("clone" .. i, function (): boolean
		local t = v
		local clone = utility.clone(t)

		print(t, v)

		return utility.compare(t, clone)
	end))
end
