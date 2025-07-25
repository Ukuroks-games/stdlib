--!nocheck
local utility = require(script.Parent.utility)

--[[
	# Алгоритмы

	Библиотека с алгоритмами для работы с таблицами
]]
local algorithm = {}

function algorithm.callForAll <T, Index>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?,
	callback: (i: Index) -> nil
)
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
function algorithm.all_of <T>(
	Table: { [any]: T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): boolean
	if startIndex or endIndex then
		for i = startIndex or 1, endIndex or #Table, 1 do
			if not callback(Table[i]) then -- приходится копипастить
				return false
			end
		end
	else
		for _, v in pairs(Table) do
			if not callback(v) then
				return false
			end
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
function algorithm.any_of <T>(
	Table: { [any]: T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): boolean
	if startIndex or endIndex then
		for i = startIndex or 1, endIndex or #Table, 1 do
			if callback(Table[i]) then
				return true
			end
		end
	else
		for _, v in pairs(Table) do
			if callback(v) then
				return true
			end
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

	`last` - До какого индекса (только если индекс у таблицы - number)
]]
function algorithm.none_of <T>(
	Table: { T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): boolean
	if startIndex or endIndex then
		for i = startIndex or 1, endIndex or #Table, 1 do
			if callback(Table[i]) then
				return false
			end
		end
	else
		for _, v in pairs(Table) do
			if callback(v) then
				return false
			end
		end
	end

	return true
end

--[[
	# суммирует(сворачивает по умному) ряд элементов 

	`Table`	- 

	`startIndex`	- 

	`endIndex`	- 

	`init`	- 
]]
function algorithm.accumulate (
	Table: { number },
	startIndex: number?,
	endIndex: number?,
	init: number?
): number
	local sum = init or 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i: number)
		sum += Table[i]
	end)

	return sum
end

--[[
	sum of squares
]]
function algorithm.accumulateSq (
	Table: { number },
	startIndex: number?,
	endIndex: number?,
	init: number?
): number
	local sum = init or 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i: number)
		sum += math.pow(Table[i], 2)
	end)

	return sum
end

--[[
	# суммирует(сворачивает по умному) ряд элементов по условию

	`Table`	- 

	`startIndex`	- 

	`endIndex`	- 

	`init`	- 
]]
function algorithm.accumulate_if (
	Table: { { number } },
	callback: (n: number) -> boolean,
	startIndex: number?,
	endIndex: number?,
	init: number?
): number
	local sum = init or 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i: number)
		if callback(Table[i]) then
			sum += Table[i]
		end
	end)

	return sum
end

--[[
	# суммирует(сворачивает по умному) параметры ряда элементов

	`Table`	- 

	`startIndex`	- 

	`endIndex`	- 

	`init`	- 
]]
function algorithm.accumulate_by_prop (
	Table: { { number } },
	prop: string,
	startIndex: number?,
	endIndex: number?,
	init: number?
): number
	local sum = init or 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i: number)
		sum += Table[i][prop]
	end)

	return sum
end

--[[
	Найти значение в таблице

	Возвращает индекс найденого числа

	`Table`	- 

	`value - 

	`startIndex`	- 

	`endIndex`	- 
]]
function algorithm.find <Index, T>(
	Table: { [Index]: T },
	value: T,
	startFind: Index?,
	endFind: Index?
): Index?
	if endFind then
		for i = startFind or 1, endFind do
			if Table[i] == value then
				return i
			end
		end

		return nil
	else
		return table.find(Table, value, startFind)
	end
end

--[[
	# Поиск с условием

	## Params:

	`Table` - Таблица в которой идёт поиск

	`callback` - функция, которая сравнивает значения из таблицы с каким то ещё значением

	## Returns:

	Индекс найденного значения, или `nil`
]]
function algorithm.find_if <T, Index>(
	Table: { [Index]: T },
	callback: (value: T) -> boolean,
	startFind: Index?,
	endFind: Index?
): Index?
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
function algorithm.find_if_not <T, Index>(
	Table: { [Index]: T },
	callback: (value: T) -> boolean,
	startFind: Index?,
	endFind: Index?
): Index?
	for i = startFind or 1, endFind or #Table, 1 do
		if not callback(Table[i]) then
			return i
		end
	end

	return nil
end

--[[
	Проверить есть ли ключ в таблице

	`Table`	- 

	`key`	- 
]]
function algorithm.check_key <T, Index>(Table: { [Index]: T }, key: Index): boolean
	return Table[key] ~= nil
end

--[[
	Функция сравнения
]]
local function defaultSearchCompare <T>(
	Table: { [number]: T },
	i: number,
	range: { [number]: T }
): boolean
	for j = 1, #range do
		if Table[i + j] ~= range[j] then
			return false
		end
	end

	return true
end

--[[
	# Находит последовательность элеметов в таблице

	возвращает индекс начала этой последовательности или nil

	
	`Table`	- 

	`startIndex`	- 

	`endIndex`	- 
]]
function algorithm.search <T>(
	Table: { [number]: T },
	range: { [number]: T },
	startIndex: number?,
	endIndex: number?,
	compare: ((
		i: number,
		range: { [number]: T }
	) -> boolean)?
): number?
	local cmp = compare or defaultSearchCompare

	for i = startIndex or 1, endIndex or #Table, 1 do
		if cmp(Table, i, range) then
			return i
		end
	end

	return nil
end

--[[
	# Находит последовательность элеметов в таблице
]]
function algorithm.search_n <T>(
	Table: { [number]: T },
	range: { T },
	start: number?,
	endFind: number?,
	compare: ((
		i: number,
		range: { [number]: T }
	) -> boolean)?
): number
	local counter = 0

	local cmp = compare or defaultSearchCompare

	for i = start or 1, endFind or #Table, 1 do
		if cmp(Table, i, range) then
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
function algorithm.sort (
	Table: { [any]: any },
	startIndex: number?,
	endIndex: number?
)
	if startIndex or endIndex then
		while not algorithm.is_sorted(Table, startIndex, endIndex) do
			algorithm.callForAll(Table, startIndex, endIndex - 1, function (i)
				if Table[i] > Table[i + 1] then
					Table[i], Table[i + 1] = Table[i + 1], Table[i]
				end
			end)
		end
	else
		table.sort(Table)
	end
end

--[[
	# Отсортировать таблицу с условием

	## Params:

	`Table` - Таблица, которую нужно отсортировать

	`callback` - функция
]]
function algorithm.sort_if <T>(
	Table: { [any]: T },
	callback: (T, T) -> boolean,
	startIndex: number?,
	endIndex: number?
)
	if startIndex or endIndex then
		while not algorithm.is_sorted(Table, startIndex, endIndex) do
			algorithm.callForAll(Table, startIndex, endIndex - 1, function (i)
				if callback(Table[i], Table[i + 1]) then
					Table[i], Table[i + 1] = Table[i + 1], Table[i]
				end
			end)
		end
	else
		table.sort(Table, callback)
	end
end

--[[
	Сортировка по свойтву
]]
function algorithm.sort_by (
	Table: { { [any]: number } },
	prop: string,
	startIndex: number?,
	endIndex: number?
)
	if startIndex or endIndex then
		while not algorithm.is_sorted_by(Table, prop, startIndex, endIndex) do
			algorithm.callForAll(Table, startIndex, endIndex - 1, function (i)
				if Table[i][prop] > Table[i + 1][prop] then
					Table[i], Table[i + 1] = Table[i + 1], Table[i]
				end
			end)
		end
	else
		table.sort(Table, function (a, b): boolean
			return a[prop] < b[prop]
		end)
	end
end

--[[
	# Проверить, отсоритрованна ли таблица по условию

	## Params:

	`Table` - таблица, которую нужно  проверить

	`callback` - функция сравнивающая прошлый элемент таблицы и текуший
]]
function algorithm.is_sorted_if <T>(
	Table: { [any]: T },
	callback: (last: T, current: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): boolean
	if startIndex or endIndex then
		for i = startIndex or 1, (endIndex or #Table) - 1, 1 do
			if callback(Table[i], Table[i + 1]) then -- сразу return как только найдено
				return false
			end
		end
	else
		local last
		for i, _ in pairs(Table) do
			if last then
				if callback(last, Table[i]) then
					return false
				end
			else
				last = Table[i]
			end
		end
	end

	return true
end

--[[
	# Проверить, отсоритрованна ли таблица (в порядке возрастания)

	## Params:

	`Table` - таблица, которую нужно  проверить
]]
function algorithm.is_sorted (
	Table: { [any]: number },
	startIndex: number?,
	endIndex: number?
): boolean
	return algorithm.is_sorted_if(
		Table,
		function (last: number, current: number): boolean
			return last > current
		end,
		startIndex,
		endIndex
	)
end

--[[
	# Проверить, отсоритрованна ли таблица

	## Params:

	`Table` - таблица, которую нужно  проверить
]]
function algorithm.is_sorted_by (
	Table: { [any]: { [any]: number } },
	prop: string,
	startIndex: number?,
	endIndex: number?
): boolean
	return algorithm.is_sorted_if(
		Table,
		function (a: { [any]: number }, b: { [any]: number }): boolean
			return a[prop] > b[prop]
		end,
		startIndex,
		endIndex
	)
end

--[[
	# Подчитать количество значений value в таблице

	## Params:

	`Table` - Таюлица, в которой искать

	`value` - значение, которое искать

	`startIndex` - 

	`endIndex` - 
]]
function algorithm.count <T, Index>(
	Table: { [Index]: T },
	value: T,
	startIndex: number?,
	endIndex: number?
): number
	local counter = 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if Table[i] == value then
			counter += 1
		end
	end)

	return counter
end

--[[
	# Подчитать количество значений value в таблице с условием
	
	## Params:

	`Table` - Таюлица, в которой искать
]]
function algorithm.count_if <T, Index>(
	Table: { [Index]: T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): number
	local counter = 0

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if callback(Table[i]) then
			counter += 1
		end
	end)

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
function algorithm.reverse <T>(
	Table: { [number]: T },
	startIndex: number?,
	endIndex: number?
): { [number]: T }
	local t

	if startIndex or endIndex then
		t = table.clone(Table)

		for _, i in pairs(t) do
			if
				(startIndex and i < startIndex) or (endIndex and i > endIndex)
			then
				t[i] = nil
			end
		end
	else
		t = Table
	end

	for i = startIndex or 1, math.floor((endIndex or #t) / 2), 1 do
		t[i], t[#Table - i + 1] = t[#Table - i + 1], t[i]
	end

	if startIndex or endIndex then
		return utility.merge(Table, t)
	else
		return t
	end
end

--[[
	# Удалить все дубликаты из таблицы
]]
function algorithm.unique <Index, T>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): { [Index]: T }
	local hash = {}
	local res = {}

	algorithm.callForAll(Table, startIndex, endIndex, function (i: Index)
		if not hash[Table[i]] then
			res[#res + 1] = Table[i] -- you could print here instead of saving to result table if you wanted
			hash[Table[i]] = true
		end
	end)

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
function algorithm.generate <T>(
	generator: (i: number) -> T,
	first: number,
	last: number
): { [number]: T }
	local t = {}

	for i = first, last, 1 do
		t[i] = generator(i)
	end

	return t
end

--[[
	Получить индекс и значение наибольшего элемента в таблице
]]
function algorithm.max_element <Index, T>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): { Num: T, Index: Index }
	local greatestNumber = -math.huge
	local k

	algorithm.callForAll(Table, startIndex, endIndex, function (i: Index)
		if Table[i] > greatestNumber then
			greatestNumber = Table[i]
			k = i
		end
	end)

	return {
		Num = greatestNumber,
		Index = k,
	}
end

--[[
	Получить индекс и значение наменьшего элемента в таблице
]]
function algorithm.min_element <Index, T>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): { Num: T, Index: Index }
	local minNumber = math.huge
	local k

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if Table[i] < minNumber then
			minNumber = Table[i]
			k = i
		end
	end)

	return {
		Num = minNumber,
		Index = k,
	}
end

--[[
	Получить наменьший индекс в таблице
]]
function algorithm.min_key <Index, T>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): number
	local minNumber = math.huge

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if i < minNumber then
			minNumber = i
		end
	end)

	return minNumber
end

--[[
	Получить наибольший индекс в таблице
]]
function algorithm.max_key <Index, T>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): number
	local minNumber = -math.huge

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if i > minNumber then
			minNumber = i
		end
	end)

	return minNumber
end

--[[
	# Копирует таблицу по одному свойству
]]
function algorithm.copy_by_prop <Index, T>(
	Table: { [Index]: { T } },
	prop: string,
	startIndex: number?,
	endIndex: number?
): { [Index]: T }
	local t = {}

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		t[i] = Table[i][prop]
	end)

	return t
end

--[[
	# Копирует таблицу по с списку свойств
]]
function algorithm.copy_by_props <Index>(
	Table: { [Index]: { any } },
	props: { string },
	startIndex: number?,
	endIndex: number?
): { [Index]: {} }
	local t = {}

	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		for _, prop in pairs(props) do
			t[i][prop] = Table[i][prop]
		end
	end)

	return t
end

--[[
	Копировать элементы таблицы
]]
function algorithm.copy <T, Index>(
	Table: { [Index]: T },
	startIndex: number?,
	endIndex: number?
): { [Index]: T }
	if startIndex or endIndex then
		-- copy
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
function algorithm.copy_if <T, Index>(
	Table: { [Index]: T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
): { [Index]: T }
	-- copy
	local t = {}

	algorithm.callForAll(Table, startIndex, endIndex, function (i: Index)
		if callback(Table[i]) then
			t[i] = Table[i]
		end
	end)

	return t
end

--[[
	Заполнить таблицу значением
]]
function algorithm.fill <T>(
	Table: { [any]: T },
	value: T,
	startIndex: number?,
	endIndex: number?
)
	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		Table[i] = value
	end)
end

--[[
	Удалить элементы в диапазоне
	
]]
function algorithm.remove (
	Table: { [any]: any },
	startIndex: number?,
	endIndex: number?
)
	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		table.remove(Table, i)
	end)
end

--[[
	Удалить элементы соответсвующие условию
]]
function algorithm.remove_if <T>(
	Table: { T },
	callback: (value: T) -> boolean,
	startIndex: number?,
	endIndex: number?
)
	algorithm.callForAll(Table, startIndex, endIndex, function (i)
		if callback(Table[i]) then
			table.remove(Table, i)
		end
	end)
end

--[[
	Set all table keys to value
]]
function algorithm.setAll (t: { [any]: any }, value: any)
	for i, _ in pairs(t) do
		t[i] = value
	end
end

--[[
	Вычислить что-то и закешировать это. Если в кеше значения нет этого, то посчитатьт и записать в кеш
]]
function algorithm.cached_calc <ARG, VALUE>(
	cacheTable: { [ARG]: VALUE },
	val: ARG,
	calc: (val: ARG) -> VALUE
): VALUE
	if cacheTable[val] == nil then
		cacheTable[val] = calc(val)
	end

	return cacheTable[val]
end

return algorithm
