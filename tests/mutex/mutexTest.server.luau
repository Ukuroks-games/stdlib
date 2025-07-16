local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local mutex = require(ReplicatedStorage.Packages.mutex)

testlib:AddTest(testlib.test.new("Mutex", function (): boolean
	local m = mutex.new(true)
	local WaitMutex = mutex.new(true)

	local t = false

	task.spawn(function ()
		m:wait()

		t = true

		WaitMutex:unlock()
	end)

	m:unlock()

	-- here function runned in task.spawn working

	WaitMutex:wait() -- wait while thread ended
	-- if this mutex unlocing earlly this func will return false

	return t
end))
