








                -- Переместить элемент к ближайшему делению (сетки, курсору, выбору времени, к краю итема)
                                          -- 0 откл, 1 вкл
                                          -- snapToGrid = 1 переместится к ближайшему делению сетки
                                          -- snapToEditCur = 1 переместится к курсору
                                          -- snapToLoop = 1 переместится к ближайшему выбору времени
                                           ---------
                                           -- 0 откл, 1 вкл
                                          -- snapToitem = 1 переместится к ближайшей позиции элемента
                                          -- snapToitem = 2 переместится к ближайшему концу элемента
                                          -- snapToitem = 3 переместится к ближайшему концу или ближайшей позиции элемента(что ближе)
                                          -------------
                                          -- если "snapToitem" включён, то переместится к ближайшей позиции
                                          -- MoveToSel = 0 только к невыделенным
                                          -- MoveToSel = 1 только к выделенным
                                          -- MoveToSel = 2 к любым
                                          --------------
                                          -- StartEnd = 0 Переместится к значению началом позиции
                                          -- StartEnd = 1 Переместится к значению концом позиции
                                          ---------------
                              --Если включено все, то переместится туда, что ближе
                              ----------------------------------------------------
              -- Вернет значения -- - на какое время был перемещён элемент  
                                 -- - элемент
                                 -- - позицию ближайшего деления сетки от позиции
                                 -- - позицию ближайшего деления сетки от конца позиции
                                 -- - позицию  курсора
                                 -- - начальную позицию выбора времени
                                 -- - конечную позицию выбора времени
                                 -- - начальную позицию элемента
                                 -- - конечную позицию элемента
                                 ---------------------------------------------------------------------------------------------
                                  
                -- Move the item to the nearest division (grid,edit cursor, time selection, to edge of the item)
                                          -- 0 off, 1 on
                                          -- snapToGrid = 1 will move to the nearest grid division
                                          -- snapToEditCur = 1 move to cursor
                                          -- snapToLoop = 1 will move to the nearest time selection 
                                          --------------
                                          -- 0 off, 1 on
                                          -- snapToitem = 1 will move to the nearest element position
                                          -- snapToitem = 2 will move to the nearest end of the item
                                          -- snapToitem = 3 will move to the nearest end or nearest position of the element (which is closer)
                                          -------------
                                          -- if "snapToitem" enabled, then move to the nearest position
                                          -- MoveToSel = 0 only unselected
                                          -- MoveToSel = 1 only to selected
                                          -- MoveToSel = 2 to any
                                          --------------
                                          --------------
                                          -- StartEnd = 0 Move to the start of position value.
                                          -- StartEnd = 1 Move to end position
                                          ---------------
                           --If everything is included, it will move there, which is closer
                           ----------------------------------------------------------------
               -- Returns values -- - for how long the item was moved
                                 -- - item
                                 -- - the position of the nearest grid division from the position
                                 -- - the position of the nearest grid division from the end of the position
                                 -- - cursor position
                                 -- - start position of timing
                                 -- - end position timing
                                 -- - the initial position of the element
                                 -- - end position of the element
                                 -------------------------------------------------- -------------------------------------------
                
                


    local function GetSetClosestGridLoopItemDivision(Set,item,snapToGrid,snapToEditCur,snapToLoop,snapToitem,MoveToSel,StartEnd);
        local distanceToItemStr,distanceToItemEnd,distanceToGrid_End,distanceToGrid_Str,distanceToEditCurStr,
             POS_X,END_X,moveTo,distanceToLoopSta,distanceToLoopEnd,move_it,ClosLoopEnd,ClosLoopStr,
             distanceToLoop_Sta,distanceToLoop_End,distanceToItemEnd_End,distanceToItemStr_End;
        local tr = reaper.GetMediaItem_Track(item);
        local TrackNumb = (reaper.GetMediaTrackInfo_Value(tr, "IP_TRACKNUMBER"));
        local posItem = reaper.GetMediaItemInfo_Value(item, "D_POSITION");
        local LenItem = reaper.GetMediaItemInfo_Value(item, "D_LENGTH");
        local endItem = posItem + LenItem 
        local StrPosGrid = reaper.SnapToGrid(0,posItem);
        local endPosGrid = reaper.SnapToGrid(0,endItem);
        local Startloop,Endloop = reaper.GetSet_LoopTimeRange(0,0,0,0,0);
        local EditCur = reaper.GetCursorPosition();

        if snapToGrid == 1 then;
            if StartEnd ~= 1 then;
                distanceToGrid_Str = math.abs(posItem - StrPosGrid);
            elseif StartEnd == 1 then;    
                distanceToGrid_End = math.abs(endItem - endPosGrid);
            end;
        end;

        if snapToEditCur == 1 then;
            if StartEnd ~= 1 then;
                distanceToEditCurStr = math.abs (posItem - EditCur);
            elseif StartEnd == 1 then;
                distanceToEditCurEnd = math.abs (endItem - EditCur);
            end;                
        end;

        if snapToLoop == 1 then;
            if StartEnd ~= 1 then;
                distanceToLoop_Sta = math.abs (posItem - Startloop);
                distanceToLoop_End = math.abs (posItem - Endloop);
                distanceToLoopSta = math.min(distanceToLoop_Sta,distanceToLoop_End);
                if distanceToLoopSta == distanceToLoop_End then ClosLoopStr = Endloop end;
                if distanceToLoopSta == distanceToLoop_Sta then ClosLoopStr = Startloop end;
            elseif StartEnd == 1 then;
                distanceToLoop_Sta = math.abs (endItem - Startloop);
                distanceToLoop_End = math.abs (endItem - Endloop);
                distanceToLoopEnd = math.min(distanceToLoop_Sta,distanceToLoop_End);
                if distanceToLoopEnd == distanceToLoop_End then ClosLoopEnd = Endloop end;
                if distanceToLoopEnd == distanceToLoop_Sta then ClosLoopEnd = Startloop end;
            end;
        end;

        if snapToitem > 0 and snapToitem <= 3 then;
            distanceToItemStr,distanceToItemEnd         = 9^99,9^99;
            distanceToItemStr_End,distanceToItemEnd_End = 9^99,9^99;
            for i = reaper.CountMediaItems(0)-1,0,-1 do;
                local it = reaper.GetMediaItem(0,i);
                local Sel = (reaper.IsMediaItemSelected(it)and 1 or 0);
                local tr = reaper.GetMediaItem_Track(it);
                local Number = reaper.GetMediaTrackInfo_Value(tr, "IP_TRACKNUMBER");

                if not tonumber(MoveToSel) then MoveToSel = 2 end;
                if MoveToSel < 0 or MoveToSel > 1 then Sel = MoveToSel end;
                if Sel == MoveToSel then;

                    if Number > (TrackNumb-10-1) and Number < (TrackNumb+10+1) then;-- 10 tracks
                        if it ~= item then;
                            local POS = reaper.GetMediaItemInfo_Value(it, "D_POSITION");
                            local End = (reaper.GetMediaItemInfo_Value(it, "D_LENGTH")+POS);

                            if StartEnd ~= 1 then;
                            
                                if snapToitem == 1 or snapToitem == 3 then;
                                    local distanceIt_Str = math.abs (posItem - POS);
                                    if distanceIt_Str <= distanceToItemStr then;
                                        distanceToItemStr = distanceIt_Str;
                                        POS_X = POS;
                                    end;
                                end;

                                if snapToitem == 2 or snapToitem == 3 then;
                                    local distanceIt_end = math.abs (posItem - End);
                                    if distanceIt_end <= distanceToItemEnd then;
                                        distanceToItemEnd = distanceIt_end;
                                        END_X = End;
                                    end;
                                end;
                            elseif StartEnd == 1 then;  

                                if snapToitem == 1 or snapToitem == 3 then;
                                    local distanceIt_Str_End = math.abs (endItem - POS);
                                    if distanceIt_Str_End <= distanceToItemStr_End then;
                                        distanceToItemStr_End = distanceIt_Str_End;
                                        POS_X_End = POS;
                                    end;
                                end;

                                if snapToitem == 2 or snapToitem == 3 then;
                                    local distanceIt_end_End = math.abs (endItem - End);
                                    if distanceIt_end_End <= distanceToItemEnd_End then;
                                        distanceToItemEnd_End = distanceIt_end_End;
                                        END_X_End = End;
                                    end;
                                end;

                            end;
                        end;
                    end;
                end;
            end;
        end;

        local Move = math.min(distanceToGrid_Str    or 9^99,  distanceToGrid_End   or 9^99,
                              distanceToEditCurStr  or 9^99,  distanceToEditCurEnd or 9^99,
                              distanceToLoopSta     or 9^99,  distanceToLoopEnd    or 9^99,
                              distanceToItemStr     or 9^99,     distanceToItemEnd or 9^99,
                              distanceToItemStr_End or 9^99, distanceToItemEnd_End or 9^99);

        if Move == distanceToGrid_Str then moveTo = StrPosGrid end;
        if Move == distanceToGrid_End then moveTo = endPosGrid-LenItem end;

        if Move == distanceToEditCurStr then moveTo = EditCur  end;
        if Move == distanceToEditCurEnd then moveTo = EditCur-LenItem end;

        if Move == distanceToLoopSta    then moveTo = ClosLoopStr end;
        if Move == distanceToLoopEnd    then moveTo = ClosLoopEnd-LenItem end;

        if Move == distanceToItemStr then moveTo = POS_X    end;
        if Move == distanceToItemEnd then moveTo = END_X    end;

        if POS_X_End then
            if Move == distanceToItemStr_End then moveTo = POS_X_End-LenItem end;
        end
        if END_X_End then
            if Move == distanceToItemEnd_End then moveTo = END_X_End-LenItem end;
        end

        if not moveTo then moveTo = posItem end;

        if Set == 1 then;
            reaper.SetMediaItemInfo_Value(item, "D_POSITION",moveTo);
            move_it = (moveTo-posItem)
        else;
            move_it = 0.0    
        end;

        return move_it,item,StrPosGrid,endPosGrid,EditCur,Startloop,Endloop, posItem, endItem;
    end;
    ------------------------------------------------------------------------------------------














