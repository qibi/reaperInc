
-- Called when game starts
function love.load()	
	-- World
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81*64, true)
	
	-- Reaper
	reaper = {}
	reaper.img = love.graphics.newImage('assets/imgs/reaper.jpg')
	reaper.body = love.physics.newBody(world, 0, love.graphics.getHeight() - reaper.img:getHeight(), "dynamic")
	reaper.body:setMass(70)
	reaper.shape = love.physics.newRectangleShape(200,200)
	reaper.fixture = love.physics.newFixture(reaper.body, reaper.shape)
	reaper.fixture:setRestitution(0.1)
	reaper.fixture:setUserData("Reaper")

	-- Platform
	p1 = {}
	p2 = {}
	platforms = { }
	p1.body = love.physics.newBody(world, 0, love.graphics.getHeight(), "static")
	p1.shape = love.physics.newRectangleShape(800,50)
	p1.fixture = love.physics.newFixture(p1.body, p1.shape)
	p1.fixture:setUserData("Platform1")
	p2.body = love.physics.newBody(world, 400, love.graphics.getHeight(), "static")
	p2.shape = love.physics.newRectangleShape(50,120)
	p2.fixture = love.physics.newFixture(p2.body, p2.shape)
	p2.fixture:setUserData("Platform2")
	platforms[0] = p1
	platforms[1] = p2
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
	if key == 'space' and next(reaper.body:getContactList()) ~= nil then
		reaper.body:applyLinearImpulse(0,30000)
	end
end

-- Called on every frame
function love.draw()
	love.graphics.polygon("fill", platforms[0].body:getWorldPoints(platforms[0].shape:getPoints()))
	love.graphics.polygon("fill", platforms[1].body:getWorldPoints(platforms[1].shape:getPoints()))
	love.graphics.draw(reaper.img, reaper.body:getX(), reaper.body:getY(), reaper.body:getAngle(),  1, 1, reaper.img:getWidth()/2, reaper.img:getHeight()/2)
end
