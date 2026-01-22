local alertText = UIParent:CreateFontString(nil, "OVERLAY")
alertText:SetPoint("CENTER")
alertText:SetFont("Fonts\\FRIZQT__.TTF", 96, "OUTLINE")
alertText:SetText("!!! WHISPER WARNING !!!")
alertText:SetTextColor(1, 0, 0)
alertText:SetAlpha(1)
alertText:Hide()

local flashTicker
local colorState = false

function YemWhisperAlert_StartFlashing(duration)
    alertText:Show()

    if flashTicker then
        flashTicker:Cancel()
    end

    flashTicker = C_Timer.NewTicker(0.25, function()
        alertText:SetAlpha(alertText:GetAlpha() == 1 and 0.25 or 1)
        alertText:SetTextColor(colorState and 1 or 1, colorState and 0 or 1, 0)
        colorState = not colorState
    end)

    C_Timer.After(duration, function()
        if flashTicker then
            flashTicker:Cancel()
            flashTicker = nil
        end
        alertText:Hide()
        alertText:SetAlpha(1)
        alertText:SetTextColor(1, 0, 0)
    end)
end
