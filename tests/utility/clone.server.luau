local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local utility = require(ReplicatedStorage.Packages.stdlib.utility)

testlib:AddTest(testlib.test.new("clone table", function (): boolean
	local t = {
		22,
		5352,
		25,
		3,
		32,
		"525",
		434634,
		6.5,
		"touch grass && cat grass",
	}
	local clone = utility.clone(t)

	return utility.compare(utility.diff(t, clone), {})
end))

testlib:AddTest(
	testlib.test.new("clone table with Instances", function (): boolean
		local t = {
			22,
			Instance.new("BoolValue"),
			25,
			3,
			32,
			"525",
			434634,
			6.5,
			"touch grass && cat grass",
		}
		local clone = utility.clone(t)

		return utility.compare(utility.diff(t, clone), {}) == false	-- wrong because compare Instances is false
	end)
)
