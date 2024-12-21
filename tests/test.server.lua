local ReplicatedStorage = game:GetService("ReplicatedStorage")

local testlib = require(ReplicatedStorage.DevPackages.testlib)
local algorithm = require(ReplicatedStorage.Packages.algorithm)

local TestsFolder = testlib.testsFolder

local testsList = {}

local function GetNumOfTests(): number
	local testsCatigories = script.Parent:GetChildren()
	local num = 0

	for _, v in pairs(testsCatigories) do
		for _, v in pairs(v:GetChildren()) do
			if typeof(v) == "Script" then
				num += v:GetAttribute("NumOfTests")
			end
		end
	end

	return num
end

local NumOfTests = GetNumOfTests()

TestsFolder.ChildAdded:Connect(function(a0: string) 

	local testsFolders: {Folder} = TestsFolder:GetChildren()

	for _, v in pairs(testsFolders) do
		if algorithm.find_if_not(
			testsList,
			function(value): boolean 
					return value.Name == v.Name
				end
			) then

				table.insert(testsList, testlib.test.fromFolder(v))
		end
	end

	if #testsFolders >= NumOfTests then
		testlib.Summary()
	end
end)
