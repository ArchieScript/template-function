


--  Базовый шаблон GUI с сохранением позиции, размера и дока. Правое меню.





    --reaper.ShowConsoleMsg( t )
    --t=(t or 0)+1
    
    
    
    ---- / Default Color / ----
    local R_Back_Default =  50;
    local G_Back_Default =  50;
    local B_Back_Default =  50;
    
    local R_Text_Default = 150;
    local G_Text_Default = 150;
    local B_Text_Default = 150;
    
    local R_Gui__Default = 250;
    local G_Gui__Default = 250;
    local B_Gui__Default = 250;
    ---------------------------
    
    
    
    ----/ Конвертируем в проценты /----
    local function W(w);
        return (gfx.w/100*w);
    end;
    local X = W;
    local function H(h);
        return (gfx.h/100*h);
    end;
    local Y = H;
    -----------------------------------
    
    
    
    -------------------------------------------
    local function OpenWebSite(path);
        local OS,cmd = reaper.GetOS();
        if OS == "OSX32" or OS == "OSX64" then;
            os.execute('open "'..path..'"');
        else;
            os.execute('start "" '..path);
        end;
    end;
    -------------------------------------------
    
    
    
    -----------------------------------------
    local function SetColorRGB(r,g,b,a,mode);
        gfx.set(r/256,g/256,b/256,a,mode); 
    end;
    -----------------------------------------
    
    
    
    ----------------------------------------------------------------------
    local function TextByCenterAndResize(string,x,y,w,h,ZoomInOn,flags,r,g,b);
        local gfx_w = gfx.w/100*w;
        local gfx_h = gfx.h/100*h;
        
        gfx.setfont(1,"Arial",10000);
        local lengthFontW,heightFontH = gfx.measurestr(string);
        
        local F_sizeW = gfx_w/lengthFontW*gfx.texth;
        local F_sizeH = gfx_h/heightFontH*gfx.texth;
        local F_size = math.min(F_sizeW+ZoomInOn,F_sizeH+ZoomInOn);
        if F_size < 1 then F_size = 1 end;
        gfx.setfont(1,"Arial",F_size,flags);--BOLD=98,ITALIC=105,UNDERLINE=117
        
        local lengthFont,heightFont = gfx.measurestr(string);
        gfx.x = gfx.w/100*x + (gfx_w - lengthFont)/2; 
        gfx.y = gfx.h/100*y + (gfx_h- heightFont )/2;
        gfx.set(r/256,g/256,b/256,1);
    end;
    ----------------------------------------------------------------------
    
    
    
    ---/ Клик мыши /------------------------------------------------------
    local function Mouse_Is_Inside(x, y, w, h); --мышь находится внутри
        local mouse_x, mouse_y = gfx.mouse_x, gfx.mouse_y;
        local inside =
        mouse_x >= x and mouse_x < (x + w) and
        mouse_y >= y and mouse_y < (y + h);
        return inside;
    end;
    ----
    local mouse_btn_down,fake,lamp = {},{},{};
    local function LeftMouseButton(x, y, w, h,numbuf);
        if Mouse_Is_Inside(x, y, w, h) then;
            if gfx.mouse_cap&1 == 0 then fake[numbuf] = 1 end;
            if gfx.mouse_cap&1 == 0 and lamp[numbuf] ~= 0 then mouse_btn_down[numbuf] = 0 end;
            if gfx.mouse_cap&1 == 1 and fake[numbuf]==1 then mouse_btn_down[numbuf]=1 lamp[numbuf]=0; end; 
            if mouse_btn_down[numbuf] == 2 then mouse_btn_down[numbuf] = -1 end;
            if gfx.mouse_cap&1 == 0 and fake[numbuf] == 1 and mouse_btn_down[numbuf] == 1 then;
                mouse_btn_down[numbuf] = 2 lamp[numbuf] = nil;
            end;
        else;
            mouse_btn_down[numbuf] = -1 lamp[numbuf]=nil;
            if gfx.mouse_cap&1 == 1 and fake[numbuf] == 1 then mouse_btn_down[numbuf] = 1 end;
            if gfx.mouse_cap&1 == 0 then fake[numbuf] = nil end;
        end; 
        return mouse_btn_down[numbuf];
    end;
    ----------------------------------------------------------------------
    
    
    
    local section = ({reaper.get_action_context()})[2]:match(".+[/\\](.+)");
    local is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context();
    reaper.SetToggleCommandState(sectionID,cmdID,1);
    reaper.DockWindowRefresh();
    
    
    local PositionDock = tonumber(reaper.GetExtState(section,"PositionDock"))or 0;
    local PosX,PosY = reaper.GetExtState(section,"PositionWind"):match("(.-)&(.-)$");
    local SizeW,SizeH = reaper.GetExtState(section,"SizeWindow"):match("(.-)&(.-)$");
    local SaveDock = tonumber(reaper.GetExtState(section,"SaveDock"));
    -----
    
    
    -----
    local Color_Text = reaper.GetExtState(section,"Color_Text");
    local R_Text,G_Text,B_Text = Color_Text:match("R(%d-)G(%d-)B(%d-)$");
    R_Text = tonumber(R_Text)or R_Text_Default;
    G_Text = tonumber(G_Text)or G_Text_Default;
    B_Text = tonumber(B_Text)or B_Text_Default;
    -----
    
    -----
    local Color_Background = reaper.GetExtState(section,"Color_Background");
    local R_Back,G_Back,B_Back = Color_Background:match("R(%d-)G(%d-)B(%d-)$");
    R_Back = tonumber(R_Back)or R_Back_Default;
    G_Back = tonumber(G_Back)or G_Back_Default;
    B_Back = tonumber(B_Back)or B_Back_Default;
    -----
    
    -----
    local Color_Gui = reaper.GetExtState(section,"Color_Gui");
    local R_Gui,G_Gui,B_Gui = Color_Gui:match("R(%d-)G(%d-)B(%d-)$");
    R_Gui = tonumber(R_Gui)or R_Gui__Default;
    G_Gui = tonumber(G_Gui)or G_Gui__Default;
    B_Gui = tonumber(B_Gui)or B_Gui__Default;
    -----
    
    
    -----
    local TextBoldNorm = tonumber(reaper.GetExtState(section,"TextBoldNorm"));
    -----
    
    
    -----
    local FontSize = tonumber(reaper.GetExtState(section,"FontSize"))or 0;
    -----
    
    
    ---- / Remove focus from window (useful when switching Screenset) / -----------
    local RemFocusWin = tonumber(reaper.GetExtState(section,"RemFocusWin"))or 0;
    local function RemoveFocusWindow(RemFocusWin);
        if RemFocusWin == 1 then;
            --- / Снять фокус с окна / ---
            local winGuiFocus = gfx.getchar(65536)&2;
            if winGuiFocus ~= 0 then;
                if gfx.mouse_cap == 0 then;
                    local Context = reaper.GetCursorContext2(true);
                    reaper.SetCursorContext(Context,nil);
                    --t=(t or 0)+1;
                end;
            end;
        end;
    end;
    -------------------------------------------------------------------------------
    
    
    gfx.init("Show clock window",SizeW or 800,SizeH or 50,PositionDock,PosX or 150,PosY or 100);
    
    
    
    ---- / Рисуем основу / ----
    local function Start_GUI();
        
        --[[
        gfx.gradrect(0,0,gfx.w,gfx.h,R_Back/256,G_Back/256,B_Back/256,1);--background
        
        SetColorRGB(R_Gui,G_Gui,B_Gui,1);
        gfx.roundrect(X(30),Y(30), W(40),H(40),0);
        
        TextByCenterAndResize("string",30,30, 40,40,FontSize,TextBoldNorm,R_Text,G_Text,B_Text);
        gfx.drawstr("string");
        
        -- BODY --   Рисуем основу
        
        --]]
    end;
    Start_GUI();
    
    
    
    ---------
    local checked_Toggle,Start_W,Start_H;
    function loop();
        
        ----/Проверить тоггле(полезно для автозагрузки)/----
        if not checked_Toggle then;
            local Toggle = reaper.GetToggleCommandStateEx(sectionID,cmdID);
            if Toggle <= 0 then;
                reaper.SetToggleCommandState(sectionID,cmdID,1);
                reaper.DockWindowRefresh();
            end;
            checked_Toggle = true;
        end;
        ----/Перерисовать основу при изменении размера окна/----
        if Start_W ~= gfx.w or Start_H ~= gfx.h then;
            Start_GUI();
            Start_W = gfx.w;
            Start_H = gfx.h;
        end;
        ----/ Удалить Фокус с Окна /----
        RemoveFocusWindow(RemFocusWin);
        --------------------------------------------------------
        
        
        --body-- / Рисуем функциональность (горящие кнопочки и т.д.)
        
        
        --------------------------------------------------------
        
        ---- / Show Menu / ----
        local Dock_ = gfx.dock(-1);
        if Dock_&1 ~= 0 and SaveDock ~= Dock_ then SaveDock = Dock_ end;
        if gfx.mouse_cap == 2 then;
            gfx.x = gfx.mouse_x;
            gfx.y = gfx.mouse_y;
            
            
            local checkedDock;
            local Dock = gfx.dock(-1);
            if Dock&1 ~= 0 then checkedDock = "!" else checkedDock = "" end;
            
            local checkBold;
            if TextBoldNorm == 98 then checkBold = "!" else checkBold = "" end;
            
            local checkZoomInOn;
            if FontSize ~= 0 then checkZoomInOn = "!" else checkZoomInOn = "" end;
            
            local checkRemFocWin;
            if RemFocusWin == 1 then checkRemFocWin = "!" else checkRemFocWin = "" end;
            
            local
            showmenu = gfx.showmenu(--[[ 1]]checkedDock.."Dock Big Clock in Docker||"..
                                    --[[ 2]]"# #|"..
                                    --[[ 3]]"# #|"..
                                    --[[ 4]]"# #|"..
                                    --[[ 5]]"# #|"..
                                    --[[ 6]]"# #||"..
                                    --[[->]]">View|"..
                                    --[[->]]">Color|"..
                                    --[[ 7]]"Customize text color...|"..
                                    --[[ 8]]"Default text color||"..
                                    --[[ 9]]"Customize background color|"..
                                    --[[10]]"Default background color||"..
                                    --[[11]]"Customize Gui color|"..
                                    --[[12]]"Default Gui color||"..
                                    --[[13]]"<Default All color|"..
                                    --[[14]]checkBold.."Text: Normal / Bold|"..
                                    --[[15]]checkZoomInOn.."Font Size||"..
                                    --[[16]]checkRemFocWin.."Remove focus from window (useful when switching Screenset)||"..
                                    --[[17]]"<Reset All|"..
                                    --[[->]]">Support project|"..
                                    --[[18]]"Dodate||"..
                                    --[[19]]"Bug report (Of site forum)|"..
                                    --[[20]]"<Bug report (Rmm forum)||"..
                                    --[[21]]"Close clock window");
            
            
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
                local retval, color = reaper.GR_SelectColor();
                if retval > 0 then;
                    local r, g, b = reaper.ColorFromNative(color);
                    reaper.SetExtState(section,"Color_Text","R"..r.."G"..g.."B"..b,true);
                    R_Text,G_Text,B_Text = r, g, b;
                    Start_GUI();
                end;
                ----
            elseif showmenu == 8 then;
                ----
                reaper.DeleteExtState(section,"Color_Text",true);
                R_Text,G_Text,B_Text = R_Text_Default,G_Text_Default,B_Text_Default;
                Start_GUI();
                ----
            elseif showmenu == 9 then;
                ----
                local retval, color = reaper.GR_SelectColor();
                if retval > 0 then;
                    local r, g, b = reaper.ColorFromNative(color);
                    reaper.SetExtState(section,"Color_Background","R"..r.."G"..g.."B"..b,true);
                    R_Back,G_Back,B_Back = r, g, b;
                    Start_GUI();
                end;
                ----
            elseif showmenu == 10 then;
                ----
                reaper.DeleteExtState(section,"Color_Background",true);
                R_Back,G_Back,B_Back = R_Back_Default,G_Back_Default,B_Back_Default;
                Start_GUI();
                ----
            elseif showmenu == 11 then;
                ----
                local retval, color = reaper.GR_SelectColor();
                if retval > 0 then;
                    local r, g, b = reaper.ColorFromNative(color);
                    reaper.SetExtState(section,"Color_Gui","R"..r.."G"..g.."B"..b,true);
                    R_Gui,G_Gui,B_Gui = r, g, b;
                    Start_GUI();
                end;
                ----
            elseif showmenu == 12 then;
                ----
                reaper.DeleteExtState(section,"Color_Gui",true);
                R_Gui,G_Gui,B_Gui = R_Gui__Default,G_Gui__Default,B_Gui__Default;
                Start_GUI();
                ----
            elseif showmenu == 13 then;
                ----
                reaper.DeleteExtState(section,"Color_Text",true);
                R_Text,G_Text,B_Text = R_Text_Default,G_Text_Default,B_Text_Default;
                reaper.DeleteExtState(section,"Color_Background",true);
                R_Back,G_Back,B_Back = R_Back_Default,G_Back_Default,B_Back_Default;
                reaper.DeleteExtState(section,"Color_Gui",true);
                R_Gui,G_Gui,B_Gui = R_Gui__Default,G_Gui__Default,B_Gui__Default;
                Start_GUI();
                ----
            elseif showmenu == 14 then;
                ----
                if TextBoldNorm == 98 then TextBoldNorm = 0 else TextBoldNorm = 98 end;
                reaper.SetExtState(section,"TextBoldNorm",TextBoldNorm,true);
                Start_GUI();
                ----
            elseif showmenu == 15 then;
                ----
                local retval, retvals_csv = reaper.GetUserInputs("font size",1,"Size: -- < Default = 0 > ++ ",FontSize or 0);
                if retval and tonumber(retvals_csv) then;
                    reaper.SetExtState(section,"FontSize",retvals_csv,true);
                    FontSize = tonumber(retvals_csv);
                    Start_GUI();
                end;
                ----
            elseif showmenu == 16 then;
                ----
                if RemFocusWin == 1 then RemFocusWin = 0 else RemFocusWin = 1 end;
                reaper.SetExtState(section,"RemFocusWin",RemFocusWin,true);
                ----
            elseif showmenu == 17 then;
                ----
                reaper.DeleteExtState(section,"Color_Text",true);
                reaper.DeleteExtState(section,"Color_Background",true);
                reaper.DeleteExtState(section,"Color_Gui",true);
                reaper.DeleteExtState(section,"TextBoldNorm",true);
                reaper.DeleteExtState(section,"FontSize",true);
                reaper.DeleteExtState(section,"RemFocusWin",true);
                reaper.DeleteExtState(section,"PositionDock",true);
                reaper.DeleteExtState(section,"PositionWind",true);
                reaper.DeleteExtState(section,"SizeWindow",true);
                reaper.DeleteExtState(section,"SaveDock",true);
                gfx.quit();
                dofile(({reaper.get_action_context()})[2]);
                do return end;
                ----
            elseif showmenu == 18 then;
                ----
                local path = "https://money.yandex.ru/to/410018003906628";
                OpenWebSite(path);
                reaper.ClearConsole();
                reaper.ShowConsoleMsg("Yandex-money - "..path.."\n\nWebManey - R159026189824");
                ----
            elseif showmenu == 19 then;
                ----
                local path = "https://forum.cockos.com/showthread.php?t=212819";
                OpenWebSite(path);
                ----
            elseif showmenu == 20 then;
                ----
                local path = "https://rmmedia.ru/threads/134701/";
                OpenWebSite(path);
                ----
            elseif showmenu == 21 then;
                ----
                exit();
                ----
            end;
        end;
        ----< End Show Menu >----
        
        ------------------------------
        
        --body--
        
        ------------------------------
        if gfx.getchar() >= 0 then reaper.defer(loop);else;reaper.atexit(exit)return;end;
    end;
    ----< End function loop(); >----
    
    
    
    
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
    
    
    loop();
