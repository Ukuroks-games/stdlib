--[[
	Utility library
]]
local utility = {}
utility.Pair = {}

export type Pair<First, Second> = {
	first: First,
	second: Second,
}

--[[
	Pair constuctor
]]
function utility.Pair.new <First, Second>(first: First, second: Second): Pair<First, Second>
	local self: Pair<First, Second> = {
		first = first,
		second = second,
	}

	return self
end

--[[
	# Поменять две переменные местами

	## Rarams:

	`Table1` - превая переменная

	`Table2` - вторая переменная
]]
function utility.swap (Table1: {}, Table2: {})
	Table1, Table2 = Table2, Table1
end

--[[
	Merge tables

	`t1` - таблица в которую добавятся элементы других таблиц

	`...` - tables that will be merged
]]
function utility.merge <Index1, Index2, Value1, Value2>(
	t1: { [Index1]: Value1 },
	...: { [Index2]: Value2 }
): {
	[Index1 | Index2]: Value1 | Value2,
}
	for _, t in pairs({ ... }) do
		for i, v in pairs(t) do
			t1[i] = v
		end
	end

	return t1
end

--[[
	Merge tables to new table

	
	`...` - tables that will be merged
]]
function utility.mergeToNew <Index, Value>(...: { [Index]: Value }): { [Index]: Value }
	local merged = {} -- result table

	for _, t in pairs({ ... }) do
		for i, v in pairs(t) do
			merged[i] = v
		end
	end

	return merged
end

--[[
	Compare tables by they values
]]
function utility.compare <Index, Value>(
	t1: { [Index]: Value },
	t2: { [Index]: Value }
): boolean
	if #t1 == #t2 then
		for i, v in pairs(t1) do
			if v ~= t2[i] then
				return false
			end
		end

		return true
	else
		return false
	end
end

return utility
