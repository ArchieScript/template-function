   
   
   
   
   
    local mute, track, solo = {}, {}, {} 

    local function SaveSoloMuteStateAllTracks()
        for i = 1, reaper.CountTracks(0) do
            track[i] = reaper.GetTrack(0, i - 1)
            mute[i] = reaper.GetMediaTrackInfo_Value(track[i],'B_MUTE') 
            solo[i] = reaper.GetMediaTrackInfo_Value(track[i],'I_SOLO') 
        end
    end
    ---
    
    
    
    
    local function RestoreSoloMuteStateAllTracks()
        for i = 1, #track do
            reaper.SetMediaTrackInfo_Value(track[i], 'B_MUTE', mute[i])
            reaper.SetMediaTrackInfo_Value(track[i], 'I_SOLO', solo[i]) 
        end
    end 



--============================================================







    -------SaveSoloMuteStateAllTracksSlot()----------------------------------------------
    --------------------------------------RestoreSoloMuteStateAllTracksSlot()------------
    function SaveSoloMuteStateAllTracksSlot(Slot);
        local CountTracks = reaper.CountTracks(0);
        if CountTracks == 0 then return false end;
        local t = {};_G['SavSolMutTrSlot_'..Slot] = t;
        for i = 1, CountTracks do;
            local track = reaper.GetTrack(0, i - 1);
            t[i] = reaper.GetTrackGUID(track)..'{'..
            reaper.GetMediaTrackInfo_Value(track,'B_MUTE')..'}{'..
            reaper.GetMediaTrackInfo_Value(track,'I_SOLO')..'}';
        end;
    end;
    -----------------------------------------------------------------
    function RestoreSoloMuteStateAllTracksSlot(Slot,clean);
        local t = _G['SavSolMutTrSlot_'..Slot];
        if t then;
            for i = 1, #t do;
                local guin,mute,solo = string.match (t[i],'({.+}){(.+)}{(.+)}');
                local track = reaper.BR_GetMediaTrackByGUID(0,guin);
                reaper.SetMediaTrackInfo_Value(track, 'B_MUTE', mute);
                reaper.SetMediaTrackInfo_Value(track, 'I_SOLO', solo);
            end;
            if clean == 1 or clean == true then;
                _G['SavSolMutTrSlot_'..Slot] = nil;
                t = nil;
            end;
        end;    
    end;
    -- Save Restore Solo Mute State All Tracks, Slots
    -- Сохранить Восстановить Соло Mute Состояние Всех Дорожек, Слоты
    -- clean = true или 1 - зачистить сохраненную информацию за собой
    --====End===============End===============End===============End===============End==== 





    Arc_Module.SaveSoloMuteStateAllTracksSlot(1)
    Arc_Module.RestoreSoloMuteStateAllTracksSlot(1,false)

    reaper.Main_OnCommand(id,0)
 
 
   Arc_Module.RestoreSoloMuteStateAllTracksSlot(1,true)


