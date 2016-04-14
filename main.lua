lovia = require 'lovia'

love.graphics.setDefaultFilter("nearest", "nearest")

--[[
	TECH DEMO THING
--]]

function newBullet(x, y)
	local bullet = {}

	bullet.x = x
	bullet.y = y

	function bullet:update(dt)
		self.y = self.y - 120 * dt
	end

	function bullet:draw()
		love.graphics.rectangle("fill", self.x, self.y, 2, 2)
	end

	return bullet
end

function newPlayer(x, y)
	local player = {}

	player.x = x
	player.y = y

	player.rightKey = false
	player.leftKey = false

	player.shootKey = false

	function player:update(dt)
		if self.rightKey then
			self.x = self.x + 120 * dt
		elseif self.leftKey then
			self.x = self.x - 120 * dt
		end
	end

	function player:moveRight(move)
		self.rightKey = move
	end

	function player:moveLeft(move)
		self.leftKey = move
	end

	function player:shootBullet(shoot)
		if not self.shoot then
			table.insert(bullets, newBullet(self.x, self.y))
			self.shoot = true
		elseif not shoot then
			self.shoot = false
		end
	end

	function player:draw()
		love.graphics.rectangle("fill", self.x, self.y, 4, 4)
	end

	return player
end

function love.load()
	bullets = {}

	player = newPlayer(100, 160)

	local buttonPush =  
	{
		nil, 
		function()
			player:moveRight(true) 
		end, 
		nil, 
		function() 
			player:moveLeft(true)
		end
	}

	local buttonRelease = 
	{
		nil, 
		function()
			player:moveRight(false)
		end, 
		nil, 
		function() 
			player:moveLeft(false)
		end
	}

	directionalPad = lovia.createDirectionalPad(10, 100, buttonPush, buttonRelease)
	shootKey = lovia.createVirtualButton(178, 145, "Fire", function() player:shootBullet(true) end, function() player:shootBullet(false) end)

	love.window.setMode(200, 180)
end

function love.update(dt)
	for k, v in pairs(bullets) do
		v:update(dt)
	end

	player:update(dt)
end

function love.draw()
	directionalPad:draw()
	shootKey:draw()

	for k, v in pairs(bullets) do
		v:draw()
	end

	player:draw()
end

if love.system.getOS() == "Android" or love.system.getOS() == "iOS" then
	function love.touchpressed(id, x, y, pressure)
		directionalPad:touchPressed(id, x, y)

		shootKey:touchPressed(id, x, y)
	end

	function love.touchreleased(id, x, y, pressure)
		directionalPad:touchReleased(id, x, y)

		shootKey:touchReleased(id, x, y)
	end

	function love.touchmoved(id, x, y, pressure)
		directionalPad:touchMoved(id, x, y)

		shootKey:touchMoved(id, x, y)
	end
	return
end

function love.mousepressed(x, y, button)
	directionalPad:touchPressed(1, x, y, button)
	shootKey:touchPressed(1, x, y, button)
end

function love.mousemoved(x, y)
	if love.mouse.isDown(1) then
		directionalPad:touchMoved(1, x, y)

		shootKey:touchMoved(1, x, y)
	end
end

function love.mousereleased(x, y, button)
	directionalPad:touchReleased(1, x, y, button)
	shootKey:touchReleased(1, x, y, button)
end