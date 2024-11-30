
local vector = {}
vector.__index = vector

export type array = {
    data: {
        [number]: any
    }    
}

function vector.new()
    local arr: array = {
        data = nil
    }
    local ret = setmetatable(arr, vector)

    return ret
end

function vector:pop_back(): any
    return table.remove(self.data, #self.data)
end

function vector:push_back(value: any)
    table.insert(self.array, value)
end

function vector:at(index: number): any?
    if #self.data >= index then
        return self.data[index]
    else
        return nil
   end
end

function vector:clear()
    table.clear(self.data)
end


function vector:erase(startIndex: number, endIndex: number?)
    if endIndex then
        for i = 1, endIndex - startIndex do
            table.remove(self.data, startIndex + i)
        end
    else
        table.remove(self.data, startIndex)
    end
end




return vector
