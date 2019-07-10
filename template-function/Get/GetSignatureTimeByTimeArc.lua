




 -- Получить Подпись Времени По Времени

 --  bpmConvert - true вернет отформатированный bpm, как отображается в проекте,
                  false неотформатированный, полезно для выщитывания. Например: (60 * bpi / bpm) = такт.
                  
    
    
    function GetSignatureTimeByTimeArc(proj,time,bpmConvert);      
        local FindTempTime = reaper.FindTempoTimeSigMarker(proj,time);
        if FindTempTime < 0 then;
            return reaper.GetProjectTimeSignature2(proj);
        else;
            local _,_,_,_,bpm,bpi,_,_ = reaper.GetTempoTimeSigMarker(proj,FindTempTime);
            if bpi < 0 then;
                for i = FindTempTime,0,-1 do;
                    _,_,_,_,_,bpi,_,_ = reaper.GetTempoTimeSigMarker(proj,i);
                    if bpi > 0 then;
                        break;   
                    end;  
                end;
                if bpi < 0 then;
                    bpi = ({reaper.GetProjectTimeSignature2(proj)})[2];
                end;
            end;
            if not bpmConvert or bpmConvert == 0 then;
                bpm = reaper.TimeMap2_GetDividedBpmAtTime(0,time);
            end;
            return bpm, bpi;
        end; 
    end;
    
    
   -- bpm, bpi = GetSignatureTimeByTimeArc(0,7.5,false);
   
   
   
   
   
   
   
   
   
   
   
   
    
