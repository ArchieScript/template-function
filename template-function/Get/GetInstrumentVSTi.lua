




-- если в имени содержится фраза VSTi то инструмент
-- Получить VSTi инструмент





    local function GetInstrumentVSTi(track, i_fx)
        local _, FXName = reaper.TrackFX_GetFXName(track, i_fx, '')
        if FXName:match('^VSTi:') then FX_instrument = true
        else FX_instrument = false
        end return FX_instrument
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
