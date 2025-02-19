local ReplicatedStorage = game:GetService("ReplicatedStorage")

local algorithm = require(ReplicatedStorage.Packages.algorithm)
local testlib = require(ReplicatedStorage.DevPackages.testlib)



testlib:AddTest(
	function(): boolean 
		local t = {}

		for i = 1, 128, 1 do
			t[i] = math.random()
		end

		algorithm.sort(t)

		return algorithm.is_sorted(t)
	end, 
	script.Name.." default"
):Run()

testlib:AddTest(
	function(): boolean 
		
		local t = {}

		for i = 1, 128, 1 do
			t[i] = math.random()
		end

		local s, e

		s = math.random(1, 128 / 2)
		e = math.random(s, 128)

		algorithm.sort(t, s, e)

		return algorithm.is_sorted(t, s, e)
	end,
	script.Name.." on range"
):Run()


testlib:AddTest(
	function(): boolean 
		
		local t = {}

		for i = 1, 128, 1 do
			t[i] = {}
			t[i]["prop"] = math.random()
		end

		algorithm.sort_by(t, "prop")

		return algorithm.is_sorted_by(t, "prop")
	end,
	script.Name.." by prop"
):Run()


testlib:AddTest(
	function(): boolean 
		
		local t = {}

		for i = 1, 128, 1 do
			t[i] = {}
			t[i]["prop"] = math.random()
		end

		local s, e = 5, 120

		algorithm.sort_by(t, "prop", s, e)

		return algorithm.is_sorted_by(t, "prop", s, e)
	end,
	script.Name.." by prop on range"
):Run()
