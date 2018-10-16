




                
                --  В отличии от: 
                                 string.sub(S, i, j);
                                 --------------------
                --  работает с кирилицей                   
                --====================================         
                          
                          
                          
                          



              -- Возвращает подстроку строки S, которая начинается с символа с индексом i и заканчивается символом с индексом j
              


    local function Sub(s,i,j)
        local c,str,x = 0,"",0;
        for _, code in utf8.codes(s)do;
            c = c + 1;if not j or j<0 then;j = c+i;x=1;end; 
            if c >= i and c <= j then;
                local symb = utf8.char(code);
                str = str..symb;
            end;
            if x == 1 then j = nil end;  
        end;
        return str
    end
    
    
    





