local ReplicatedStorage = game:GetService("ReplicatedStorage")

local queue = require(ReplicatedStorage.Packages.stdlib.queue)
local testlib = require(ReplicatedStorage.DevPackages.testlib)

testlib:AddTest(testlib.test.new("Queue", function (): boolean
	local t = { 1, 2, 3, 4 }

	local queue1 = queue.new(t)

	for _, v in pairs(t) do
		if queue1:front() == v then
			queue1:pop()
		else
			return false
		end
	end

	return true
end))
