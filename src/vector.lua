
local vector = {}

vector.Class = {}

export type vector<T> = typeof(setmetatable(
	{} :: {
		_data: {
			[number]: T
		}	
	}, vector
))

--[[
	# Создать вектор
]]
function vector.new<T>(init: {}?): vector<T>
	local self = setmetatable({
		_data = init or {},
	}, vector.Class)
	
	setmetatable(self, {__index = self._data})

	return self
end

--[[
	# Провить, пустой ли вектор
]]
function vector.Class.empty<T>(self: vector<T>): boolean
	return #self._data == 0
end

--[[
	Получить размер массива
]]
function vector.Class.size<T>(self: vector<T>): number
	return #self._data
end

--[[
	Удалить последний элемент
]]
function vector.Class.pop_back<T>(self: vector<T>): T?
	return table.remove(self._data, #self._data)
end

--[[
	добавить элемент в конец
]]
function vector.Class.push_back<T>(self: vector<T>, value: T)
	table.insert(self._data, value)
end

function vector.Class.at<T>(self: vector<T>, index: number): T?
	if #self._data >= index then
		return self._data[index]
	else
		return nil
   end
end

--[[
	Очистить вектор
]]
function vector.Class.clear<T>(self: vector<T>)
	table.clear(self._data)
end

--[[
	Удалить элемент или элементы
]]
function vector.Class.erase<T>(self: vector<T>, startIndex: number, endIndex: number?)
	if endIndex then
		for i = 1, endIndex - startIndex do
			table.remove(self._data, startIndex + i)
		end
	else
		table.remove(self._data, startIndex)
	end
end

--[[
	найти в векторе
]]
function vector.Class.find<T>(self: vector<T>, value: T): number?
	return table.find(self._data, value)
end

return vector
