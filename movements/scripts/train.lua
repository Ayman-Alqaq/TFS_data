local config = {
	time = 360, -- minutes
	str = 98765, -- storage
	pos = {x = 21155, y = 16535, z = 7} -- position
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

	local function isTraining(uid)
		local self = Player(uid)
		if not self then return false end
		return self:getStorageValue(config.str) > 0 and self:teleportTo(config.pos) or true
	end

	check = addEvent(isTraining, config.time * 60 * 1000, player:getGuid())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[Trainer]: You may now idle. To avoid being kicked, move every  ' .. config.time/60 .. ' hours.')
	return player:setStorageValue(config.str, 1)
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

	return stopEvent(check) and player:setStorageValue(config.str, -1)
end
