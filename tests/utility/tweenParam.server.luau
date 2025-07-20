local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local utility = require(ReplicatedStorage.Packages.utility)

testlib:AddTest(testlib.test.new(script.Name .. " numbers", function (): boolean
	local t = {n = 0}
	local resultVal = 5
	local tween = utility.TweenParam(t, "n", resultVal, TweenInfo.new(0.1))
	tween:Play()
	tween.Completed:Wait()
	return t.n == resultVal
end))

testlib:AddTest(testlib.test.new(script.Name .. " CFrame", function (): boolean
	local t = { n = CFrame.new(0,0,0) }
	local resultVal = CFrame.new(1,1,1)
	local tween = utility.TweenParam(t, "n", resultVal, TweenInfo.new(0.1))
	tween:Play()
	tween.Completed:Wait()
	return t.n == resultVal
end))
