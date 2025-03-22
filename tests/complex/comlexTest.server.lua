local ReplicatedStorage = game:GetService("ReplicatedStorage")

local load = function (chunk, _, __, context)
	for key, value in pairs (context) do
		_G [key] = value
	end
	return loadstring (chunk)
end

local complex = require(ReplicatedStorage.Packages.complex)
local testlib = require(ReplicatedStorage.DevPackages.testlib)

local context = {
    complex = complex,
    pi = math.pi,
    i = complex.i,
    x = complex (0, 10),
    y = complex (-5, 5),
    z = complex (5),
    list = function (...)
    	local serialised = {}
    	for i, item in ipairs {...} do
    		serialised [i] = tostring (item)
    	end
    	return table.concat (serialised, ', ')
    end
}

local cases = {
    'x', 'y', 'z', 'x:abs ()', 'i', '2 + i',
    'x + y', 'x - y', 'x + 12', 'x - 12', '12 + x', '12 - x',
    'x * y', 'y * 12', '2 * x',
    'y:conjugate ()', 'x / y', 'y / y', 'x / 5', '5 / x', '5 / x * x', '10 / z',
    'y:abs ()', 'y:arg () / pi * 180',
    'complex.polar (2, pi / 4)', 'complex.polar (2, 0)', 'complex.polar (2, pi / 2)', 'y:exp ()',
    'x ^ 2', 'z ^ 2', '2 ^ y', '2 ^ x',
    'list (x:roots (2))', 'list (y:roots (3))', 'list (z:roots (2))', 'list((-z):roots (2))',
    'x == y', 'x ~= y', 'x < y', 'x > y', 'x <= y', 'x >= y'
}

for i, expr in ipairs (cases) do
    testlib:AddTest(
        testlib.test.new(
            script.Name .. i,
            function(): boolean 
                return load ('return ' .. expr, nil, 't', context)()
            end
        )
    )
end

