local stack = {}
stack.__index = stack


--[[
	# Создать стэк
]]
function stack.new(init: {}?)
	return setmetatable({data = init or {}}, stack)
end

--[[
	# Проверить, пустой ли стэк

	## Returns:

	true, если стек пустой, иначе false
]]
function stack:empty(): boolean
	return #self._data == 0
end

--[[
	# Получить размер стэка
]]
function stack:size(): number
	return #self.data
end

--[[
	# Добавить значение на вершину стэка
]]
function stack:push(value: any)
	table.insert(self._data, value)
end

--[[
	# Добавить сразу несколько зачений
]]
function stack:push_range(range:{any})
	for i, v in pairs(range) do
		self:push(v)
	end
end

--[[
	# получить значение с вершины стэка
]]
function stack:pop(): any
	if #self._data > 1 then
		return table.remove(self._data, #self._data)
	else
		warn("stack already empty")
		return nil
	end

end

return stack
