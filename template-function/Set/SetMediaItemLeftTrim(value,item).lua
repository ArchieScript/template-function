  
         
  
          Set Media Item Left Trim


  
  local function SetMediaItemLeftTrim(value,item)
        local Pos = reaper.GetMediaItemInfo_Value( item, 'D_POSITION' )
        local len = reaper.GetMediaItemInfo_Value( item, 'D_LENGTH' )
        local take = reaper.GetActiveTake( item )
        local playrate = reaper.GetMediaItemTakeInfo_Value( take, 'D_PLAYRATE')
        local offset = reaper.GetMediaItemTakeInfo_Value( take, 'D_STARTOFFS' )
        if len > value then
            reaper.SetMediaItemLength( item,  value , true )
            reaper.SetMediaItemPosition( item,(len-value)+ Pos, true )
            reaper.SetMediaItemTakeInfo_Value( take, 'D_STARTOFFS',offset + (len-value)*playrate )
        else
            if Pos < (value-len) then return end
            reaper.SetMediaItemLength( item, value , true )
            reaper.SetMediaItemPosition( item, Pos-(value-len), true )
            reaper.SetMediaItemTakeInfo_Value( take, 'D_STARTOFFS',offset + (len-value)*playrate )
        end
    end
    
    
    
    
    
    
    
    
    
