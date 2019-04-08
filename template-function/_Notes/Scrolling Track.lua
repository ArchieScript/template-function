  
  









  
  -------------------------------------------------------------
  
      local function Scrolling(); 
        local CountTracks,scrol = reaper.CountTracks(0),0;
        for i = 1, CountTracks do;
            local Track = reaper.GetTrack(0, i-1);
            local Sel = reaper.GetMediaTrackInfo_Value(Track,"I_SELECTED");
            if Sel == 0 then;
                local wndh = reaper.GetMediaTrackInfo_Value( Track, "I_WNDH");
                scrol = scrol + wndh;
            else;
                break;
            end;
        end ;
        -- scrol = math.floor((scrol * 0.125)+0.5);
        scrol = math.floor((scrol/8)+0.5);
        reaper.CSurf_OnScroll(0,-10000);
        reaper.CSurf_OnScroll(0, scrol);
    end
    
  
    ----------------------------------------------------------------------------
    Низ недоделан 
    
    
    local function Scrolling2(); 
    
    _,_, scr_x, scr_y = reaper.my_getViewport(0,0, 0, 0,0, 0,0,0, 1 )--monitor resolution 
    
    Track_ = reaper.GetSelectedTrack(0, 0);
    scrol2 = math.floor(((scr_y) * 0.125) /100*80 +0.5) -- 35
    wndh__ = reaper.GetMediaTrackInfo_Value(Track_, "I_WNDH");
    scrol3 = math.floor((wndh__ / 8)+0.5)
    scrol4 = scrol2 - scrol3
    
    
    
        local CountTracks,scrol = reaper.CountTracks(0),0;
        for i = 1, CountTracks do;
            local Track = reaper.GetTrack(0, i-1);
            local Sel = reaper.GetMediaTrackInfo_Value(Track,"I_SELECTED");
            if Sel == 0 then;
                local wndh = reaper.GetMediaTrackInfo_Value( Track, "I_WNDH");
                scrol = scrol + wndh;
            else;
                break;
            end;
        end ;
        -- scrol = math.floor((scrol * 0.125)+0.5);
        scrol = math.floor((scrol/8)+0.5);
        FFF = scrol
        reaper.CSurf_OnScroll(0,-10000);
        reaper.CSurf_OnScroll(0, scrol-scrol4);   
    end
  
  
  
  
  
  
  -----------------------------------------------------------------------------------------------------
  --  extension:  reaper_js_ReaScriptAPI
  
  
  local function GetScrollTrack_js(track);
        if reaper.APIExists("JS_Window_FindChildByID")then;
            if type(track)~= "userdata" then error("GetScrollTrack (MediaTrack expected)",2)end; 
            local Numb = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER");
            local height;
            for i = 1,Numb-1 do;
                local Track = reaper.GetTrack(0,i-1);
                local wndh = reaper.GetMediaTrackInfo_Value( Track, "I_WNDH");
                height = (height or 0)+wndh;
            end;
            local trackview = reaper.JS_Window_FindChildByID(reaper.GetMainHwnd(),1000);
            local _, position = reaper.JS_Window_GetScrollInfo(trackview,"v");
            return (height or 0) - position;
        else;
            reaper.ShowConsoleMsg("требуется расширение  - 'reaper_js_ReaScriptAPI'\n"..
                                  "require extension is requi - reaper_js_ReaScriptAPI\n")
        end;
    end;
     
    
    
    local function SetScrollTrack_js(track, numbPix);
        if type(track)~= "userdata" then error("SetScrollTrack (MediaTrack expected)",2)end;
        local Numb = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER");
        local height;
        for i = 1,Numb-1 do;
            local Track = reaper.GetTrack(0,i-1);
            local wndh = reaper.GetMediaTrackInfo_Value(Track,"I_WNDH");
            height = (height or 0)+wndh;
        end;
        local trackview = reaper.JS_Window_FindChildByID(reaper.GetMainHwnd(),1000);
        local _, position = reaper.JS_Window_GetScrollInfo(trackview,"v");
        reaper.JS_Window_SetScrollPos(trackview,"v",(height or 0)-(numbPix or position));
    end;
    ------------------------------------------------------------------------------------
