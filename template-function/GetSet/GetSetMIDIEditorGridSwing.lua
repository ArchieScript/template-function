






    

-- GetSetMIDIEditorGridSwing.lua

           -- Получить Установить значение качания в редактори миди
           -- Get Set swing value in MIDI editor
           
           
                                                      -- swingIn - (-1  1) -- 1 = 100; 0 = 0; -1 = -100;
                                                      -- isSet   - ( 0  1) -- GetSet



    local function GetSetMIDIEditorGridSwing(isSet,MidiEditor,swingIn)
        local take = reaper.MIDIEditor_GetTake(MidiEditor)
        if tonumber(swingIn) and isSet == 1 then  
            reaper.PreventUIRefresh(951753) 
            local _,grid,swingOnOff,swing = reaper.GetSetProjectGrid(0,0)
            reaper.MIDIEditor_OnCommand( MidiEditor,41003)
            local MidiGrid = select(1,reaper.MIDI_GetGrid(take))
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
            reaper.PreventUIRefresh(-951753)
        end    
        local MidiGrid,MidiSwing,noteLen = reaper.MIDI_GetGrid(take)
        return MidiSwing --,MidiGrid,noteLen  
    end






