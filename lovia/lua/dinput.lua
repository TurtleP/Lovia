--[[
	Directional Pad Input

	Makes a D-Pad which is awesome
--]]

function newDirectionalPad(x, y, ...)
	local rotations =
	{
		0,
		math.pi / 2,
		math.pi,
		math.pi * 3 / 2
	}

	local directionPad = {}

	directionPad.x = x
	directionPad.y = y

	local args = {...}

	directionPad.width = args[1]
	directionPad.height = args[2]

	local keys = args[3]

	local onPush = args[4]
	local onRelease = args[5]

	directionPad.buttons = {}

	--Create four buttons for input
	table.insert(directionPad.buttons, newDirectionButton(directionPad.x + (directionPad.width / 2) - 16, directionPad.y, keys[1], 0, onPush[1], onRelease[1]))
		
	table.insert(directionPad.buttons, newDirectionButton(directionPad.x + (directionPad.width - 24), directionPad.y + directionPad.height / 2 - 8, keys[2], math.pi / 2, onPush[2], onRelease[2]))
		
	table.insert(directionPad.buttons, newDirectionButton(directionPad.x + (directionPad.width / 2) - 16, directionPad.y + directionPad.height - 16, keys[3], math.pi, onPush[3], onRelease[3]))
		
	table.insert(directionPad.buttons, newDirectionButton(directionPad.x - 8, directionPad.y + directionPad.height / 2 - 8, keys[4], math.pi * 3 / 2, onPush[4], onRelease[4]))

	function directionPad:draw()
		love.graphics.setColor(255, 255, 255, 160)

		for k, v in ipairs(self.buttons) do
			v:draw()
		end

		love.graphics.setColor(58, 55, 55, 160)

		love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, 16)

		love.graphics.setColor(255, 255, 255, 255)
	end

	function directionPad:touchPressed(id, x, y, pressure)
		self:touchMoved(id, x, y, pressure)
	end

	function directionPad:touchMoved(id, x, y, pressure)
		for k = 1, #self.buttons do
			local v  = self.buttons[k]

			if v:touchPressed(id, x, y, pressure) then
				v:setHeld(id, true)
			else
				v:setHeld(id, false)
			end
		end
	end

	function directionPad:touchReleased(id, x, y, pressure)
		for k = 1, #self.buttons do
			local v  = self.buttons[k]

			if v.held then
				v:setHeld(id, false, true)
			end
		end
	end

	return directionPad
end