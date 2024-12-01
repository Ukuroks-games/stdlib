local algorithm = require(game:GetService("ReplicatedStorage").Packages.algorithm)

local t = {}

for i = 1, 128, 1 do
	table.insert(t, math.random())
end

algorithm.sort(t)

if algorithm.is_sorted(t) then
	print("Ok")
else
	error("Wrong!")
end
