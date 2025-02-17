--[[
	Vector class
]]
local vector = {}
vector.__index = vector

export type vector<T> = typeof(setmetatable(
	{} :: {
		data: {
			[number]: T
		}	
	}, vector
))

--[[
	# Создать вектор
]]
function vector.new<T>(init: {}?): vector<T>
	local self = setmetatable({
		data = init or {},
	}, vector)
	
	setmetatable(self, {__index = self.data})

	return self
end

--[[
	# Провить, пустой ли вектор
]]
function vector:empty<T>(): boolean
	return #self.data == 0
end

--[[
	Получить размер массива
]]
function vector:size<T>(): number
	return #self.data
end

--[[
	Удалить последний элемент
]]
function vector:pop_back<T>(): T?
	return table.remove(self.data, #self.data)
end

--[[
	добавить элемент в конец
]]
function vector:push_back<T>(value: T)
	table.insert(self.data, value)
end

function vector:at<T>(index: number): T?
	if #self.data >= index then
		return self.data[index]
	else
		return nil
   end
end

--[[
	Очистить вектор
]]
function vector:clear<T>()
	table.clear(self.data)
end

--[[
	Удалить элемент или элементы
]]
function vector:erase<T>(startIndex: number, endIndex: number?)
	if endIndex then
		for i = 1, endIndex - startIndex do
			table.remove(self.data, startIndex + i)
		end
	else
		table.remove(self.data, startIndex)
	end
end


return vector
