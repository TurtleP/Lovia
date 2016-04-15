--[[
	Virtual Button

	Makes it so there's buttons to tap
	Fancy stuff. Yeh.
--]]

function newVirtualButton(x, y, text, releasedColor, pressedColor, ...)
	local virtualbutton = {}

	virtualbutton.x = x
	virtualbutton.y = y

	virtualbutton.text = text

	virtualbutton.width = 32
	virtualbutton.height = 32

	local options = {...}
	
	virtualbutton.onHold = options[1]
	virtualbutton.onRelease = options[2]


	for _, v in pairs(options[3] or {}) do
		if v == "onRelease" then
			virtualbutton.onRelease = true
		end
	end

	virtualbutton.releasedColor = releasedColor
	virtualbutton.pressedColor = pressedColor

	virtualbutton.realX = x - 16
	virtualbutton.realY = y - 16

	virtualbutton.id = false

	function virtualbutton:touchPressed(id, x, y, pressure)
		self:touchMoved(id, x, y, pressure)
	end

	function virtualbutton:touchReleased(id, x, y, pressure)
		if self.id == id then
			if self.onRelease then
				self.onRelease()
			end
			self.id = false
		end
	end

	function virtualbutton:touchMoved(id, x, y, pressure)
		if lovia.insideElement(self.realX, self.realY, self.width, self.height, x, y) then
			self.id = id

			if self.onHold then
				self.onHold()
			end
		else
			self:touchReleased(id, x, y, pressure)
		end
	end

	function virtualbutton:draw()
		local color, textColor = self.releasedColor, self.pressedColor
		if self.id then
			color, textColor = self.pressedColor, self.releasedColor
		end

		love.graphics.setColor(color)

		love.graphics.circle("fill", self.x, self.y, 16)

		love.graphics.setColor(textColor)

		love.graphics.print(self.text, self.realX + (self.width / 2) - love.graphics.getFont():getWidth(self.text) / 2, self.realY + (self.height / 2) - love.graphics.getFont():getHeight() / 2)

		love.graphics.setColor(255, 255, 255, 255)
	end

	return virtualbutton
end