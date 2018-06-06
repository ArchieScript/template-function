




   

    -----------------------------------------------

    --boolean reaper.ReorderSelectedTracks(integer beforeTrackIdx, integer makePrevFolder)

    -- Исправлены следующие недочеты при работе с дочерними треками:
    -- Если выделеный трек-ребенок и если он один в папке и мы перемещаем в эту же папку
    -- то треки выбрасывало из папки.
    -- Cейчас ничего не происходит!или перемещает в папку!
    -- http://goo.gl/Qqqtzh
    -- ---
    -- Если выделены все треки в папке,то все треки выбрасывало из папки
    -- Если вторая переменная 1 то не выбрасывает
    -- Вторую переменную контролировать в таких случаях очень сложно
    -- сейчас ничего не происходит или перемещает в папку
    -- http://goo.gl/P1DfEX
    -- ---
    -- Если перемещаем под последний трек в папке,и если вторая переменная
    -- 0 то трек не закинется в папку, но если мы еще выберем последний трек
    -- в папке то его выбросит из папки, а если вторая переменная 2 то
    -- закинется в папку, и если выбрать последний трек то произойдет, то же самое.
    -- Вторую переменную контролировать в таких случаях очень сложно
    -- Сейчас-же трек не закидывается в папку, но если мы еще выберем последний трек
    -- в папке то тогда закинется в папку
    -- http://goo.gl/uMs19y
    -- ---
    -- и Т.Д.при разных манипуляциях
    -----------------------------




    local function ReorderAllSelTrack( TrackIdx )

        ---------------------------------
        for i = 1, reaper.CountTracks( 0 ) do
            local tr = reaper.GetTrack(0, i - 1)
            if (reaper.GetTrackDepth( tr ) == 0) then
                if (reaper.GetMediaTrackInfo_Value( tr, 'I_FOLDERDEPTH') ~= 1) then
                    reaper.SetMediaTrackInfo_Value( tr, 'I_FOLDERDEPTH', 0)
                end
            end
        end   tr = nil -- http://goo.gl/TH6hxs
        --------------------------------
        local makePrevFolder = 2
        local track, numb, LastTrackFold, Depth, IsTrackSel, tr,
              numb2, Depth2, tr2, Depth3, IsTrackSel2, breakX
        if TrackIdx > 0 then
            track = reaper.GetTrack(0, TrackIdx - 1)
            numb = reaper.GetMediaTrackInfo_Value( track, 'IP_TRACKNUMBER')
            LastTrackFold = reaper.GetMediaTrackInfo_Value( track, 'I_FOLDERDEPTH')
            Depth = reaper.GetTrackDepth( track )
            if LastTrackFold < 0 then
                IsTrackSel = reaper.IsTrackSelected( track )
                if IsTrackSel == false then
                    makePrevFolder = 0
                end
            end
            if Depth > 0 then
                for i = numb - 1, 0, - 1 do
                    tr = reaper.GetTrack(0, i)
                    local _, flagsOut = reaper.GetTrackState( tr )
                    if flagsOut&1 == 1 then
                        numb2 = reaper.GetMediaTrackInfo_Value( tr, 'IP_TRACKNUMBER')
                        Depth2 = reaper.GetTrackDepth( tr )
                        for i = numb2, reaper.CountTracks( 0 ) - 1 do
                            tr2 = reaper.GetTrack(0, i)
                            Depth3 = reaper.GetTrackDepth( tr2 )
                            if Depth3 <= Depth2 then
                                makePrevFolder = 1 breakX = 1 break
                            end
                            IsTrackSel2 = reaper.IsTrackSelected( tr2 )
                            if IsTrackSel2 == false then breakX = 1 break end
                        end
                    end
                    if breakX == 1 then break end
                end
            end
        else
            numb = 0
        end
        reaper.ReorderSelectedTracks(numb, makePrevFolder)
    end 
















