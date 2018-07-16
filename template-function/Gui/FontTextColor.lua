

    --Объемный текст с установленными шрифтами




-- gfx.setfont(1,"Verdana",17,98) -- (обработ.текст 1 вкл,0 выкл;  шрифт; размер текста  ;  * ) -- *
                                                                                             *  --   98 полужирный 
                                                                                                --  105 курсив
                                                                                                --  117 подчеркнутый
                                                                                                --  118 выделенный
                                                                                                --  115 жырный   
                              ---------------------------------------------------------------------------------------------------
    требуется SetColorRGB     https://github.com/ArchieScript/template-function/blob/master/template-function/Gui/SetColorRGB.lua
                         


    function FontTextColor(text) 
          
        gfx.setfont(1,"Verdana",17,98) --установить Шрифты
        TX,TY =         --  строки рисуются отталкиваясь от этих координат!
        ---
        SetColorRGB(100,100,100,1)
        gfx.x, gfx.y = TX+2,TY-2 -- уст. gfx.x, gfx.y, строки рисуются отталкиваясь от этих координат!
        gfx.drawstr(text) 
        ---
        SetColorRGB(50,50,50,1)
        gfx.x, gfx.y = TX+1,TY-1
        gfx.drawstr(text) 
        ---
        SetColorRGB(200,200,200,1)
        gfx.x, gfx.y = TX,TY 
        gfx.drawstr(text) 
        gfx.update()
    end









