--!nocheck

--[[
	# Алгоритмы
]]
local algorithm = {}

--[[
	# Поменять две переменные местами

	## Rarams:

	`Table1` - превая переменная

	`Table2` - вторая переменная
]]
function algorithm.swap(Table1: any, Table2: any)
	local tmp = Table1

	Table1 = Table2

	Table2 = tmp
end

--[[
	# Поиск с условием

	## Params:

	`Table` - Таблица в которой идёт поиск

	`callback` - функция, которая сравнивает значения из таблицы с каким то ещё значением

	## Returns:

	Индекс найденного значения, или `nil`
]]
function algorithm.find_if<T>(Table: {[any]: T}, callback: (value: T)->boolean): any?
	for i, v in pairs(Table) do
		if callback(v) then
			return i
		end
	end

	return nil
end

--[[
	# Поиск с условием

	## Params:

	`Table` - Таблица в которой идёт поиск

	`callback` - функция, которая сравнивает значения из таблицы с каким то ещё значением, возвращаемое значение инвертируется

	## Returns:

	Индекс найденного значения, или `nil`
]]
function algorithm.find_if_not<T>(Table: {[any]: T}, callback: (value: T)->boolean): any?
	for i, v in pairs(Table) do
		if not callback(v) then
			return i
		end
	end

	return nil
end

--[[
	# Отсортировать таблицу

	## Params:

	`Table` - Таблица, которую нужно отсортировать
]]
function algorithm.sort(Table: {[any]: any})
	table.sort(Table)
end

function algorithm.is_sorted(Table: {[any]: any})
	local ret: boolean = true
	local last = nil
	for _, v in pairs(Table) do
		if last then
			ret = last < v
			if ret then 
				break
			end
		else
			last = v
		end
	end
end

--[[
	# Отсортировать таблицу с условием

	## Params:

	`Table` - Таблица, которую нужно отсортировать

	`callback` - функция
]]
function algorithm.sort_if<T>(Table: {[any]:T}, callback: (T, T)->boolean)
	table.sort(Table, callback)
end


function algorithm.count<T, Index>(Table: {[Index]: T}, value: T, startIndex: Index?, endIndex: Index?): number
	local counter = 0

	if (not startIndex) or (not endIndex) then
		for _, v in pairs(Table) do
			if v == value then
				counter += 1
			end
		end
	else
		for i = startIndex, endIndex, 1 do
			if Table[i] == value then
				counter += 1
			end
		end
	end

	return counter
end



function algorithm.count_if<T, Index>(Table: {[Index]: T}, callback: (T)->boolean, startIndex: Index?, endIndex: Index?): number
	local counter = 0

	if (not startIndex) or (not endIndex) then
		for _, v in pairs(Table) do
			if callback(v) then
				counter += 1
			end
		end
	else
		for i = startIndex, endIndex, 1 do
			if callback(Table[i]) then
				counter += 1
			end
		end
	end

	return counter
end

--[[
	Меняет порядок следования элементов в диапазоне [startIndex, endIndex) на противоположный. 

	## Params:

	`Table` - Таблица

	`startIndex` - с какого индекса начинать

	`endIdex` - каким индексоп продолжить
]]
function algorithm.reverse(Table: {[number]: any}, startIndex: number?, endIndex: number?): {[number]: any}

	if startIndex > #Table or endIndex > #Table then
		error("Wrong args!")
	end

	if not startIndex then
		startIndex = 1
	end

	if not endIndex then
		endIndex = #Table
	end

	for i = startIndex, endIndex/2, 1 do
		algorithm.swap(Table[i], Table[#Table - i])
	end

	return Table
end

--[[
	# Удалить все дубликаты из таблицы
]]
function algorithm.unique(Table: {[any]: any}): {[any]: any}
	
	local hash = {}
	local res = {}

	for _,v in ipairs(Table) do
		if (not hash[v]) then
			res[#res+1] = v -- you could print here instead of saving to result table if you wanted
			hash[v] = true
		end
	end

	return res
end



return algorithm