local ADDON_NAME = ...

_G.YemWhisperAlert = _G.YemWhisperAlert or {}

YemWhisperAlert.NAME = ADDON_NAME
YemWhisperAlert.DISPLAY_NAME = "Yem Whisper Alert"
YemWhisperAlert.PREFIX = "|cff00ff00" .. YemWhisperAlert.DISPLAY_NAME .. "|r"

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_WHISPER")

local function InitDB()
    if YemWhisperAlertDB.enabled == nil then
        YemWhisperAlertDB.enabled = false -- AFK / loud mode
    end

    if YemWhisperAlertDB.showButton == nil then
        YemWhisperAlertDB.showButton = true
    end
end

frame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= ADDON_NAME then
            return
        end

        InitDB()
        YemWhisperAlert_UpdateToggleUI(true)

        if YemWhisperAlertDB.showButton then
            YemWhisperAlert_ShowButton()
            print(YemWhisperAlert.PREFIX .. " - UI is |cff00ff00ON|r. Use |cffffff00/yemwa off|r to hide it.")
        else
            YemWhisperAlert_HideButton()
            print(YemWhisperAlert.PREFIX .. " - UI is |cffff0000OFF|r. Use |cffffff00/yemwa on|r to show it.")
        end

        return
    end

    if event == "CHAT_MSG_WHISPER" then
        -- Addon is ALWAYS active
        if not YemWhisperAlertDB.enabled then
            return
        end

        YemWhisperAlert_PlaySound()
        YemWhisperAlert_StartFlashing(5)
    end
end)
