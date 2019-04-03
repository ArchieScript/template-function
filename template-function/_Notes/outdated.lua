    
    
    
    
    
    
    ExtState = reaper.GetExtState('['..({reaper.get_action_context()})[2]:match(".+[\\/](.+)")..']',"outdated")
     
     if ExtState == "" then
         reaper.MB(
                "Rus:\n\n"..
                "  *  Скрипт устарел, используйте\n"..
                "  *  Archie_Track;  Move selected tracks up by one visible(`).lua \n"..
                "  *  Archie_Track;  Move selected tracks up by one visible (skip folders)(`).lua\n"..
                "  *  Archie_Track;  Move selected tracks up by one visible (request to skip folders)(`).lua\n"..
                "  *  Данный Скрипт будет удален 31.05.2019\n\n"..
                "Eng\n\n"..
                "  * The script is outdated, use\n" ..
                "  *  Archie_Track;  Move selected tracks up by one visible(`).lua \n"..
                "  *  Archie_Track;  Move selected tracks up by one visible (skip folders)(`).lua\n"..
                "  *  Archie_Track;  Move selected tracks up by one visible (request to skip folders)(`).lua\n"..
                "  * This Script will be deleted. 31.05.2019 \n",
               "OUTDATED!",0)
     end;
     
     ValueExt = (tonumber(ExtState)or 0)+1
     if ValueExt > 4 then ValueExt = "" end
     
     reaper.SetExtState( '['..({reaper.get_action_context()})[2]:match(".+[\\/](.+)")..']',"outdated" ,ValueExt,false)
