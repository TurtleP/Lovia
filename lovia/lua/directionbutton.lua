function newDirectionButton(x, y, key, rotation, onHeld, onRelease)
	local directionButton = {}

	directionButton.x = x
	directionButton.y = y

	local width, height = 32, 16
	if rotation == math.pi / 2 or rotation == math.pi * 3 / 2 then
		width, height = 16, 32

		directionButton.sides = true
	end

	directionButton.width = width
	directionButton.height = height

	directionButton.button = button

	directionButton.rotation = rotation

	directionButton.held = false

	directionButton.onHeld = onHeld
	directionButton.onRelease = onRelease

	function directionButton:draw()
		local graphic = directionalButtonGraphic
		if self.held then
			graphic = directionalButtonGraphicPressed
		end
		love.graphics.draw(graphic, self.x + (self:getWidth() / 2), self.y + (self:getHeight() / 2), self.rotation, 1, 1, self:getWidth() / 2, self.getHeight() / 2)
	end

	function directionButton:touchPressed(id, x, y, pressure)
		local offsetX, offsetY = 0, 0
		if self.sides then
			offsetX, offsetY = self.width / 2, -8
		end

		return lovia.insideElement(self.x + offsetX, self.y + offsetY, self.width, self.height, x, y)
	end

	function directionButton:setHeld(id, isHeld, isReleased)
		if isHeld then
			self.held = id
		end

		if self.held == id then
			if isHeld then
				if self.onHeld then
					self.onHeld()
				end
			else
				if self.onRelease then
					self.onRelease()
				end
			end

			if isReleased then
				if self.onRelease then
					self.onRelease()
				end
			end

			if not isHeld then
				self.held = false
			end
		end
	end

	function directionButton:getWidth()
		return directionalButtonGraphic:getWidth()
	end

	function directionButton:getHeight()
		return directionalButtonGraphic:getHeight()
	end

	return directionButton
end