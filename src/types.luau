--[[
	Instance который обычно используется везде
]]
export type DefaultInstance = Instance & Object

export type TableWithMetatable<T, Mt> = typeof(setmetatable({} :: T, {} :: Mt))

export type AnyTableABC<A, B, C> = {[A]: B} | TableWithMetatable<{[A]: B}, C>

export type AnyTable = AnyTableABC<any, any, {}>


return {}
