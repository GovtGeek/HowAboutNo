local _, HowAboutNo = ...

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
	if HowAboutNo.BannedQuests[questID] then return true end

	-- Check to see if we're in an instance with whitelisted quests
	if zoneID ~= nil and HowAboutNo.Zones[zoneID] ~= nil then
		return not HowAboutNo.Zones[zoneID][questID] == true
	end
	return false
end

local f = CreateFrame("Frame", "HowAboutNoFrame")
f:RegisterEvent("QUEST_DETAIL")
f:SetScript("OnEvent", function(this, event, questStartItemID, ...)
	if event == "QUEST_DETAIL" then
		--print(QuestFrameNpcNameText:GetText()) -- NPC/PC sharing the quest
		local currentZone = select(8, GetInstanceInfo())
		if IsBannedQuest(GetQuestID(), currentZone) then
			DeclineQuest()
			return
		end
	end
end)
