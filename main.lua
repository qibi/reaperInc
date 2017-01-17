
-- Called when game starts
function love.load()	
	-- World
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81*64, true)
	
	-- Reaper
	reaper = {}
	reaper.img = love.graphics.newImage('assets/imgs/reaper.jpg')
	reaper.body = love.physics.newBody(world, 0, love.graphics.getHeight() - reaper.img:getHeight(), "dynamic")
	reaper.body:setMass(reaper.img:getWidth()/2, reaper.img:getHeight()/2, 70, 1)
	reaper.shape = love.physics.newRectangleShape(200,200)
	reaper.fixture = love.physics.newFixture(reaper.body, reaper.shape)
	reaper.fixture:setRestitution(0.1)
	reaper.fixture:setUserData("Reaper")

	-- Platform
	platform = {}
	platform.body = love.physics.newBody(world, 0, love.graphics.getHeight(), "static")
	platform.shape = love.physics.newRectangleShape(800,50)
	platform.fixture = love.physics.newFixture(platform.body, platform.shape)
	platform.fixture:setUserData("Platform")
end

-- Called on every frame
function love.update(dt)
	world:update(dt)

	if love.keyboard.isDown('d') then
		reaper.body:applyLinearImpulse(50,0)
	elseif love.keyboard.isDown('a') then
		reaper.body:applyLinearImpulse(-50,0)
	else
		x,y = reaper.body:getLinearVelocity()
		reaper.body:setLinearVelocity(x/2,y)
	end
end

function love.keypressed(key)
	if key == "space" then
		if next(reaper.body:getContactList()) ~= nil then
			reaper.body:applyLinearImpulse(0,30000)
		end
	end
end

-- Called on every frame
function love.draw()
	love.graphics.polygon("fill", platform.body:getWorldPoints(platform.shape:getPoints()))
	love.graphics.draw(reaper.img, reaper.body:getX(), reaper.body:getY(), reaper.body:getAngle(),  1, 1, reaper.img:getWidth()/2, reaper.img:getHeight()/2)
end
