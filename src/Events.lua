--[[
	Библиотека работы с ивентами
]]
local Events = {}

--[[
	Создаёт ивент, который запускается при запуске любого из ивентов указаных в аргументе функции

	Возвращает BindableEvent и список RBXScriptConnection для возможности потом убрать нектоторые ивенты
]]
function Events.AnyEvent <Index>(events: { [Index]: RBXScriptSignal }): (BindableEvent, { [Index]: RBXScriptConnection })
	local event: BindableEvent = Instance.new("BindableEvent")
	local connections = {}

	for i, v in pairs(events) do
		connections[i] = v:Connect(function (...: any)
			event:Fire(...)
		end)
	end

	return event, connections
end

return Events
