local TweenService = game:GetService("TweenService")

local models = {}

--[[
	Tween model to CFrame


	Example:
	--
	just move model to CFrame
	```luau
	local t = model.TweenModel(model, tweenInfo, CFrame):Play()
	```
]]
function models.TweenModel (model: Model, tweenInfo: TweenInfo, cFrame: CFrame): Tween
	local v = Instance.new("CFrameValue")

	local t = TweenService:Create(v, tweenInfo, {
		CFrame = cFrame,
	})

	v.Changed:Connect(function (newCFrame: CFrame)
		model:PivotTo(newCFrame)
	end)

	local d = model.Destroying:Connect(function() 
		t:Destroy()
	end)

	t.Destroying:Connect(function ()
		if d then
			d:Disconnect()
		end

		v:Destroy()
	end)

	return t
end

return models
