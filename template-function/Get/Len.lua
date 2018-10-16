                     


Устарело: использовать это >  http://marker.to/8ca8Iv

         

                  --  В отличии от: 
                  --              string.len(S); -- Возвращает длину строки S
                  --              S:len(); -- Эквивалентно
                  --              #S;      -- Эквивалентно          
                                  ------------------------- 
                  --  работает с кирилицей  

                    

                          -- Это вызывает ошибку, если она встречает любую недопустимую последовательность байтов.

                          -- Возвращает длину строки s
              
    local function Len(s)
        local c = 0
        for _, code in utf8.codes(s)do
            c = c + 1 
        end
        return c  
    end
    
    ---------------------------
    
    
    local bla = "привет"
      
    Dlina = Len(bla)  -- Dlina = 6









                           -- http://computercraft.ru/topic/1365-razdelit-stroku-na-simvoly-russkiy-tekst/?do=findComment&comment=19574
