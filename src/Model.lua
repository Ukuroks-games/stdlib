local TweenService = game:GetService("TweenService")

local model = {}

--[[
	Tween model to CFrame


	Example:
	--
	just move model to cframe
	```lua
	local t = model.TweenModel(modle, tweenInfo, cframe):Play()
	```

	Note: DO NOT FORGET DESTROY TWEEN WHERE YOU DESTROY MODEL!!!
	--
]]
function model.TweenModel(model: Model, tweenInfo: TweenInfo, cframe: CFrame): Tween
	local v = Instance.new("CFrameValue")
	
	local t = TweenService:Create(
		v,
		tweenInfo,
		{
			CFrame = cframe
		}
	)

	v.Changed:Connect(function(newCFrame: CFrame) 
		model:PivotTo(newCFrame)
	end)

	t.Destroying:Connect(function() 
		v:Destroy()
	end)

	return t
end

return model
