local utility = {}

export type Pair<First, Second> = {
	first: First,
	second: Second
}

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
