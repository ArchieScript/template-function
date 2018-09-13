


      -- SetMIDIEditorGridSwing.lua

           -- Установить значение качания в редактори миди
           -- Set the swing value in the midi editor
           
           -- возвращает true в случае успеха, false в случае неудачи
           -- returns true if successful, on failure false
           
           
                                                      -- swingIn 0-1

local function SetMIDIEditorGridSwing(MidiEditor,swingIn)
    reaper.PreventUIRefresh(951753)  
    if not MidiEditor then return false end
    if not tonumber(swingIn)then return false end
    local _,grid,swingOnOff,swing = reaper.GetSetProjectGrid(0,0)
    reaper.GetSetProjectGrid(0,1,grid,1,swing) 
    local take = reaper.MIDIEditor_GetTake(MidiEditor)
    local MidiGrid = select(1,(reaper.MIDI_GetGrid(take)/4)) 
    if reaper.GetToggleCommandState(42010)== 0 then 
        reaper.Main_OnCommand(42010,0)
    end  --Grid: Use the same grid division in arrange view and MIDI editor 
    reaper.GetSetProjectGrid(0,1,nil,nil,swingIn)
    reaper.Main_OnCommand(42010,0)
    --Grid: Use the same grid division in arrange view and MIDI editor 
    reaper.SetMIDIEditorGrid( 0, MidiGrid)
    reaper.GetSetProjectGrid(0,1,grid,swingOnOff,swing)
    reaper.PreventUIRefresh(-951753) 
    return true
end


















