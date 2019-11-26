





     local time1, time2, time3;
     local function secondClick(interval);
         local Mouse_GState = reaper.JS_Mouse_GetState(1);
         if Mouse_GState == 1 and not time1 then;
             time1 = os.clock();
         end;
         if Mouse_GState ~= 1 and not time2 and time1 then;
             time2 = os.clock();
         end;
         if Mouse_GState == 1 and not time3 and time2 and time1 then;
             time3 = os.clock();
         end;
         if time1 and time2 and time3 then;
             if time1+interval >= time3 then;
                 time1, time2, time3 = nil,nil,nil;
                 return true; 
             end;
         end;
         if Mouse_GState ~= 1 then;
             if not time1 or time1+interval < os.clock()then;
                 time1, time2, time3 = nil,nil,nil;
                 return false;
             end;
         end;
         return false;
     end;
     
     
     
     
     local function loop();
         
         local window, segment, details = reaper.BR_GetMouseCursorContext();
         if window == "tcp" and segment == "empty" and (not details or details == "") then;
             
             bla = secondClick(.5)
             if bla then
                 reaper.Main_OnCommand(40296,0)--Select all tracks
             end
         end;    
     
         reaper.defer(loop);
     end;
