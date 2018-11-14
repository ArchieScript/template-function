






     -- Получить таблицу с подкаталогами До Пятого Уровня 






local function GetSubdirectoriesUpToLevelFive(Path);
  local T = {} Enu = reaper.EnumerateSubdirectories;
  for i=0,math.huge do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path.."\\"..f1;
    for i2=0,math.huge do;f2=Enu(Path.."\\"..f1,i2)if f2 then T[#T+1]=Path.."\\"..f1.."\\"..f2;
      for i3=0,math.huge do;f3=Enu(Path.."\\"..f1.."\\"..f2,i3)if f3 then T[#T+1]=Path.."\\"..f1.."\\"..f2.."\\"..f3;
        for i4=0,math.huge do;f4 = Enu(Path.."\\"..f1.."\\"..f2.."\\"..f3,i4)if f4 then T[#T+1]=Path.."\\"..f1.."\\"..f2.."\\"..f3.."\\"..f4;
          for i5=0,math.huge do;f5=Enu(Path.."\\"..f1.."\\"..f2.."\\"..f3.."\\"..f4,i5)if f5 then T[#T+1]=Path.."\\"..f1.."\\"..f2.."\\"..f3.."\\"..f4.."\\"..f5;
            ----------
            ----------
          end;if not f5 then break end;end;
        end;if not f4 then break end;end;
      end;if not f3 then break end;end;
    end;if not f2 then break end;end; 
  end;if not f1 then return T end;end;
end;
















local function GetSubdirectoriesUpToLevelFive(Path);
  local T,Enu,s,h = {Path},reaper.EnumerateSubdirectories,"\\",math.huge; 
  for i=0,h do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path..s..f1;
    for i2=0,h do;f2=Enu(Path..s..f1,i2)if f2 then T[#T+1]=Path..s..f1..s..f2;
      for i3=0,h do;f3=Enu(Path..s..f1..s..f2,i3)if f3 then T[#T+1]=Path..s..f1..s..f2..s..f3;
        for i4=0,h do;f4 = Enu(Path..s..f1..s..f2..s..f3,i4)if f4 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4;
          for i5=0,h do;f5=Enu(Path..s..f1..s..f2..s..f3..s..f4,i5)if f5 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4..s..f5;
          ----------
          end;if not f5 then break end;end;
        end;if not f4 then break end;end;
      end;if not f3 then break end;end;
    end;if not f2 then break end;end; 
  end;if not f1 then return T end;end;
end;








Path = reaper.GetResourcePath() -- returns path where ini files are stored, other things are in subdirectories.
Bla = GetSubdirectoriesUpToLevelFive(Path)  






