





    --------------SaveMuteStateAllItemsSlot----------------------------------------------
    -----------------------------------------RestoreMuteStateAllItemsSlot----------------
    function Arc_Module.SaveMuteStateAllItemsSlot(Slot)
        local CountItem = reaper.CountMediaItems(0)
        if CountItem == 0 then return false end
            local GuidAndMute = {}
            _G["Save_GuidAndMuteSlot_"..Slot] = GuidAndMute 
            for i = 1, CountItem do
                local Item = reaper.GetMediaItem(0,i-1)
                GuidAndMute[i] = reaper.BR_GetMediaItemGUID(Item)..' '..
                                 reaper.GetMediaItemInfo_Value(Item,"B_MUTE")
            end 
    end
    -- Save Mute State All Items, Slots
    -- Сохранить Состояние Отключения Звука На Всех Элементах Слоты
    -------------------------------------------------------------------------
    function Arc_Module.RestoreMuteStateAllItemsSlot(Slot, clean)
        local T = _G["Save_GuidAndMuteSlot_"..Slot]
        if T then
            for i = 1, #T do
                local Item = reaper.BR_GetMediaItemByGUID(0,T[i]:match("{.+}"))
                if Item then
                    reaper.SetMediaItemInfo_Value(Item,"B_MUTE",T[i]:gsub("{.+}",""))
                end
            end
            if clean == true or clean == 1 then
                T = nil
                _G["Save_GuidAndMuteSlot_"..Slot] = nil
            end
            reaper.UpdateArrange()
        end
    end
    -- Restore Mute State All Items, Slots
    -- Восстановить Беззвучное Состояние Всех Элементов, Слотов
    -- clean = true или 1 - зачистить сохраненную информацию за собой
    --====End===============End===============End===============End===============End====








