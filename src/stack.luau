local stack = {}
stack.__index = stack

export type Stack = typeof(setmetatable({} :: { data: {} }, stack))

--[[
	# Создать стэк
]]
function stack.new (init: {}?): Stack
	return setmetatable({ data = init or {} }, stack)
end

--[[
	# Проверить, пустой ли стэк

	## Returns:

	true, если стек пустой, иначе false
]]
function stack:empty (): boolean
	return #self._data == 0
end

--[[
	# Получить размер стэка
]]
function stack:size (): number
	return #self._data
end

--[[
	# Добавить значение на вершину стэка
]]
function stack:push (value: any)
	table.insert(self._data, value)
end

--[[
	# Добавить сразу несколько зачений
]]
function stack:push_range (range: { any })
	for _, v in pairs(range) do
		self:push(v)
	end
end

--[[
	# получить значение с вершины стэка
]]
function stack:pop (): any
	if #self._data >= 1 then
		local val = self._data[#self._data]
		table.remove(self._data, #self._data)

		return val
	else
		warn("stack already empty")
		return nil
	end
end

return stack
