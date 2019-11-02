






 --==============================================================================

    -- ГОТОВ:
    --- v 1.2 -------------------------------------------------------------------

    -- Текст По Центру И Изменения Размера.
    -- string - текст
    -- x,y,w,h Координаты в процентах.
    -- ZoomInOn - Обычно 0, или увеличеть/уменьшить на ....
    -- flags - 98 - Жирный; 105 - Курсив; 117 - Подчеркивание; 118 выделенный; иначе nil
    -- [ x_pix,y_pix,w_pix,h_pix - необязательный параметр] - размер в пикселях, если указать то размер  в процентах игнорируется,
                              -- т.е. если указать y_pix то у игнорируется ( полезно, если надо застопорить какую то сторону )

    ----------------------------------------------------------------------
    local function TextByCenterAndResize(string,x,y,w,h,ZoomInOn,flags,r,g,b,x_pix,y_pix,w_pix,h_pix);
        local gfx_x,gfx_y = gfx.x,gfx.y;
        local gfx_w = gfx.w/100*w;
        local gfx_h = gfx.h/100*h;
        if tonumber(w_pix)then gfx_w = math.abs(w_pix)end;
        if tonumber(h_pix)then gfx_h = math.abs(h_pix)end;
        
        gfx.setfont(1,"Arial",10000);
        local lengthFontW,heightFontH = gfx.measurestr(string);
        
        local F_sizeW = gfx_w/lengthFontW*gfx.texth;
        local F_sizeH = gfx_h/heightFontH*gfx.texth;
        local F_size = math.min(F_sizeW+ZoomInOn,F_sizeH+ZoomInOn);
        if F_size < 1 then F_size = 1 end;
        gfx.setfont(1,"Arial",F_size,flags);--BOLD=98,ITALIC=105,UNDERLINE=117
        
        local lengthFont,heightFont = gfx.measurestr(string);
        if x_pix then;
            gfx.x = x_pix + (gfx_w - lengthFont)/2; 
        else;
            gfx.x = gfx.w/100*x + (gfx_w - lengthFont)/2; 
        end;
        if y_pix then;
            gfx.y = y_pix + (gfx_h- heightFont )/2;
        else;
           gfx.y = gfx.h/100*y + (gfx_h- heightFont )/2;
        end;
        gfx.set(r/256,g/256,b/256,1);
        gfx.drawstr(string);
        gfx.x,gfx.y = gfx_x,gfx_y;
    end;
    ----------------------------------------------------------------------
    

     --[[
    Пример: x,y,w,h = 50,50,50,50 нижний правый угол.
    TextByCenterAndResize("string",50,50,50,50,0,nil);     ---------------
                                                           ---------------
                                                           ---------------
                                                           ---------------
                                                           -------       -
                                                           -------       -
                                                           -------       -
                                                           ---------------

    Пример: x,y,w,h = 50,50,50,50 нижний правый угол.
    TextByCenterAndResize("string",50,50,50,50,0,nil, nil,50);  --------------- на 50 пикселях "у" застопорился
                                                                -------       -
                                                                -------       -
                                                                -------       -
                                                                -------       -
                                                                -------       -
                                                                -------       -
                                                                ---------------
                                                                
                                                                

    --]]

 --==============================================================================








 --==============================================================================

-- ГОТОВ:
--- v 1.0 ----------------------------------------------------------------
    
-- Текст По Центру И Изменения Размера.
-- Координаты в процентах.
-- ZoomInOn - Обычно 0, или увеличеть/уменьшить на ....
-- flags - 98 - Жирный; 105 - Курсив; 117 - Подчеркивание; 118 выделенный; иначе nil




    local function TextByCenterAndResize(string,x,y,w,h,ZoomInOn,flags);
        local gfx_w = gfx.w/100*w;
        local gfx_h = gfx.h/100*h;
        
        gfx.setfont(1,"Arial",10000);
        local lengthFontW,heightFontH = gfx.measurestr(string);
        
        local F_sizeW = gfx_w/lengthFontW*gfx.texth;
        local F_sizeH = gfx_h/heightFontH*gfx.texth;
        local F_size = math.min(F_sizeW+ZoomInOn,F_sizeH+ZoomInOn);
        if F_size < 1 then F_size = 1 end;
        gfx.setfont(1,"Arial",F_size,flags);--BOLD=98,ITALIC=105,UNDERLINE=117
        
        local lengthFont,heightFont = gfx.measurestr(string);
        gfx.x = gfx.w/100*x + (gfx_w - lengthFont)/2; 
        gfx.y = gfx.h/100*y + (gfx_h- heightFont )/2;
    end; 
----------------------------------------------------------------------



--[[
Пример: x,y,w,h = 50,50,50,50 нижний правый угол.
TextByCenterAndResize("string",50,50,50,50,0,nil);
gfx.drawstr("string");
--]]

 --==============================================================================









