






    -- Функция для удаления всех комментариев в файле.lua











    local function DeleteAll_Comments(text);
        ----
        local t,t2,one,two,cmt,x,Rem = {},{},0,0,0,1,nil;
        local boxOpens,boxClose,RemStr = 0,0,nil;
        local SingleLine,boxActiv = nil,nil;
        ----
        for val in text:gmatch(".") do;
            t[#t+1]=val;
        end;
        ----
        for i = 1,#t do;
            --------------------
            if Rem then;
                local Cls = RemStr:match('.',x);
                if Cls == t[i] and x == #RemStr then RemStr = nil Rem = nil Cls=nil end;
                if Cls == t[i] then x = x + 1 end;
                if Cls ~= t[i] then x = 1 end;
                t[i] = "";
            end;
            --------------------
            if t[i] == "'" and two == 0 and not boxActiv then;
                if one > 0 then one = 0 else one = 1 end;
            end;
            ---
            if t[i] == '"' and one == 0 and not boxActiv then;
                if two > 0 then two = 0 else two = 1 end;
            end;
            ---
            if t[i] ~= '['then boxOpens = 0 end;
            if t[i] ~= ']'then boxClose = 0 end;
            if t[i] ~= "-" then cmt = 0 end;
            ---
            if t[i] == '[' and one == 0 and two == 0 and not boxActiv then;
                boxOpens = boxOpens+1;
                if boxOpens >= 2 then;
                    boxOpens = 0;
                    boxActiv = true;
                end;
            end;
            --- 
            if t[i] == ']' and one == 0 and two == 0 and boxActiv then;
                boxClose = boxClose+1;
                if boxClose >= 2 then;
                     boxClose = 0;
                     boxActiv = nil;
                end;
            end;
            ---
            if SingleLine then t2[1],t2[2] = '-','-'end;
            if one == 0 and two == 0 and not boxActiv and t[i] == '-' then;
               cmt = cmt + 1;
               if cmt >= 2 then; SingleLine = true; cmt=0 end;
            end;
            ---
            if SingleLine and #t2>=2 then;
                if (t[i] == '[' or t[i] == '=') and #t2 >= 3 then;
                    t2[#t2+1] = t[i];
                elseif t[i] ~= '[' and t[i] ~= '=' and #t2 >= 3 then;
                   t2 = {};
                   SingleLine = nil;
                end;
                ---
                if t[i] == '[' and #t2==2 then;
                    t2[3] = t[i];
                elseif #t2 == 2 and t[i] ~= '[' then;
                    t2 = {};
                    SingleLine = nil;
                end;
                ---
                if #t2 > 3 and t[i] == '[' then;
                    Rem = true;
                    for ii = 1,#t2 do;
                        t[i-(ii-1)] = '';
                    end;
                    RemStr = table.concat(t2):gsub('%s',''):gsub('%-',''):gsub('%[',']');
                    t2 = {};
                    SingleLine = nil;
                    if not RemStr or RemStr=='' then Rem = nil end;
                end;
            end;
        end;--End for #t
        text = table.concat(t);
        ----------------------
        local t = {};
        for str in text:gmatch(".-\n") do;
            ----
            local boxOpens,boxClose,boxActiv = 0,0,nil;
            local one,two,cmt,Str,rem,n = 0,0,0,'',nil,nil;
            for val in string.gmatch(str,".") do;
               if rem then val = '' end;
               if val == '"' and one == 0 and not boxActiv then;
                   if two > 0 then two = 0 else two = 1 end;
               end;
               if val == "'" and two == 0 and not boxActiv then;
                   if one > 0 then one = 0 else one = 1 end;
               end;
               if val ~= '['then boxOpens = 0 end;
               if val ~= ']'then boxClose = 0 end;
               if val ~= "-" then cmt = 0 end;
               
               if val == '[' and one == 0 and two == 0 and not boxActiv then;
                   boxOpens = boxOpens+1;
                   if boxOpens >= 2 then;
                        boxOpens = 0;
                        boxActiv = true;
                   end;
               end;
               if val == ']' and one == 0 and two == 0 and boxActiv then;
                   boxClose = boxClose+1;
                   if boxClose >= 2 then;
                        boxClose = 0;
                        boxActiv = nil;
                   end;
               end;
               if one == 0 and two == 0 and not boxActiv and val == '-' then;
                  cmt = cmt + 1;
                  if cmt >= 2 then;rem = true;end;
               end;
               Str = Str..val;
            end;
            if str:match('\n%s-$')or str:match('\\n%s-$') then;
                n='\n';
            end;
            if str ~= Str then;
                Str = Str:gsub('--$',(n or ''));
            end;
            t[#t+1]=Str;
        end;
        return table.concat(t);
    end;
    
    --===================================
    
    filename = [[C:\\...]]
    
    local file = io.open(filename,'r');
    if not file then return end;
    local text = file:read('a');
    file:close();
    -----
    text = DeleteAll_Comments(text);
    -----
    file = io.open(filename,'w');
    file:write(text)
    file:close();
    --===================================
    
    
    
    
    
    
    -- https://www.cyberforum.ru/post14540897.html
    
    
    
    
