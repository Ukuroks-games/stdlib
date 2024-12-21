local ReplicatedStorage = game:GetService("ReplicatedStorage")

local queue = require(ReplicatedStorage.Packages.queue)
local testlib = require(ReplicatedStorage.DevPackages.testlib)


testlib:AddTest(
	function(): boolean 
		local t = {1, 2, 3, 4}

		local queue1 = queue.new(t)

		for i, v in pairs(t) do
			if queue1:front() == v then
				queue1:pop()
			else
				return false
			end
		end

		return true
	end,
	"Queue"
):Run()
