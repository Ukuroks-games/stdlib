--[[
	Библиотека работы с ивентами
]]
local Events = {}

--[[
	Создаёт ивент, который запускается при запуске любого из ивентов указаных в аргументе функции

	Возвращает BindableEvent и список RBXScriptConnection для возможности потом убрать нектоторые ивенты
]]
function Events.AnyEvent <Index>(
	events: { [Index]: RBXScriptSignal },
	...: BindableEvent
): (
	BindableEvent,
	{ [Index]: RBXScriptConnection }
)
	local bEvents: { BindableEvent } = {}

	if #{ ... } == 0 then
		bEvents = { [1] = Instance.new("BindableEvent") }
	else
		bEvents = { ... }
	end

	local connections = {}

	for i, v in pairs(events) do
		connections[i] = v:Connect(function(...: any) 
			for _, event in pairs(bEvents) do 
				event:Fire(...)
			end
		end)
	end

	for _, event in pairs(events) do
		event.Destroying:Connect(function (...: any)
			for _, v in pairs(connections) do
				if v then
					v:Disconnect()
				end
			end
		end)
	end

	return bEvents[1], connections
end

return Events
