local stack = {}
stack.__index = stack


--[[
    # Создать стэк
]]
function stack.new()
    local self = setmetatable({}, stack)

    self.data = {}

    return self
end

--[[
    # Проверить, пустой ли стэк
]]
function stack:empty(): boolean
    return #self._data == 0
end

function stack:size(): number
    return #self.data
end

function stack:push(value: any)
    table.insert(self._data, value)
end

function stack:push_range(range:{any})
    for i, v in pairs(range) do
        self:push(v)
    end
end

function stack:pop()
    if #self._data > 1 then
        return table.remove(self._data, #self._data)
    else
        warn("stack already empty")
        return nil
    end

end

function stack:swap()
    
end
