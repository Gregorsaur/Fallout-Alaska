-- THEOPATHY 2019
-- RADIO SYSTEM 
function Radio_Reset() 
if CLIENT then
    local aftermath_cl_radio_volume = CreateClientConVar("aftermath_cl_radio_volume", "1", true, false, "The volume the radio plays on your local character")
    local volumecache = nil
    playingindex = 0

    StationName = {"East STATION", "Reborn FM", "Despair, Fission, Radiation", "Classics Radio", "NAME NOT FOUND"}
     radioFreq = {}
     radioFreq[1] = 16
    radioFreq[2] = 5
    radioFreq[3] = 7
    radioFreq[4] = 100
    radioFreq[5] = 52 
         radioHeight = {}

    radioHeight[6] = 0.25
local songname = "NA"

    stations = {"http://fallout.fm:8000/falloutfm6.ogg", "http://fallout.fm:8000/falloutfm10.ogg", "http://fallout.fm:8000/falloutfm3.ogg", "http://fallout.fm:8000/falloutfm1.ogg", "http://soundbible.com/grab.php?id=1674&type=wav"}
     local function AddStation(a,b,c) 
    table.insert(StationName,a)
     table.insert(stations,b)
     table.insert(radioFreq, c or 90)
    end
    hook.Run("ADD_RADIO_STATIONS",AddStation) 

    EV_RAIDO_STATIONS_GET_SONG = {"http://fallout.fm/now_playing.php?the_stream=http%3A%2F%2Ffallout.fm%3A8000%2Ffalloutfm6.ogg", [[http://theopathy.net/fallout9.php]], "http://fallout.fm/now_playing.php?the_stream=http%3A%2F%2Ffallout.fm%3A8000%2Ffalloutfm3.ogg", "http://fallout.fm/now_playing.php?the_stream=http%3A%2F%2Ffallout.fm%3A8000%2Ffalloutfm1.ogg", nil}

    -- fix because gmod hated this url uses a mirror
    local disablechatmessages = true

    function EV_RADIO_PUBLIC_CON(x)
  
        LocalPlayer():ConCommand("aftermath_cl_radio_changestation " .. x or "")
              hook.Run("updatedRadio") 
    end

    function EV_RADIO_TOGGLE()
        LocalPlayer():ConCommand("aftermath_cl_radio_toggle")
    end

    function EV_RADIO_OFF()
        LocalPlayer():ConCommand("aftermath_cl_radio_off")
    end

    function EV_RADIO_GETINDEX()
        return playingindex
    end

    function AUDIORADIO_CALLBACK(s)
        AUDIORADIO = s
        s:Play()
        s:SetVolume(aftermath_cl_radio_volume:GetFloat())
        loadingnew = true
    end

    hook.Add("Think", "think_audioradio", function()
        if AUDIORADIO and AUDIORADIO:GetState() == GMOD_CHANNEL_STOPPED and loadingnew then
            loadingnew = false
            sound.PlayURL(stations[playingindex], "noplay noblock", AUDIORADIO_CALLBACK)
        end

        local cvarvolume = aftermath_cl_radio_volume:GetFloat()

        if AUDIORADIO and cvarvolume ~= volumecache then
            AUDIORADIO:SetVolume(math.Clamp(cvarvolume, 0, 10))
            volumecache = cvarvolume
        end
    end)

    concommand.Add("aftermath_cl_radio_off", function(ply, cmd, args)
        if AUDIORADIO and (AUDIORADIO:GetState() == GMOD_CHANNEL_PLAYING or AUDIORADIO:GetState() == GMOD_CHANNEL_STALLED) then
            AUDIORADIO:Stop()
            AUDIORADIO = nil
            loadingnew = true
            playingindex = 8
        end
    end)

    concommand.Add("aftermath_cl_radio_on", function(ply, cmd, args)
        if not (AUDIORADIO and (AUDIORADIO:GetState() == GMOD_CHANNEL_PLAYING or AUDIORADIO:GetState() == GMOD_CHANNEL_STALLED)) then
            AUDIORADIO:Stop()
            AUDIORADIO = nil
            loadingnew = true
            sound.PlayURL(stations[playingindex], "noplay noblock", AUDIORADIO_CALLBACK)
        end
    end)

    concommand.Add("aftermath_cl_radio_toggle", function(ply, cmd, args)
        if AUDIORADIO and (AUDIORADIO:GetState() == GMOD_CHANNEL_PLAYING or AUDIORADIO:GetState() == GMOD_CHANNEL_STALLED) then
            AUDIORADIO:Stop()
            AUDIORADIO = nil
            loadingnew = true
        else
            AUDIORADIO:Stop()
            AUDIORADIO = nil
            sound.PlayURL(stations[playingindex], "noplay noblock", AUDIORADIO_CALLBACK)
        end
    end)

    local lastsong

    timer.Create("nowplayingupdate", 1, 0, function()
        if stations[playingindex] then
            http.Fetch("http://fallout.fm/now_playing.php?the_stream=" .. stations[playingindex], function(b, a, c, d)
                if lastsong ~= b and disablechatmessages ~= true then
                    lastsong = b
                    chat.AddText(Color(255, 140, 0), "Now Playing: ", Color(255, 207, 158), b)
                end
            end, function() end)
        end
    end)

    concommand.Add("aftermath_cl_radio_changestation", function(ply, cmd, args)
        if AUDIORADIO and (AUDIORADIO:GetState() == GMOD_CHANNEL_STALLED) then return end

        if #args == 0 then
            _playinginex = _playinginex + 1
            _playinginex = _playinginex > #stations and 1 or _playinginex
        elseif _playinginex ~= tonumber(args[1]) then
            _playinginex = math.Clamp(tonumber(args[1]), 1, #stations)
            if tonumber(args[1]) == playingindex then return end
        end

        if AUDIORADIO then
            AUDIORADIO:Stop()
        end

        AUDIORADIO = nil
        sound.PlayURL(stations[_playinginex], "noplay noblock", AUDIORADIO_CALLBACK)

        if not disablechatmessages then
            chat.AddText(Color(255, 140, 0), "Changed station to: ", Color(255, 207, 158), StationName[_playinginex])
        end

        playingindex = _playinginex
    end)
end

end
Radio_Reset() 
 