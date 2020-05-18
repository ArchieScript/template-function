






    -- Функция для удаления всех комментариев в файле.lua




    --===========================================================
    local function DeleteAllCommentsLuaFile(text);
        ----
        local t,t2,t3,one,two,cmt,x,Rem = {},{},{},0,0,0,1,nil;
        local boxOpens,boxClose,RemStr,xt = 0,0,nil,nil;
        local SingleLine,boxActiv,Inside = nil,nil,0;
        local LineCom,LineComM,LineComRemove = 0,nil,nil;
        ----
        for val in (text..'\n'):gmatch(".-\n")do;
            t3[#t3+1]=val:gsub('\n$',(' '):rep(2)..'\n');
        end;
        text = table.concat(t3);
        ----
        for val in text:gmatch(".") do;
            t[#t+1] = val;
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
            if LineComRemove then;
                if t[i] ~= '\n' then;
                    t[i] = "";
                else;
                    LineComRemove = nil;
                end;
            end;
            --------------------
            if LineCom == 1 and t[i] ~= "-" then LineCom = 0 end;
            if one==0 and two==0 and not boxActiv and not Rem and not LineComRemove then;
                if LineCom >= 3 then;--4 simb>=
                    if t[i] == "[" or t[i] == "=" and LineComM == 1 then;
                        if t[i] == "[" then;
                            LineCom = 0;
                            LineComM = nil;
                        end;
                    else;
                        t[i-0],t[i-1],t[i-2],t[i-3] = '','','','';
                        LineComRemove = true;
                        LineCom,LineComM = 0,nil;
                        boxOpens,boxClose,SingleLine,cmt,t2 = 0,0,nil,0,{};
                    end;
                end;
                if LineCom == 2 then;
                    LineCom = LineCom+1;
                    if t[i] == "[" then LineComM = 1 end;
                end;
                if t[i] == "-" and LineCom < 2 and not LineComRemove then;
                    LineCom = LineCom+1;
                end;
            end; 
            if not LineComRemove then;
                --------------------------------------------------
                if(t[i]=="'"or t[i]=='"')and Inside>0 and(Inside%2)==1 then xt=t[i]t[i]=''end;
                if(t[i]~="'"or t[i]~='"')and t[i]~='\\'and Inside>0 then Inside = 0 end;
                if(one >= 1 or two >= 1) and t[i]=='\\' then Inside = Inside+1 end;
                ---
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
                if t[i] == '[' and one == 0 and two == 0 and not boxActiv and #t2 < 2 then;
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
            -------
            end;--LineComRemove
            if xt then t[i]=xt xt=nil end;
        end;--End for #t
        text = table.concat(t);
        ----
        t3 = {};
        for val in text:gmatch(".-\n")do;
            t3[#t3+1]=val:gsub('%s%s\n$','\n');
        end;
        ----
        return table.concat(t3);
    end;
    --===================================
    
    --filename = [[C:\\...]]
     
    local file = io.open(filename..'.lua','r');
    if not file then return end;
    local text = file:read('a');
    file:close();
    -----
    text = DeleteAll_Comments(text);
    -----
    file = io.open(filename..'_.lua','w');
    file:write(text)
    file:close();
    --===================================
    
    
    
    
    
    -- https://www.cyberforum.ru/post14543895.html
    
    
    
    
