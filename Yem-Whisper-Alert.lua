-- Yem Whisper Alert
-- Massive flashing warning + raid horn on whisper
--------------------------------------------------

--------------------------------------------------
-- ADDON / DB INIT
--------------------------------------------------
local ADDON_NAME = ...
YemWhisperAlertDB = YemWhisperAlertDB or {}

local function InitDB()
    if YemWhisperAlertDB.enabled == nil then
        YemWhisperAlertDB.enabled = false -- OFF by default
    end
end

--------------------------------------------------
-- EVENT FRAME
--------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_WHISPER")

--------------------------------------------------
-- ALERT TEXT (VERY LARGE)
--------------------------------------------------
local alertText = UIParent:CreateFontString(nil, "OVERLAY")
alertText:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
alertText:SetFont("Fonts\\FRIZQT__.TTF", 96, "OUTLINE")
alertText:SetText("!!! WHISPER WARNING !!!")
alertText:SetTextColor(1, 0, 0)
alertText:SetAlpha(1)
alertText:Hide()

--------------------------------------------------
-- FLASHING CONTROL
--------------------------------------------------
local flashing = false
local flashTicker
local colorState = false

local function StartFlashing(duration)
    flashing = true
    alertText:Show()

    flashTicker = C_Timer.NewTicker(0.25, function()
        alertText:SetAlpha(alertText:GetAlpha() == 1 and 0.25 or 1)

        if colorState then
            alertText:SetTextColor(1, 0, 0)
        else
            alertText:SetTextColor(1, 1, 0)
        end
        colorState = not colorState
    end)

    C_Timer.After(duration, function()
        flashing = false
        if flashTicker then
            flashTicker:Cancel()
            flashTicker = nil
        end
        alertText:Hide()
        alertText:SetAlpha(1)
        alertText:SetTextColor(1, 0, 0)
    end)
end

--------------------------------------------------
-- SOUND
--------------------------------------------------
local SOUND_ID = 5495
local SOUND_CHANNEL = "Master"
local SOUND_DURATION = 3.0
local SOUND_REPEATS = 3

local function PlayWarningSound()
    local playCount = 0

    local function PlayNext()
        playCount = playCount + 1
        PlaySound(SOUND_ID, SOUND_CHANNEL)

        if playCount < SOUND_REPEATS then
            C_Timer.After(SOUND_DURATION, PlayNext)
        end
    end

    PlayNext()
end

--------------------------------------------------
-- TOGGLE BUTTON UI
--------------------------------------------------
local toggleButton = CreateFrame("Button", "YemWhisperAlertToggle", UIParent)
toggleButton:SetSize(160, 28)
toggleButton:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 120)

local bg = toggleButton:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(true)
bg:SetColorTexture(0, 0, 0, 0.7)

local text = toggleButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("CENTER")

toggleButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
toggleButton:RegisterForClicks("LeftButtonUp")

local function UpdateToggleUI()
    if YemWhisperAlertDB.enabled then
        text:SetText("|cff00ff00Whisper Alert: ON|r")
    else
        text:SetText("|cffff0000Whisper Alert: OFF|r")
    end
end

toggleButton:SetScript("OnClick", function()
    YemWhisperAlertDB.enabled = not YemWhisperAlertDB.enabled
    UpdateToggleUI()
end)

--------------------------------------------------
-- EVENT HANDLER
--------------------------------------------------
frame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= ADDON_NAME then return end
        InitDB()
        UpdateToggleUI()
        print("|cff00ff00Yem Whisper Alert loaded|r (OFF by default)")
        return
    end

    if event == "CHAT_MSG_WHISPER" then
        if not YemWhisperAlertDB.enabled then
            return
        end

        if flashing and flashTicker then
            flashTicker:Cancel()
            flashTicker = nil
        end

        PlayWarningSound()
        StartFlashing(5)
    end
end)
