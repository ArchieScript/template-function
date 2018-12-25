






 -- Переберает Все семплы в тэйке, работает тормознуто, на очень больших айтемах виснет если "SkipNumberOfSamplesPerChannel" = 0
 -- Устонавливать примерно "SkipNumberOfSamplesPerChannel" = samplerate / 100 - получется сто точек в секунду
 

 --вернет
       -- кол-во сэмплов во всех каналах
       -- кол-во сэмплов в одном  канале
       -- номер сэмпла  со  всех каналов
       -- номер сэмпла с  одного  канала
       -- минимальное  значение   сэмпла
       -- максимальное  значение  сэмпла
       -- время сэмпла
       ---------------


 
 
 


    local function GetSampleNumberPosValue(take,SkipNumberOfSamplesPerChannel,FeelVolumeOfItem)    

        SkipNumberOfSamplesPerChannel = math.floor(SkipNumberOfSamplesPerChannel+0.5);
        if not tonumber(SkipNumberOfSamplesPerChannel) then SkipNumberOfSamplesPerChannel = 0 end;
        if not take or reaper.TakeIsMIDI(take)then return false,false,false,false,false,false,false end;
        local item = reaper.GetMediaItemTake_Item(take);
        -----
        -- Reset Play Rate ----------------------------------------------------------
        local PlayRate_Reset =  reaper.GetMediaItemTakeInfo_Value(take,"D_PLAYRATE");
        local Item_len_Reset = reaper.GetMediaItemInfo_Value(item,"D_LENGTH");
        reaper.SetMediaItemInfo_Value(item,"D_LENGTH",Item_len_Reset * PlayRate_Reset);
        reaper.SetMediaItemTakeInfo_Value(take,"D_PLAYRATE",1);
        --------------------------------------------------------
        local item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION");
        local item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH");
        local accessor = reaper.CreateTakeAudioAccessor(take);
        local source = reaper.GetMediaItemTake_Source(take);
        local samplerate = reaper.GetMediaSourceSampleRate(source);
        local numchannels = reaper.GetMediaSourceNumChannels(source);
        local item_len_idx = math.ceil(item_len);
        -----------------------------------------
        local CountSamples_OneChannel  = math.floor(item_len*samplerate+1);
        local CountSamples_AllChannels = math.floor(item_len*samplerate+1)*numchannels;
        -------------------------------------------------------------------------------
        local NumberSamplesOneChan  = {};
        local NumberSamplesAllChan  = {};
        local Sample_min            = {};
        local Sample_max            = {};
        local TimeSample            = {};
        ---------------------------------
        for i1 = 1, item_len_idx do
            local buffer = reaper.new_array(samplerate*numchannels); -- 1 sec
            local Accessor_Samples = reaper.GetAudioAccessorSamples(
                                                        accessor   , -- accessor
                                                        samplerate , -- samplerate
                                                        numchannels, -- numchannels
                                                        i1-1       , -- starttime_sec
                                                        samplerate , -- numsamplesperchannel
                                                        buffer     ) -- reaper.array samplebuffer
            local ContinueCounting = (i1-1) * samplerate; -- Продолжить Подсчет
            -------------------------------------------------------------------
            for i2 = 1, samplerate*numchannels,numchannels*(SkipNumberOfSamplesPerChannel+1) do;

                -- / min max sample from all channels /------------
                local Sample_min_all_channels = 9^99;
                local Sample_max_all_channels = 0;
                for i3 = 1, numchannels do;
                    local Sample = math.abs(buffer[i2+(i3-1)]);
                    Sample_min_all_channels = math.min(Sample,Sample_min_all_channels);
                    Sample_max_all_channels = math.max(Sample,Sample_max_all_channels);
                end;
                ---
                ---/ Feel volume of item - Чувствительность к громкости элемента /---
                if FeelVolumeOfItem == true then;
                    Sample_min_all_channels = Sample_min_all_channels*reaper.GetMediaItemInfo_Value(item, "D_VOL");
                    Sample_max_all_channels = Sample_max_all_channels*reaper.GetMediaItemInfo_Value(item, "D_VOL");
                end;
                ------
                Sample_min[#Sample_min+1] = Sample_min_all_channels;
                Sample_max[#Sample_max+1] = Sample_max_all_channels;
                ----------------------------------------------------
                NumberSamplesAllChan[#NumberSamplesAllChan+1] = (i2 + ContinueCounting);
                NumberSamplesOneChan[#NumberSamplesOneChan+1] = math.floor(((i2 + ContinueCounting)/numchannels)+0.5);
                ------------------------------------------------------------------------------------------------------
                TimeSample[#TimeSample+1] = ((i2-1)/numchannels+ContinueCounting)/samplerate/PlayRate_Reset+item_pos
                ------------------------------------------------------------------------------------------------------
                if #TimeSample*(SkipNumberOfSamplesPerChannel+1) >= CountSamples_OneChannel then breakX = 1 break end;
            end;
            buffer.clear();
            if breakX == 1 then break end;
        end
        reaper.DestroyAudioAccessor(accessor);
        -----
        -- Restore Play Rate ----------------------------------------------------
        reaper.SetMediaItemInfo_Value(item,"D_LENGTH",item_len / PlayRate_Reset);
        reaper.SetMediaItemTakeInfo_Value(take,"D_PLAYRATE",PlayRate_Reset);
        --------------------------------------------------------------------
        return CountSamples_AllChannels,CountSamples_OneChannel,NumberSamplesAllChan,
               NumberSamplesOneChan,Sample_min,Sample_max,TimeSample;---------------
    end;----------------------------------------------------------------------------
    --------------------------------------------------------------------------------










    local item = reaper.GetSelectedMediaItem(0, 0);
    ------------
    
    local take = reaper.GetActiveTake(item);
    local source = reaper.GetMediaItemTake_Source(take);
    local samples_skip = reaper.GetMediaSourceSampleRate(source)/100-- обработается 100 сэмплов в секунду 
    
    local CountSamples_AllChannels,
          CountSamples_OneChannel,
          NumberSamplesAllChan,
          NumberSamplesOneChan,
          Sample_min,
          Sample_max,
          TimeSample = GetSampleNumberPosValue(take,samples_skip,false)
    
    
    
    
    
