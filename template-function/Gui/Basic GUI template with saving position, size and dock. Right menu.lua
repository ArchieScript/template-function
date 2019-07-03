



    
    
    
    
    
    
    local function OpenWebSite(path);
        local OS,cmd = reaper.GetOS();
        if OS == "OSX32" or OS == "OSX64" then;
            os.execute('open "'..path..'"');
        else;
            os.execute('start "" '..path);
        end;
    end;
    -----------------------------------------
    
    
    
    local function SetColorRGB(r,g,b,a,mode);
        gfx.set(r/256,g/256,b/256,a,mode); 
    end;
    -----------------------------------------
    
    
    
    
    
    local section = ({reaper.get_action_context()})[2]:match(".+[/\\](.+)");
    local is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context();
    reaper.SetToggleCommandState(sectionID,cmdID,1);
    reaper.DockWindowRefresh();
    
    
    local PositionDock = tonumber(reaper.GetExtState(section,"PositionDock"))or 0;
    local PosX,PosY = reaper.GetExtState(section,"PositionWind"):match("(.-)&(.-)$");
    local SizeW,SizeH = reaper.GetExtState(section,"SizeWindow"):match("(.-)&(.-)$");
    local SaveDock = tonumber(reaper.GetExtState(section,"SaveDock"));
    ---
    
    gfx.init("Show clock window",SizeW or 180,SizeH or 50,PositionDock,PosX or 150,PosY or 100);
    
    
    
    
    
    
    
    
    
    ---------
    function loop();
        
        
        ------------------------------
        local Dock_ = gfx.dock(-1);
        if Dock_&1 ~= 0 and SaveDock ~= Dock_ then SaveDock = Dock_ end;
        if gfx.mouse_cap == 2 then;
            gfx.x = gfx.mouse_x;
            gfx.y = gfx.mouse_y;
            
            local checkedDock;
            local Dock = gfx.dock(-1);
            if Dock&1 ~= 0 then checkedDock = "!" else checkedDock = "" end;
            showmenu = gfx.showmenu(--[[ 1]]checkedDock.."Dock Big Clock in Docker||"..
                                    --[[ 2]]" |"..
                                    --[[ 3]]" |"..
                                    --[[ 4]]" |"..
                                    --[[ 5]]" |"..
                                    --[[ 6]]" ||"..
                                    --[[->]]">Support project|"..
                                    --[[ 7]]"Dodate||"..
                                    --[[ 8]]"Bug report (Of site forum)|"..
                                    --[[ 9]]"<Bug report (Rmm forum)||"..
                                    --[[10]]"Close clock window");
            
            
            if showmenu == 1 then;
                ----
                if Dock&1 ~= 0 then;
                    gfx.dock(0);
                    SaveDock = Dock;
                else;
                   if math.fmod(PositionDock,2) == 0 then PositionDock = 2049 end;
                   gfx.dock(SaveDock or PositionDock);
                end;
                ----
            elseif showmenu == 2 then;
                ----
                
                ----
            elseif showmenu == 3 then;
                ----
                
                ----
            elseif showmenu == 4 then;
                ----
                
                ----
            elseif showmenu == 5 then;
                ----
                
                ----
            elseif showmenu == 6 then;
                ----
                
                ----
            elseif showmenu == 7 then;
                ----
                local path = "https://money.yandex.ru/to/410018003906628";
                OpenWebSite(path);
                reaper.ClearConsole();
                reaper.ShowConsoleMsg("Yandex-money - "..path.."\n\nWebManey - R159026189824");
                ----
            elseif showmenu == 8 then;
                ----
                local path = "https://forum.cockos.com/showthread.php?t=212819";
                OpenWebSite(path);
                ----
            elseif showmenu == 9 then;
                ----
                local path = "https://rmmedia.ru/threads/134701/";
                OpenWebSite(path);
                ----
            elseif showmenu == 10 then;
                ----
                exit();
                ----
            end;
        end;
        ------------------------------
        
        
        
        if gfx.getchar() >= 0 then reaper.defer(loop);else;reaper.atexit(exit)return;end;
    end;
    ---------
    
    
    
    
    ---------
    function exit();
        reaper.SetToggleCommandState(sectionID,cmdID,0);
        reaper.DockWindowRefresh();
        local PosDock,PosX,PosY,PosW,PosH = gfx.dock(-1,-1,-1,-1,-1);
        reaper.SetExtState(section,"PositionDock",PosDock,true);
        reaper.SetExtState(section,"PositionWind",PosX.."&"..PosY,true);
        reaper.SetExtState(section,"SizeWindow",PosW.."&"..PosH,true);
        reaper.SetExtState(section,"SaveDock",SaveDock or "NULL",true);
        gfx.quit();
    end;
    ---------
    
    
    ---------
    
    
    
    
    loop();
    
    
    
    
