local queue = require(game:GetService("ReplicatedStorage").Packages.queue)

local t = {1, 2, 3, 4}

local queue1 = queue.new(t)

for i, v in pairs(t) do
	if queue1:front() == v then
		queue1:pop()
	else
		error("Test failed "..tostring(queue1:front()).."!="..tostring(v))
	end
end

print("Test passed!")
