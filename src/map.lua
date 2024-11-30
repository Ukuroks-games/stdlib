local map = {}
map.__index = map

function map.new()
    return setmetatable({
        data = {}
    }, map)
end
