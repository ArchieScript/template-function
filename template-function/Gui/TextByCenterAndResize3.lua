







ГОТОВ:
-------------------------------------------------------------------
    
Текст По Центру И Изменения Размера.
Координаты в процентах.
ZoomInOn - Обычно 0, или увеличеть/уменьшить на ....
flags - 98 - Жирный; 105 - Курсив; 117 - Подчеркивание; иначе nil


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
