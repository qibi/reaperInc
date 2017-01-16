
-- Called when game starts
function love.load()
	
	-- World
	world = love.physics.newWorld(0,500,true)
	
	-- Reaper
	reaper = {}
	reaper.img = love.graphics.newImage('assets/imgs/reaper.jpg')
	reaper.body = love.physics.newBody(world, 0, love.graphics.getHeight() - reaper.img:getHeight(), "dynamic")
	reaper.body:setMass(70)
	reaper.shape = love.physics.newRectangleShape(200,200)
	reaper.fixture = love.physics.newFixture(reaper.body, reaper.shape)
	reaper.fixture:setUserData("Reaper")

	-- Platform
	platform = {}
	platform.body = love.physics.newBody(world, 0, love.graphics.getHeight(), "static")
	platform.shape = love.physics.newRectangleShape(800,10)
	platform.fixture = love.physics.newFixture(platform.body, platform.shape)
	platform.fixture:setUserData("Platform")
end

-- Called on every frame
function love.update(dt)
	world:update(dt)

	if love.keyboard.isDown('d') then
		reaper.body:applyForce(500,0)
	elseif love.keyboard.isDown('a') then
		reaper.body:applyForce(-200,0)
	else
		reaper.body:setLinearVelocity(0,0)
	end
	if love.keyboard.isDown('space') then
	end
end

-- Called on every frame
function love.draw()
	love.graphics.polygon("fill", platform.body:getWorldPoints(platform.shape:getPoints()))
	love.graphics.draw(reaper.img, reaper.body:getX(), reaper.body:getY(), 0, 1, 1, 0, 32)
end
