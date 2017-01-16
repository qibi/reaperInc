platform = {
	width = 0
	height = 0
	x = 0
	y = 0

}

player = {
	x = 0
	y = 0
	y_velocity = 0
	speed = 20
	img = nil
	jump_height = -300
	gravity = -500
	ground = 0
}

-- Called when game starts
function love.load()
	platform.width = love.graphics.getWidth()
	platform.height = 10
	platform.x = 0
	platform.y = love.graphics.getHeight() - platform.height
	player.img = love.graphics.newImage('assets/imgs/reaper.jpg')
	player.x = 0
	player.y = love.graphics.getHeight() - player.img:getHeight()
	player.ground = player.y
	player.speed = 20
	player.y_velocity = 0
	player.jump_height = -300
	player.gravity = -500
end

-- Called on every frame
function love.update(dt)
	if love.keyboard.isDown('d') then
		if player.x + player.img:getWidth() < love.graphics.getWidth() then
			player.x = player.x + player.speed * dt
		end
	elseif love.keyboard.isDown('a') then
		if player.x > 0 then
			player.x = player.x - player.speed * dt
		end
	end
	
	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end
	
	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end

	if player.y > player.ground then
		player.y_velocity = 0
		player.y = player.ground
	end
end

-- Called on every frame
function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
end
