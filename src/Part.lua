local types = require(script.Parent.types)
local Part = {}

--[[
	Прикрепить один `Part` к другому
	-

	можно пихать не только `Part`ы, но и другие любые типы имеющие CFrame

	Чтобы отменить привязку, вызовите `Disconnect()` у возвращаемого соединения

	Example:
	--
	```lua
	local anchor = Part.AnchorTo(AnchoredPart, AnchorPart)
	-- somethings
	anchor:Disconnect()
	```
]]
function Part.AnchorTo(AnchoredPart: { CFrame: CFrame }, AnchorPart: types.DefaultInstance & { CFrame: CFrame }, Offset: CFrame?): RBXScriptConnection
	
	local c = AnchorPart.Changed:Connect(function(prop: string) 
		if prop == "CFrame" then
			AnchoredPart.CFrame = AnchorPart.CFrame * (Offset or CFrame.new(0,0,0))
		end
	end)

	return c
end

return Part
