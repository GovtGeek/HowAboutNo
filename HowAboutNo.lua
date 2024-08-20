local addonName, HowAboutNo = ...

-- New and improved? Trying not to pollute the global scope.
HowAboutNo._debug = false
HowAboutNo.WintergraspQuestIDs = {
	[13539] = true,
	[13181] = true,
	[13538] = true,
	[13196] = true,
	[13183] = true,
	[13153] = true,
	[13197] = true,
	[13191] = true,
	[13179] = true,
	[13192] = true,
	[13177] = true,
	[13195] = true,
	[13200] = true,
	[236] = true,
	[13185] = true,
	[13186] = true,
	[13154] = true,
	[13223] = true,
	[13194] = true,
	[13193] = true,
	[13178] = true,
	[13156] = true,
	[13222] = true,
	[13198] = true,
	[13202] = true,
	[13199] = true,
	[13180] = true,
	[13201] = true
}
HowAboutNo.TolBaradQuestIDs = {
	[28882] = true,
	[28884] = true
}

HowAboutNo.BannedQuests = {
	--["3861"] = true,
	--["4866"] = true
}

HowAboutNo.Zones = {
	[2118] = HowAboutNo.WintergraspQuestIDs,
	[2755] = HowAboutNo.TolBaradQuestIDs,
}

if HowAboutNo._debug then
	HowAboutNo.BannedQuests[13107] = true
	HowAboutNo.BannedQuests[13671] = true
end

function IsBannedQuest(questID, zoneID)
	if not tonumber(questID) then return false end -- We have to have at least a questID

	if HowAboutNo._debug then print("Checking if "..questID.." is banned") end
	if HowAboutNo.BannedQuests[questID] then
		if HowAboutNo._debug then print(questID.." is banned") end
		return true
	end

	-- Check to see if we're in an instance with whitelisted quests
	if zoneID ~= nil and HowAboutNo.Zones[zoneID] ~= nil then
		if HowAboutNo.Zones[zoneID][questID] == true then
			if HowAboutNo._debug then print("Accepting ", questID) end
			return false
		else
			if HowAboutNo._debug then print("Declining ", questID) end
			return true
		end
	end
	--[[
	-- Check if we're in a specific zone and it has an allow list
	if zoneID and HowAboutNo.Zones[zoneID] then
		-- If the quest is allowed in this zone, don't decline it
		if HowAboutNo._debug then print("Checking "..zoneID.." for "..questID) end
		for quest, accept in pairs(HowAboutNo.Zones[zoneID]) do
			if questID == tonumber(quest) and accept then
				if HowAboutNo._debug then print(questID.." is allowed") end
				return false
			end
		end
		return true
	end
	]]--
	return false
end

local f = CreateFrame("Frame", "HowAboutNoFrame")
f:RegisterEvent("QUEST_DETAIL")
f:SetScript("OnEvent", function(this, event, questStartItemID, ...)
	if event == "QUEST_DETAIL" then
		local currentZone = select(8, GetInstanceInfo())
		if IsBannedQuest(GetQuestID(), currentZone) then
			if HowAboutNo._debug then print("Declined "..GetQuestID()) end
			DeclineQuest()
			return
		end
	end
end)
