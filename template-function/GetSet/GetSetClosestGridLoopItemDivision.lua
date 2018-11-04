








                -- Переместить элемент к ближайшему делению (сетки, курсору, выбору времени, к краю итема)
                                          -- 0 откл, 1 вкл
                                          -- snapToGrid = 1 переместится к ближайшему делению сетки
                                          -- snapToEditCur = 1 переместится к курсору
                                          -- snapToLoop = 1 переместится к ближайшему выбору времени
                                          -- snapToitem = 1 переместится к ближайшей позиции элемента
                                          -- snapToitem = 2 переместится к ближайшему концу элемента
                                          -- snapToitem = 3 переместится к ближайшему концу или ближайшей позиции элемента(что ближе)
                              --Если включено все, то переместится туда, что ближе
                 -- Вернет значения - на какое время был перемещён элемент  
                                 -- - элемент
                                 -- - позицию ближайшего деления сетки 
                                 -- - позицию  курсора
                                 -- - ближайшую позицию выбора времени
                                 -- - ближайшую позицию элемента
                                 -- - ближайшую позицию конца элемента
                                 ---------------------------------------------------------------------------------------------
                                     
                -- Move the item to the nearest division (grid,edit cursor, time selection, to edge of the item)
                                          -- 0 откл, 1 вкл
                                          -- snapToGrid = 1 will move to the nearest grid division
                                          -- snapToEditCur = 1 move to cursor
                                          -- snapToLoop = 1 will move to the nearest time selection 
                                          -- snapToitem = 1 will move to the nearest element position
                                          -- snapToitem = 2 will move to the nearest end of the item
                                          -- snapToitem = 3 will move to the nearest end or nearest position of the element (which is closer)
                              --If everything is included, it will move there, which is closer
              -- Returns values -- - for how long was the item moved
                                -- - item
                                -- - the position of the nearest grid division
                                -- - cursor position
                                -- - nearest timing position
                                -- - the closest position of the element
                                -- - the closest position of the end element               
--==========================================================================
                
                


local function GetSetClosestGridLoopItemDivision(Set,item,snapToGrid,snapToEditCur,snapToLoop,snapToitem);
    local distanceToGrid,distanceToEditCur,distanceToLoop,distanceToItemStr,distanceToItemEnd,
          POS_X,END_X,moveTo,distanceToLoopSta,distanceToLoopEnd,ClosLoop;
    local tr = reaper.GetMediaItem_Track(item);
    local TrackNumb = (reaper.GetMediaTrackInfo_Value(tr, "IP_TRACKNUMBER"));
    local posItem = reaper.GetMediaItemInfo_Value(item, "D_POSITION");
    local PosGrid = reaper.SnapToGrid(0,posItem);
    local Startloop,Endloop = reaper.GetSet_LoopTimeRange(0,0,0,0,0);
    local EditCur = reaper.GetCursorPosition();

    if snapToGrid == 1 then;
        distanceToGrid = math.abs(posItem - PosGrid);
    end;

    if snapToEditCur == 1 then;
        distanceToEditCur = math.abs (posItem - EditCur);
    end;

    if snapToLoop == 1 then;
        distanceToLoopSta = math.abs (posItem - Startloop);
        distanceToLoopEnd = math.abs (posItem - Endloop);
        distanceToLoop = math.min(distanceToLoopSta,distanceToLoopEnd);
        if distanceToLoop == distanceToLoopEnd then ClosLoop = Endloop end;
        if distanceToLoop == distanceToLoopSta then ClosLoop = Startloop end;
    end;

    if snapToitem > 0 and snapToitem <= 3 then;
        distanceToItemStr,distanceToItemEnd = 9^99,9^99;
        for i =  reaper.CountMediaItems(0)-1,0,-1 do;
            local it = reaper.GetMediaItem(0,i);
            local tr = reaper.GetMediaItem_Track(it);
            local Number = reaper.GetMediaTrackInfo_Value(tr, "IP_TRACKNUMBER");

            if Number > (TrackNumb-10-1) and Number < (TrackNumb+10+1) then;-- 10 tracks
                if it ~= item then;
                    local POS = reaper.GetMediaItemInfo_Value(it, "D_POSITION");
                    local End = (reaper.GetMediaItemInfo_Value(it, "D_LENGTH")+POS);

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
                end;
            end;
        end;
    end;
    
    local Move = math.min(distanceToGrid or 9^99,distanceToEditCur or 9^99,
                          distanceToLoop or 9^99,distanceToItemStr or 9^99,
                                                 distanceToItemEnd or 9^99);

    if Move == distanceToGrid    then moveTo = PosGrid  end;
    if Move == distanceToEditCur then moveTo = EditCur  end;
    if Move == distanceToLoop    then moveTo = ClosLoop end;
    if Move == distanceToItemStr then moveTo = POS_X    end;
    if Move == distanceToItemEnd then moveTo = END_X    end;
    if not moveTo then moveTo = posItem end;

    if Set == 1 then;
        reaper.SetMediaItemInfo_Value(item, "D_POSITION",moveTo);
    end;
    return (moveTo - posItem),item, PosGrid, EditCur, ClosLoop, POS_X, END_X;
end;














