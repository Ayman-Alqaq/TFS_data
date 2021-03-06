-- summon heal master v1.1
-- by leyendario edited by Tejdi with zbizus help.
	local config = {
	heal = math.random(237, 475),
	condition = "yes", -- put no if you dont want him to remove the conditions (fire, poison, etc).
	}
function onThink(cid, target)
if math.random(1, 100) <= 42 then -- here you can edit chance of reciving heal, higher number than 12 = more heal chances
	local master = getCreatureMaster(cid)
	if master then
		local conditions = {CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN, CONDITION_CURSED}
		local party = getPartyMembers(master)
		local pos = getCreaturePosition(master)
		if not getPlayerParty(master) then
			doCreatureAddHealth(master, config.heal)
			doSendMagicEffect(pos, 12)
			if (config.condition == "yes") then
				for i, todos in ipairs(conditions) do
					doRemoveCondition(master, todos)
				end
			end
			return true
		end
		for _, miembros in pairs(party) do
			doCreatureAddHealth(miembros, config.heal)
			pos = getCreaturePosition(miembros)
			doSendMagicEffect(pos, 12)
			if (config.contidion == "yes") then
				for i, todos in ipairs(conditions) do
					doRemoveCondition(miembros, todos)
				end
			end
		end
	end
	return true
end
end