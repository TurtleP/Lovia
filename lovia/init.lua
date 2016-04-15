--[[
	Lövia

	Löve virtual input agent

	Designed to be simple and efficient

	:: Usable on
	Löve for Android
	Löve for iOS

	v1.0
--]]

local path = ...
local assetPath = path:gsub('%.', '/') .. '/assets/'

require (path .. "/lua/directionalinput")
require (path .. "/lua/directionbutton")
require (path .. "/lua/virtualbutton")

local lovia = {}

local config =
{
	directionalPadWidth = 80,
	directionalPadHeight = 80,

	touchReleasedColor =  {58, 55, 55, 160},
	touchPressedColor = {197, 200, 200, 160},

	scalarX = 1,
	scalarY = 1
}

directionalButtonGraphic = love.graphics.newImage(assetPath .. "directionalButton.png")

directionalButtonGraphicPressed = love.graphics.newImage(assetPath .. "directionalButtonPressed.png")

function lovia.createDirectionalPad(x, y, ...)
	return newDirectionalPad(x, y, config.directionalPadWidth, config.directionalPadHeight, ...)
end

function lovia.createVirtualButton(x, y, text, ...)
	return newVirtualButton(x, y, text, config.touchReleasedColor, config.touchPressedColor, ...)
end

function lovia.setScalar(scalarX, scalarY)
	config.scalarX = scalarX
	config.scalarY = scalarY
end

function lovia.insideElement(x, y, width, height, xMouse, yMouse)
	xMouse, yMouse = xMouse / config.scalarX, yMouse / config.scalarY

	return (xMouse > x) and (xMouse < x + width) and (yMouse > y) and (yMouse < y + height)
end

return lovia