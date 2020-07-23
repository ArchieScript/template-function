


-- (Requires JS_ReaScriptAPI)





    local function GetSelectedActionsFromActionList();
        local hWnd_action = reaper.JS_Window_Find("Actions",true);
        if not hWnd_action then --[[reaper.MB("Please open Actions list!",'woops',0)]]return {} end;
        local restore_column_state = false;
        local hWnd_LV = reaper.JS_Window_FindChildByID(hWnd_action,1323);
        local combo = reaper.JS_Window_FindChildByID(hWnd_action,1317);
        local sectionName = reaper.JS_Window_GetTitle(combo,"");--save item text to table
        local sectionID = reaper.JS_WindowMessage_Send(combo,"CB_GETCURSEL",0,0,0,0);
        local lv_header = reaper.JS_Window_HandleFromAddress(reaper.JS_WindowMessage_Send(hWnd_LV,"0x101F",0,0,0,0)); -- 0x101F = LVM_GETHEADER
        local lv_column_count = reaper.JS_WindowMessage_Send(lv_header,"0x1200",0,0,0,0);-- 0x1200 = HDM_GETITEMCOUNT
        local third_item = reaper.JS_ListView_GetItemText(hWnd_LV,0,3);
        -- get selected count & selected indexes
        local sel_count,sel_indexes = reaper.JS_ListView_ListAllSelItems(hWnd_LV);
        if sel_count == 0 then;
            --reaper.MB("Please select one or more actions.","woops",0);
            return {};
        end;
        ----
        if lv_column_count < 4 or third_item == "" or third_item:find("[\\/:]")then;
            --show Command ID column
            --reaper.JS_WindowMessage_Send(hWnd_action,"WM_COMMAND",41170,0,0,0);
            restore_column_state = true;
        end;
        local sel_act = {};
        i = 0;
        for index in string.gmatch(sel_indexes,'[^,]+')do;
            local desc = reaper.JS_ListView_GetItemText(hWnd_LV,tonumber(index),1):gsub(".+: ","",1);
            local cmd = tostring(reaper.JS_ListView_GetItemText(hWnd_LV, tonumber(index),3))or '';
            local cmdX = reaper.NamedCommandLookup(cmd);
            if tonumber(cmdX)and cmdX~= 0 then;
                i = i + 1;
                sel_act[i] = {cmd = cmd,name = desc};
            end;
        end;
        if restore_column_state then;
            --reaper.JS_WindowMessage_Send(hWnd_action,"WM_COMMAND",41170,0,0,0);
        end;
        return sel_act,sectionID,sectionName;
    end;
    
    
    sel_act,sectionID,sectionName = GetSelectedActionsFromActionList();

