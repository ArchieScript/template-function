    local 
    path,scr_file = reaper.GetResourcePath()..'/Scripts/Archie-ReaScripts/Functions/','Arc_Function_lua.lua';
    local
    scr_file_New = "!!!"..scr_file;
    
    
    -----------------------------------------
    local file = io.open(path..scr_file,'r');
    if not file then error("  There is no file !!! / Нет файла !!!  "..path,1)end;
    local text = file:read('a')..'\n';
    file:close();
    -------------
    
    
    
    --- / Комент.Одностр / -----------
    for var in string.gmatch(text,".-\n")do;
	   if var:match(".-(%-%-[^%[%]]+\n)")then
		  var =  var:match("(.-)%-%-[^%[%]]+\n").."\n"
	   end
	   var2 = (var2 or "")..var;
    end;     
	   
    
    --- / Удалить '\n' / -------------
    for var in string.gmatch(var2,".-\n")do;
	   
	   if not s then
		 if var:match("^%s-\n")then x=(x or 0)+1 else x = 0 end; 
	   end
	   
	   if x >=3 then
		  s=true
		  if var:match("^%s-\n")then;
			 var = "";
		  end;
	   end;    
	   header = (header or "")..var;
    end;
	 
    
   
   
   --- / Записываем в файл / ------    
   file = io.open(path..scr_file_New,"w");
   file:write(header);
   file:close();
   -------------------------------- 
