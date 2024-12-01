
local vector = {}
vector.__index = vector

export type vector<T> = typeof(setmetatable(
	{} :: {
		_data: {
		[number]: T
	}	
	}, vector
))

function vector.new<T>(): vector<T>
	local self = setmetatable({
		_data = {},
	}, vector)
	
	return self
end

function vector.empty<T>(self: vector<T>): boolean
	return #self._data == 0
end

function vector.pop_back<T>(self: vector<T>): any
	return table.remove(self._data, #self._data)
end

function vector.push_back<T>(self: vector<T>, value: T)
	table.insert(self._data, value)
end

function vector.at<T>(self: vector<T>, index: number): T?
	if #self.data >= index then
		return self._data[index]
	else
		return nil
   end
end

function vector.clear<T>(self: vector<T>)
	table.clear(self._data)
end

function vector:erase<T>(self: vector<T>, startIndex: number, endIndex: number?)
	if endIndex then
		for i = 1, endIndex - startIndex do
			table.remove(self._data, startIndex + i)
		end
	else
		table.remove(self._data, startIndex)
	end
end

function vector.find<T>(self: vector<T>, value: T): number?
	return table.find(self._data, value)
end

function vector.swap<T>(self: vector<T>, anotherVactor: vector<T>): vector<T>
	local buff = anotherVactor

	anotherVactor = self
	self = buff
	
	return anotherVactor
end

return vector
