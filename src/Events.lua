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
	Event: BindableEvent?
): (
	BindableEvent,
	{ [Index]: RBXScriptConnection }
)
	local event: BindableEvent = Event or Instance.new("BindableEvent")
	local connections = {}

	for i, v in pairs(events) do
		connections[i] = v:Connect(function (...: any)
			event:Fire(...)
		end)
	end

	event.Destroying:Connect(function (...: any)
		for _, v in pairs(connections) do
			if v then
				v:Disconnect()
			end
		end
	end)

	return event, connections
end

return Events
