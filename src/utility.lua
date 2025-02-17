
--[[
	Utility library
]]
local utility = {}
utility.Pair = {}


export type Pair<First, Second> = {
	first: First,
	second: Second
}

--[[
	Pair constuctor
]]
function utility.Pair.new<First, Second>(first: First, second: Second): Pair<First, Second>
	local self: Pair<First, Second> = {
		first = first,
		second = second
	}

	return self
end

--[[
	# Поменять две переменные местами

	## Rarams:

	`Table1` - превая переменная

	`Table2` - вторая переменная
]]
function utility.swap(Table1: {}, Table2: {})
	Table1, Table2 = Table2, Table1
end



return utility
