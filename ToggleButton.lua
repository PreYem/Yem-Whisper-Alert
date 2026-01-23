local toggleButton = CreateFrame("Button", "YemWhisperAlertToggle", UIParent)
toggleButton:SetSize(160, 28)
toggleButton:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 20, 120)

local bg = toggleButton:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(true)
bg:SetColorTexture(0, 0, 0, 0.7)

local text = toggleButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("CENTER")

toggleButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
toggleButton:RegisterForClicks("LeftButtonUp")

function YemWhisperAlert_UpdateToggleUI(silent)
    if YemWhisperAlertDB.enabled then
        text:SetText("|cff00ff00Whisper Alert: ON|r")
        if not silent then
            print(YemWhisperAlert.PREFIX .. " Alerts are |cff00ff00ON|r.")
        end
    else
        text:SetText("|cffff0000Whisper Alert: OFF|r")
        if not silent then
            print(YemWhisperAlert.PREFIX .. " Alerts are |cffff0000OFF|r.")
        end
    end
end

toggleButton:SetScript("OnClick", function()
    YemWhisperAlertDB.enabled = not YemWhisperAlertDB.enabled

    if not YemWhisperAlertDB.enabled then
        YemWhisperAlert_RestoreVolume()
    end

    YemWhisperAlert_UpdateToggleUI(true)
end)

function YemWhisperAlert_ShowButton()
    toggleButton:Show()
    YemWhisperAlertDB.showButton = true
end

function YemWhisperAlert_HideButton()
    toggleButton:Hide()
    YemWhisperAlertDB.showButton = false
end
