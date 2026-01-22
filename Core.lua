local ADDON_NAME = ...
YemWhisperAlertDB = YemWhisperAlertDB or {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_WHISPER")

local function InitDB()
    if YemWhisperAlertDB.enabled == nil then
        YemWhisperAlertDB.enabled = false
    end
end

frame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= ADDON_NAME then return end
        InitDB()
        YemWhisperAlert_UpdateToggleUI()
        -- print("|cff00ff00Yem Whisper Alert loaded|r (OFF by default)")
        return
    end

    if event == "CHAT_MSG_WHISPER" then
        if not YemWhisperAlertDB.enabled then return end

        YemWhisperAlert_PlaySound()
        YemWhisperAlert_StartFlashing(5)
    end
end)
