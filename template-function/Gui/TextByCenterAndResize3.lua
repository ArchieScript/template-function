








-------------------------------------------------------------------
    
Текст По Центру И Изменения Размера.
Координаты в процентах - Пример: x,y,w,h = 50,50,50,50 нижний правый угол.


    local function TextByCenterAndResize(string,x,y,w,h);
        
        local gfx_w = gfx.w/100*w;
        local gfx_h = gfx.h/100*h;
        
        gfx.setfont(1,"Arial",10000);
        local lengthFontW,heightFontH = gfx.measurestr(string);
        
        local F_sizeW = gfx_w/lengthFontW*gfx.texth;
        local F_sizeH = gfx_h/heightFontH*gfx.texth;
        local F_size = math.min(F_sizeW,F_sizeH);
        gfx.setfont(1,"Arial",F_size);
        
        local lengthFont,heightFont = gfx.measurestr(string);
        gfx.x = gfx.w/100*x + (gfx_w - lengthFont)/2; 
        gfx.y = gfx.h/100*y + (gfx_h- heightFont )/2;
    end; 
    
    

----------------------------------------------------------------------
