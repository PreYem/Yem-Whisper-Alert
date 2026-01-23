-- Create a frame to listen for the role check event
local roleCheckFrame = CreateFrame("Frame")

-- Register the event that fires when role check appears
roleCheckFrame:RegisterEvent("LFG_ROLE_CHECK_SHOW")

-- Event handler
roleCheckFrame:SetScript("OnEvent", function(self, event)
    if event == "LFG_ROLE_CHECK_SHOW" then
        -- Optional: Add a small delay to make it feel more natural
        C_Timer.After(0.1, function()
            -- This accepts the role check with your currently selected role
            CompleteLFGRoleCheck(true)
        end)
    end
end)
