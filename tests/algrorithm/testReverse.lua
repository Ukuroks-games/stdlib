local algorithm = require(game:GetService("ReplicatedStorage").Packages.algorithm)

local Table = {1,2,3,4,5,6,7,8,9}
local reveced = {9,8,7,6,5,4,3,2,1}

local result = algorithm.reverse(Table)

if reveced == result then
	print("Ok")
else
	error("Wrong!"..result)
end
