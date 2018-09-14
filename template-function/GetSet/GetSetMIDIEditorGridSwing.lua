






    

-- GetSetMIDIEditorGridSwing.lua

           -- Установить,получить значение качания в редактори миди
           -- Set, get swing value in MIDI editor
           
           
                                                      -- swingIn 0-1
                                                      -- isSet  0-1 -- GetSet



    local function GetSetMIDIEditorGridSwing(isSet,MidiEditor,swingIn)
        reaper.PreventUIRefresh(951753) 
        local _,grid,swingOnOff,swing = reaper.GetSetProjectGrid(0,0)
        local take = reaper.MIDIEditor_GetTake(MidiEditor)
        local MidiGrid,swing,noteLen = reaper.MIDI_GetGrid(take)
        if tonumber(swingIn) and isSet == 1 then 
            reaper.GetSetProjectGrid(0,1,nil,1,nil) 
            local ToggleDivOn = reaper.GetToggleCommandState(42010)
            if ToggleDivOn == 0 then 
                reaper.Main_OnCommand(42010,0)
            end  --Grid: Use the same grid division in arrange view and MIDI editor 
            reaper.GetSetProjectGrid(0,1,nil,nil,swingIn)
            if ToggleDivOn ~= 1 then
                reaper.Main_OnCommand(42010,0)
                reaper.SetMIDIEditorGrid( 0, MidiGrid/4)
                reaper.GetSetProjectGrid(0,1,grid,swingOnOff,swing)  
            else
              reaper.GetSetProjectGrid(0,1,nil,swingOnOff,nil)
            end
        end    
        reaper.PreventUIRefresh(-951753) 
        return swing --,MidiGrid,noteLen  
    end






