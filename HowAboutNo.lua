local WintergraspQuestIDs = {
	13539 = true,
	13181 = true,
	13538 = true,
	13196 = true,
	13183 = true,
	13153 = true,
	13197 = true,
	13191 = true,
	13179 = true,
	13192 = true,
	13177 = true,
	13195 = true,
	13200 = true,
	236 = true,
	13185 = true,
	13186 = true,
	13154 = true,
	13223 = true,
	13194 = true,
	13193 = true,
	13178 = true,
	13156 = true,
	13222 = true,
	13198 = true,
	13202 = true,
	13199 = true,
	13180 = true,
	13201 = true
}

local f = CreateFrame("Frame", "HowAboutNoFrame")
f:RegisterEvent("QUEST_DETAILS")
f:SetScript("OnEvent", function(this, event, ...)
	if event == "QUEST_DETAILS" then
		local sharedQuestID = GetQuestID()
		-- Check that we're in Wintergrasp
		if wintergraspInstanceID == GetInstanceID() then
			-- If the quest isn't a Wintergrasp quest, decline it
			if not WintergraspQuestIDs[sharedQuestID] then
				DeclineQuest()
			end
		end
	end
)
