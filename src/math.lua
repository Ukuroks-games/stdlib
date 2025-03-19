--[[
	Расширенная математическая библиотека
]]
local _math = {}

--[[
	Число *℮*
]]
_math.e = 2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274274663919320030599218174135966290435729003342952605956307381323286279434907632338298807531952510190115738341879307021540891499348841675092447614606680822648001684774118537423454424371075390777449920695517027618386062613313845830007520449338265602976067371132007093287091274437470472306969772093101416928368190255151086574637721112523897844250569536967707854499699679468644549059879316368892300987931277361782154249992295763514822082698951936680331825288693984964651058209392398294887933203625094431173012381970684161403970198376793206832823764648042953118023287825098194558153017567173613320698112509961818815930416903515988885193458072738667385894228792284998920868058257492796104841984443634632449684875602336248270419786232090021609902353043699418491463140934317381436405462531520961836908887070167683964243781405927145635490613031072085103837505101157477041718986106873969655212671546889570350354

--[[
	Натуральный логарифм
]]
function _math.ln(n: number): number
	return math.log(n, _math.e)
end

_math.lg = math.log10

--[[
	Кеш факториаловs
]]
 local factoialCache = {
	[0] =	1,	-- 0!
	[1] =	1,	-- 1!
	[2] =	2,	-- 2!
	[3] =	6,	-- 3!
	[4] =	24,	-- 4!
	[5] =	120,	-- 5!
	[6] =	720,	-- 6!
	[7] =	5_040,	-- 7!
	[8] =	40_320,	-- 8!
	[9] =	362_880,	-- 9!
	[10] =	3_628_800,	-- 10!
	[11] =	39_916_800,	-- 11!
	[12] =	479_001_600,	-- 12!
	[13] =	6_227_020_800,	-- 13!
	[14] =	87_178_291_200,	-- 14!
	[15] =	1_307_674_368_000,	-- 15!
	[16] =	20_922_789_888_000,	-- 16!
	[17] =	355_687_428_096_000,	-- 17!
	[18] =	6_402_373_705_728_000, 	-- 18!
	[19] =	121_645_100_408_832_000,	-- 19!
	[20] =	2_432_902_008_176_640_000,	-- 20!
	[21] =	51_090_942_171_709_440_000,	-- 21!
	[22] =	1_124_000_727_777_607_680_000,	-- 22!
--	[23] = 	25_852_016_738_884_976_640_000	-- 23!	-- toooooooooo big number for double
}

--[[
	delta for calculate integral

	чем меньше, тем точнее и медленне
]]
_math.defaultDelta = 1e-5

--[[
	Факториал только для целых чисел
]]
function _math.factorialZ(n: number): number
	assert(n >= 0, "Complex Infinity")

	if factoialCache[n] == nil then
		factoialCache[n] = _math.factorialZ(n - 1) * n
	end

	return factoialCache[n]
end

--[[
	Кеш Гамма функции
]]
local GammaCache = {
	--[0.5] = math.sqrt(math.pi),
	[1.5] = math.sqrt(math.pi) / 2,
	[-0.5] = 2 * math.sqrt(math.pi),
}

--[[
	Magic Gamma function

	I have no idea what the hell is going on here. Taken from: http://rosettacode.org/wiki/Gamma_function#Lua

	Точность примерно до 3-х знаков после запятой
]]
local function gamma(x)
	local gamma	=  0.577215664901
	local coeff	= -0.65587807152056
	local quad	= -0.042002635033944
	local qui	=  0.16653861138228
	local set	= -0.042197734555571

	local function recigamma(z)
		return z + gamma * z^2 + coeff * z^3 + quad * z^4 + qui * z^5 + set * z^6
	end
   
	local function gammafunc(z)
		if z == 1 then 
			return 1
		elseif math.abs(z) <= 0.5 then 
			return 1 / recigamma(z)
		else 
			return (z - 1) * gammafunc(z - 1)
		end
	end

	return gammafunc(x)
end

--[[
	Гамма функция

	Для целых чисел

	Кеширует свои значения
]]
function _math.gamma(n: number): number
	if GammaCache[n] == nil then	-- if cache not exist, calculate it
		if n % 1 == 0 and n >= 1 then
			GammaCache[n] = _math.factorialZ(n - 1)
		else
			GammaCache[n] = gamma(n)
		end
	end
	
	return  GammaCache[n]
end

--[[
	Cache for beta function
]]
local BetaChache = {}

--[[
		Beta function
]]
function _math.beta(x: number, y: number): number

	local args = {x = x, y = y}

	if BetaChache[args] == nil then
		BetaChache[args] = (_math.gamma(x) * _math.gamma(y)) / _math.gamma(x + y)
	end

	return BetaChache[args]
end

--[[
	Факториал

	return n!
]]
function _math.factorial(n: number): number
	
	if factoialCache[n] == nil then	-- if cache not exist
		if n % 1 == 0 then	-- if n is integer
			factoialCache[n] = _math.factorialZ(n - 1) * n
		else
			factoialCache[n] = _math.gamma(n + 1)
		end
	end

	return factoialCache[n]

end

--[[
	корень произвольной степени
]]
function _math.root(n: number, base: number): number 
	return math.pow(n, 1 / base)
end

--[[
	Вычисление интеграла от a до b

	>	∫f(x)dx
	
	Должны соблюдаться условия(иначе бесконечный цикл будет):
	+ delta ≠ 0
	+ delta > 0 ⇒ a < b
	+ delta < 0 ⇒ a > b

	
	> интересное наблюдение: количество верных цифр d результаьте равно кол-ву нулей в delta
]]
function _math.integral(f: (x: number) -> number, a: number, b: number, delta: number?): number

	local _delta = delta or _math.defaultDelta

	local n = 0

	for i = a, b, _delta do
		n += f(i) * _delta
	end

	return n
end

--[[
	Сравнить два дробных числа с определённой точностью

	по умолчанию точность равна `_math.defaultDelta`

	возвращает true если `a` ≈ `b`, `precision` допустимое расхождение
]]
function _math.floatcmp(a: number, b: number, precision: number?): boolean
	return (a - b) < (precision or _math.defaultDelta)
end

return _math
