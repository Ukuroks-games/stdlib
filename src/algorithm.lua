--!nocheck

local utility = require(script.Parent.utility)

--[[
	# Алгоритмы

	Библиотека с алгоритмами для работы с таблицами
]]
local algorithm = {}

function algorithm.callForAll<T, Index>(Table: {[Index]: T}, startIndex: number?, endIndex: number?, callback: (i: Index)->nil)
	if startIndex or endIndex then
		for i = startIndex or 1, endIndex or #Table, 1 do
			callback(i)
		end
	else
		for i, _ in pairs(Table) do
			callback(i)
		end
	end
end

--[[
	# Проверить, что callback возвращает значение true для всех элементов в диапазоне [first, last].

	## Params:

	`Table` - Таблица из котрой ьерутся элементы

	`callback` - функция

	`first` - С какого индекса начинать (только если индекс у таблицы - number)

	`last` - До какого индекса (только если индекс у таблицы - number
]]
function algorithm.all_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean

	for i = first or 1, last or #Table, 1 do
		if not callback(Table[i]) then
			return false
		end
	end

	return true
end

--[[
	# Проверяет, что callback возвращает значение true для хотя бы одного элемента в диапазоне [first, last].

	## Params:

	`Table` - Таблица из котрой ьерутся элементы

	`callback` - функция

	`first` - С какого индекса начинать (только если индекс у таблицы - number)
	
	`last` - До какого индекса (только если индекс у таблицы - number
]]
function algorithm.any_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean
	for i = first or 1, last or #Table, 1 do
		if callback(Table[i]) then
			return true
		end
	end

	return false
end

--[[
	# Проверяет, что callback не возвращает значение true ни для одного элемента в диапазоне [first, last].

	## Params:

	`Table` - Таблица из котрой ьерутся элементы

	`callback` - функция

	`first` - С какого индекса начинать (только если индекс у таблицы - number)
	
	`last` - До какого индекса (только если индекс у таблицы - number
]]
function algorithm.none_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean

	for i = first or 1, last or #Table, 1 do
		if callback(Table[i]) then
			return false
		end
	end

	return true
end

--[[
	# суммирует или сворачивает ряд элементов 
]]
function algorithm.accumulate(Table: {number}, first: number?, last: number?, init: number?): number
	local sum = init or 0

	for i = first or 1, last or #Table, 1 do
		sum += Table[i]
	end

	return sum
end

function algorithm.find<Index, T>(Table: {[Index]: T}, value: T, startFind: Index?): Index?
	return table.find(Table, value, startFind)
end

--[[
	# Поиск с условием

	## Params:

	`Table` - Таблица в которой идёт поиск

	`callback` - функция, которая сравнивает значения из таблицы с каким то ещё значением

	## Returns:

	Индекс найденного значения, или `nil`
]]
function algorithm.find_if<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean, startFind: Index?, endFind: Index?): Index?

	for i = startFind or 1, endFind or #Table, 1 do
		if callback(Table[i]) then
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
function algorithm.find_if_not<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean, startFind: Index?, endFind: Index?): Index?

	for i = startFind or 1, endFind or #Table, 1 do
		if not callback(Table[i]) then
			return i
		end
	end

	return nil
end


function search_check<T>(t: {[number]: T}, start: number, range: {T}): boolean

	for i, v in pairs(range) do
		if not (t[start+i] == v) then
			return false
		end
	end

	return true
end

--[[
	# Находит последовательность элеметов в таблице
]]
function algorithm.search<T>(Table: {[number]: T}, range: {T}, start: number?, endFind: number?): number?
	
	for i = start or 1, endFind or #Table, 1 do
		if search_check(Table, i-1, range) then
			return i
		end
	end

	return nil
end

--[[
	# Находит последовательность еэлеметов в таблице
]]
function algorithm.search_n<T>(Table: {[number]: T}, range: {T}, start: number?, endFind: number?): number
	local counter = 0

	for i = start or 1, endFind or #Table, 1 do
		if search_check(Table, i-1) then
			counter += 1
		end
	end

	return counter
end

--[[
	# Отсортировать таблицу

	## Params:

	`Table` - Таблица, которую нужно отсортировать
]]
function algorithm.sort(Table: {[any]: any})
	table.sort(Table)
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

--[[
	# Проверить, отсоритрованна ли таблица

	## Params:

	`Table` - таблица, которую нужно  проверить
]]
function algorithm.is_sorted(Table: {[any]: any}, start: number?, endFind: number?): boolean
	local ret: boolean = true
	local last = nil
	
	for i = start or 1, endFind or #Table, 1 do
		if last then
			ret = ret and last < Table[i]
		else
			last = Table[i]
		end
	end

	return ret
end

--[[
	# Подчитать количество значений value в таблице

	## Params:

	`Table` - Таюлица, в которой искать

	`value` - значение, которое искать

	`startIndex` - 

	`endIndex` - 
]]
function algorithm.count<T, Index>(Table: {[Index]: T}, value: T, startIndex: Index?, endIndex: Index?): number
	local counter = 0

	local function f(i: Index)
		if Table[i] == value then
			counter += 1
		end
	end

	if startIndex or endIndex then
		for i = startIndex or 1, endIndex or #Table, 1 do
			f(i)
		end
	else
		for i, _ in pairs(Table) do
			f(i)
		end
	end

	return counter
end

--[[
	# Подчитать количество значений value в таблице с условием
	
	## Params:

	`Table` - Таюлица, в которой искать
]]
function algorithm.count_if<T, Index>(Table: {[Index]: T}, callback: (T)->boolean, startIndex: Index?, endIndex: Index?): number
	local counter = 0

	algorithm.callForAll(
		Table, 
		startIndex, 
		endIndex,
		function(i: Index)
			if callback(Table[i]) then
				counter += 1
			end
		end
	)

	return counter
end

--[[
	# Изменить порядок следования элементов в диапазоне [startIndex, endIndex) на противоположный. 

	## Params:

	`Table` - Таблица (меняется)

	`startIndex` - с какого индекса начинать

	`endIdex` - на котором закончить

	## Returns:

	Реверснутая таблица
]]
function algorithm.reverse<Index, T>(Table: {[Index]: T}, startIndex: number?, endIndex: number?): {[Index]: T}

	algorithm.callForAll(
		Table, 
		startIndex, 
		endIndex,
		function (i: Index)
			Table[i], Table[#Table-i+1] = Table[#Table-i+1], Table[i]
		end
	)

	return Table
end

--[[
	# Удалить все дубликаты из таблицы
]]
function algorithm.unique<Index, T>(Table: {[Index]: T}, startIndex: number?, endIndex: number?): {[Index]: T}
	
	local hash = {}
	local res = {}

	algorithm.callForAll(
		Table, 
		startIndex, 
		endIndex,
		function(i: Index)
			if (not hash[Table[i]]) then
				res[#res+1] = Table[i] -- you could print here instead of saving to result table if you wanted
				hash[Table[i]] = true
			end
		end
	)

	return res
end

--[[
	# Присвоить каждому элементу диапазона [first, last] значение, сгенерированное функцией generator

	## Params:

	`generator` - функция, генерующая значения

	`first` - с какого индекса начинать

	`last` - до какого индекса

	## Returns:

	Сгенерированная таблица
]]
function algorithm.generate<T>(generator: (i: number)->T, first: number, last: number): {T}
	local t = {}
	
	for i = first, last, 1 do
		t[i] = generator(i)
	end

	return t
end

--[[
	Получить индекс и значение наибольшего элемента в таблице
]]
function algorithm.max_element<Index, T>(Table: {[Index]: T}, startIndex: number?, endIndex: number?): utility.Pair<Index, T>
	local greatestNumber = -math.huge
	local k

	algorithm.callForAll(
		algorithm.copy(Table, startIndex, endIndex), 
		startIndex, 
		endIndex,
		function (i: Index)
			if Table[i] > greatestNumber then
				greatestNumber = Table[i]
				k = i
			end
		end
	)

	return utility.Pair.new(greatestNumber, k)
end

--[[
	Получить индекс и значение наменьшего элемента в таблице
]]
function algorithm.min_element<Index, T>(Table: {[Index]: T}, startIndex: number?, endIndex: number?): utility.Pair<Index, T>
	local greatestNumber = math.huge
	local k

	algorithm.callForAll(
		algorithm.copy(Table, startIndex, endIndex), 
		startIndex, 
		endIndex,
		function (i: Index)
			if Table[i] < greatestNumber then
				greatestNumber = Table[i]
				k = i
			end
		end
	)

	return utility.Pair.new(greatestNumber, k)
end

--[[
	# Копирует таблицу по одному свойству
]]
function algorithm.copy_by_prop<Index>(Table: {[Index]: {any}}, prop: string, startIndex: number?, endIndex: number?)
	local t = {}

	algorithm.callForAll(
		Table, 
		startIndex, 
		endIndex,
		function(i: Index)
			t[i] = Table[i][prop]
		end
	)

	return t
end

--[[
	# Копирует таблицу по с списку свойств
]]
function algorithm.copy_by_props<Index>(Table: {[Index]: {any}}, props: {string}, startIndex: number?, endIndex: number?): {[Index]: {}}
	local t = {}

	algorithm.callForAll(
		Table, 
		startIndex, 
		endIndex,
		function(i: Index)
			for _, prop in pairs(props) do
				t[i][prop] = Table[i][prop]
			end
		end
	)
	return t
end

function algorithm.copy<T>(Table: {[number]: T}, startIndex: number?, endIndex: number?): {[number]: T}
	
	if startIndex or endIndex then
		local t = {}
		
		for i = startIndex or 1, endIndex or #Table, 1 do
			t[i] = Table[i]
		end

		return t
	else
		return table.clone(Table)
	end
end

--[[
	Копировать элементы таблицы если элемент соответсвует условию
]]
function algorithm.copy_if<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean, startIndex: number?, endIndex: number?): {[Index]: T}
	local t = {}

	algorithm.callForAll(
		Table, 
		startIndex,
		endIndex, 
		function(i: Index): nil 
			if callback(Table[i]) then
				t[i] = Table[i]
			end
		end
	)

	return t
end

function algorithm.fill<T>(Table: {T}, value: T, startIndex: number?, endIndex: number?)

	algorithm.callForAll(
		Table, 
		startIndex,
		endIndex, 
		function(i)
			Table[i] = value
		end
	)
end

--[[
	Удалить элементы в диапазоне
	
]]
function algorithm.remove(Table: {[any]: any}, startIndex: number?, endIndex: number?)
	
	algorithm.callForAll(
		Table, 
		startIndex,
		endIndex, 
		function(i)
			table.remove(Table, i)
		end
	)	
end

function algorithm.remove_if<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean, startIndex: number?, endIndex: number?)
	
	algorithm.callForAll(
		Table, 
		startIndex,
		endIndex, 
		function(i)
			if callback(Table[i]) then
				table.remove(Table, i)
			end
		end
	)
	
end

--[[
	Среднее значение в таблице
]]
function algorithm.average(t: {number}): number
	return algorithm.accumulate(t) / #t
end

return algorithm
