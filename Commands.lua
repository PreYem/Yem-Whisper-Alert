SLASH_YEMWHISPERALERT1 = "/yemwa"
SLASH_YEMWHISPERALERT2 = "/yemau"

SlashCmdList["YEMWHISPERALERT"] = function(msg)
    msg = msg:lower():match("^%s*(.-)%s*$")

    if msg == "on" then
        YemWhisperAlert_ShowButton()
        print(YemWhisperAlert.PREFIX .. " UI is |cff00ff00ON|r")
        return
    end

    if msg == "off" then
        YemWhisperAlert_HideButton()
        print(YemWhisperAlert.PREFIX .. " UI |cffff0000OFF|r")
        return
    end

    print(YemWhisperAlert.PREFIX .. " |cffffff00List of currently usable commands : |r")
    print("|cff00ff00/yemwa on|r  - Show toggle button")
    print("|cffff0000/yemwa off|r - Hide toggle button")
end
