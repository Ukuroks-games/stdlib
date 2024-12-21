--!nocheck
local ReplicatedStorage = game:GetService("ReplicatedStorage")


--[[
	# Алгоритмы
]]
local algorithm = {}

--[[
	# Проверить, что callback возвращает значение true для всех элементов в диапазоне [first, last].

	## Params:

	`Table` - Таблица из котрой ьерутся элементы

	`callback` - функция

	`first` - С какого индекса начинать (только если индекс у таблицы - number)

	`last` - До какого индекса (только если индекс у таблицы - number
]]
function algorithm.all_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean

	if first and last then
		for i = first, last, 1 do
			if not callback(Table[i]) then
				return false
			end
		end
	elseif first and not last then
		for i = first, #Table, 1 do
			if not callback(Table[i]) then
				return false
			end
		end
	elseif not first and last then
		for i = 1, last, 1 do
			if not callback(Table[i]) then
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
function algorithm.any_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean
	if first and last then
		for i = first, last, 1 do
			local a = callback(Table[i])

			if a then
				return true
			end
		end
	elseif first and not last then
		for i = first, #Table, 1 do
			local a = callback(Table[i])

			if a then
				return true
			end
		end
	elseif not first and last then
		for i = 1, last, 1 do
			local a = callback(Table[i])

			if a then
				return true
			end
		end
	else
		for _, v in pairs(Table) do
			local a = callback(v)

			if a then
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
	
	`last` - До какого индекса (только если индекс у таблицы - number
]]
function algorithm.none_of<T>(Table: {T}, callback: (value: T)->boolean, first: number?, last: number?): boolean
	if first and last then
		for i = first, last, 1 do
			if callback(Table[i]) then
				return false
			end
		end
	elseif first and not last then
		for i = first, #Table, 1 do
			if callback(Table[i]) then
				return false
			end
		end
	elseif not first and last then
		for i = 1, last, 1 do
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
	# суммирует или сворачивает ряд элементов 
]]
function algorithm.accumulate(Table: {number}, first: number?, last: number?, init: number?): number
	local sum = init or 0

	for _, v in pairs(Table) do
		sum += v
	end

	return sum
end

--[[
	# Поиск с условием

	## Params:

	`Table` - Таблица в которой идёт поиск

	`callback` - функция, которая сравнивает значения из таблицы с каким то ещё значением

	## Returns:

	Индекс найденного значения, или `nil`
]]
function algorithm.find_if<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean): Index?
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
function algorithm.find_if_not<T, Index>(Table: {[Index]: T}, callback: (value: T)->boolean): Index?
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
function algorithm.is_sorted(Table: {[any]: any}): boolean
	local ret: boolean = true
	local last = nil

	for _, v in pairs(Table) do
		if last then
			ret = ret and last < v
		else
			last = v
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

--[[
	# Подчитать количество значений value в таблице с условием
	
	## Params:

	`Table` - Таюлица, в которой искать
]]
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
	# Изменить порядок следования элементов в диапазоне [startIndex, endIndex) на противоположный. 

	## Params:

	`Table` - Таблица (меняется)

	`startIndex` - с какого индекса начинать

	`endIdex` - на котором закончить

	## Returns:

	Реверснутая таблица
]]
function algorithm.reverse(Table: {[number]: any}, startIndex: number?, endIndex: number?): {[number]: any}

	if not startIndex then
		startIndex = 1
	end

	if not endIndex then
		endIndex = #Table
	end

	for i = startIndex, endIndex//2, 1 do
        Table[i], Table[#Table-i+1] = Table[#Table-i+1], Table[i]
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

--[[
	# Присвоить каждому элементу диапазона [first, last] значение, сгенерированное функцией generator

	## Params:

	`generator` - функция, генерующая значения

	`first` - с какого индекса начинать

	`last` - до какого индекса

	## Returns:

	Сгенерированная таблица
]]
function algorithm.generate<T>(generator: ()->T, first: number, last: number): {T}
	local t = {}
	
	for i = first, last, 1 do
		t[i] = generator()
	end

	return t
end

function algorithm.max_element<T>(Table: {T}, first: number?, last: number?): number

end


return algorithm