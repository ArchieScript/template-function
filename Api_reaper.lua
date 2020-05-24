


  -- _,_, scr_x, scr_y = reaper.my_getViewport(0,0, 0, 0,0, 0,0,0, 1 )--monitor resolution  -- разрешение монитора


  -- Loopstart,LoopEnd = reaper.GetSet_LoopTimeRange(0,1,0,0,0); -- На Линейке (петля)
  -- timeSelStart,timeSelEnd = reaper.GetSet_LoopTimeRange(0,0,0,0,0); -- В Аранже
  
  
    --[[
    buf = reaper.SNM_GetIntConfigVar('undomask',0);
    flag = 1
    GGG1 = buf|(buf|flag)
    GGG2 = buf&~(buf&flag);
    reaper.SNM_SetIntConfigVar(varname,newvalue);
    --]]



  
  
  
  
  
  
  
  
  
  
  
  
  
