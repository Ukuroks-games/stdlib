local TweenService = game:GetService("TweenService")

local models = {}

--[[
	Tween model to CFrame


	Example:
	--
	just move model to cframe
	```lua
	local t = model.TweenModel(model, tweenInfo, cframe):Play()
	```

	> DO NOT FORGET DESTROY TWEEN WHERE YOU DESTROY MODEL!!!
]]
function models.TweenModel (model: Model, tweenInfo: TweenInfo, cframe: CFrame): Tween
	local v = Instance.new("CFrameValue")

	local t = TweenService:Create(v, tweenInfo, {
		CFrame = cframe,
	})

	v.Changed:Connect(function (newCFrame: CFrame)
		model:PivotTo(newCFrame)
	end)

	t.Destroying:Connect(function ()
		v:Destroy()
	end)

	return t
end

return models
