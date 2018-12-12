






 --Переберает Все семплы в тэйке, работает тормознуто, на очень больших айтемах виснет
 
 -- вернет вернет номер семпла
 --  максимальное значение семпла от всех каналов
 --  минемальное значение семпла от всех каналов
 --  время сэмпла
 
 
 
 
 

    local item = reaper.GetSelectedMediaItem(0, 0)
    local take = reaper.GetActiveTake(item)
    ---------------------------------------
    
   
    
     
     
    local function GetSampleNumberPosValue(take)    
    
        if reaper.TakeIsMIDI(take) then return -1 end
        local item = reaper.GetMediaItemTake_Item(take)
        local item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
        local item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
        local accessor = reaper.CreateTakeAudioAccessor(take)
        local source = reaper.GetMediaItemTake_Source(take)
        local samplerate = reaper.GetMediaSourceSampleRate(source) 
        local numchannels = reaper.GetMediaSourceNumChannels(source)
        local item_len_i = math.ceil(item_len)
    
    
        local NumSampOneChan = {}
        local Sample_min     = {}
        local Sample_max     = {}
        local TimeSample     = {}
    
        for i1 = 1, item_len_i do    
    
            local buffer = reaper.new_array(samplerate*numchannels)
            buffer.clear()
            local Accessor_Samples = reaper.GetAudioAccessorSamples(  
                                                        accessor   , -- AudioAccessor accessor
                                                        samplerate , -- integer samplerate
                                                        numchannels, -- integer numchannels
                                                        i1-1      , -- number starttime_sec
                                                        samplerate , -- integer numsamplesperchannel
                                                        buffer     ) -- reaper.array samplebuffer                             
            for i2=1, samplerate*numchannels,numchannels do                                    
                  
        
                -- / min max sample from all channels /------------
                local Sample_min_all_channels = 9^99
                local Sample_max_all_channels = 0
                for i3=1, numchannels do
                    local Sample = math.abs(buffer[i2+(i3-1)])
                    Sample_min_all_channels = math.min(Sample,Sample_min_all_channels)
                    Sample_max_all_channels = math.max(Sample,Sample_max_all_channels)   
                end
                ---------------------------------------------------------------------
        
                NumSampOneChan[#NumSampOneChan+1] = #NumSampOneChan + 1   -- number samples from one channel
                Sample_min[#Sample_min+1] = Sample_min_all_channels
                Sample_max[#Sample_max+1] = Sample_max_all_channels
                TimeSample[#TimeSample+1] = #TimeSample / samplerate + item_pos 
           end    
        end  
        
        return  NumSampOneChan,  Sample_min, Sample_max, TimeSample       
    end
             
             
         
    NumSampOneChan,Sample_min_val,Sample_max_val,TimeSample = GetSampleNumberPosValue(take)
    
    
    
    
    
    
    
    
