local SOUND_ID = 5495
local SOUND_CHANNEL = "Master"
local SOUND_DURATION = 3.0
local SOUND_REPEATS = 3

local BOOSTED_VOLUME = 0.40 -- 40%
local originalVolume = nil
local restoreTimer = nil

local function SetMasterVolume(value)
    SetCVar("Sound_MasterVolume", value)
end

local function GetMasterVolume()
    return tonumber(GetCVar("Sound_MasterVolume"))
end

function YemWhisperAlert_PlaySound()
    local playCount = 0

    -- Cache original volume ONCE per activation
    if not originalVolume then
        originalVolume = GetMasterVolume()
        SetMasterVolume(BOOSTED_VOLUME)
    end

    local function PlayNext()
        playCount = playCount + 1
        PlaySound(SOUND_ID, SOUND_CHANNEL)

        if playCount < SOUND_REPEATS then
            C_Timer.After(SOUND_DURATION, PlayNext)
        end
    end

    -- Restore volume after final sound
    if restoreTimer then
        restoreTimer:Cancel()
    end

    restoreTimer = C_Timer.After((SOUND_DURATION * SOUND_REPEATS) + 0.1, function()
        if originalVolume then
            SetMasterVolume(originalVolume)
            originalVolume = nil
        end
    end)

    PlayNext()
end

-- SAFETY: restore volume if addon is manually disabled
function YemWhisperAlert_RestoreVolume()
    if originalVolume then
        SetMasterVolume(originalVolume)
        originalVolume = nil
    end
end
