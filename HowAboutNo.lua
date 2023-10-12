local addonName, HowAboutNo = ...

-- New and improved? Trying not to pollute the global scope.
HowAboutNo._debug = false
HowAboutNo.WintergraspQuestIDs = {
	["13539"] = true,
	["13181"] = true,
	["13538"] = true,
	["13196"] = true,
	["13183"] = true,
	["13153"] = true,
	["13197"] = true,
	["13191"] = true,
	["13179"] = true,
	["13192"] = true,
	["13177"] = true,
	["13195"] = true,
	["13200"] = true,
	["236"] = true,
	["13185"] = true,
	["13186"] = true,
	["13154"] = true,
	["13223"] = true,
	["13194"] = true,
	["13193"] = true,
	["13178"] = true,
	["13156"] = true,
	["13222"] = true,
	["13198"] = true,
	["13202"] = true,
	["13199"] = true,
	["13180"] = true,
	["13201"] = true
}

HowAboutNo.BannedQuests = {
	--["3861"] = true,
	--["4866"] = true
}

if HowAboutNo._debug then
	BannedQuests["13107"] = true
	BannedQuests["13671"] = true
end

local f = CreateFrame("Frame", "HowAboutNoFrame")
f:RegisterEvent("QUEST_DETAIL")
f:SetScript("OnEvent", function(this, event, questStartItemID, ...)
	if event == "QUEST_DETAIL" then
		local wintergraspInstanceID = 2118
		local sharedQuestID = GetQuestID()
		if sharedQuestID ~= nil then -- make sure we got a valid questID
			local questTitle = QuestUtils_GetQuestName(sharedQuestID)
			-- Check that we're in Wintergrasp
			if wintergraspInstanceID == select(8, GetInstanceInfo()) then
				local declineQuest = true
				-- If the quest is a Wintergrasp quest, allow it
				for quest, noban in pairs(HowAboutNo.WintergraspQuestIDs) do
					if sharedQuestID == tonumber(quest) then
						declineQuest = false
					end
				end
				if declineQuest then
					DeclineQuest()
				end
			end
			-- Check banned quests
			for quest, ban in pairs(HowAboutNo.BannedQuests) do
				if sharedQuestID == tonumber(quest) then
					DeclineQuest()
					break
				end
			end
		end
	end
end)
