







    function FontTextColor(text) 
          --   98 полужирный 
          --  105 курсив
          --  117 подчеркнутый
          --  118 выделенный
          --  115 жырный
          
        gfx.setfont(1,"Verdana",17,98) --установить Шрифты
        ---
        SetColorRGB(100,100,100,1)
        gfx.x, gfx.y = 22, 8 -- уст. gfx.x, gfx.y, строки рисуются отталкиваясь от этих координат!
        gfx.drawstr(text) 
        ---
        SetColorRGB(50,50,50,1)
        gfx.x, gfx.y = 21, 9 
        gfx.drawstr(text) 
        ---
        SetColorRGB(200,200,200,1)
        gfx.x, gfx.y = 20, 10 
        gfx.drawstr(text) 
        gfx.update()
    end
