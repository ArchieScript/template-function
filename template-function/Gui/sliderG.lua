--sliderG 
-- Слайдер горизонталь





      
    
    
    
    
    -- block = Отчертить рамку для ориентации, а так всегда 0
    -- x,y,w,h = размер рамки (фейдера) (всего фейдера)
    -- value = значение фейдера  (значение в зависимости от mode)
    -- slowCtrl Замедление при ctrl. чем больше значения - тем больше замедление, обычно 2
    -- mode =0 значение фейдера от 0 до 1; =1 значение фейдера от -1 до 1;
    -- hide = true скрыть ползунок, а так всегда false.
    
    
    local sldF;
    local function sliderG(block,x,y,w,h,value,slowCtrl,mode,hide);
        if w <= 5 then return value end;
        if w <= 10 then hide = true end;
        local function slidG(x,y,w,h,val);
            -----------
            --Ресуем колею слайдера, если надо уже, то y+.. h-..
            gfx.gradrect(x,y+5,w,h-10, 1,1,1,1);--пример
            -----------
            
            --========================
            --тут ничего не трогать
            local yy = y;
            local hh = h;
            local ww = (w/100*10);
            if ww <= 10 then ww = 10 end;
            local xx = x+(w*val)-ww/2;
            --что бы полз.не заезжал за гран. на пол полз.--
            if xx < x then xx = x end;
            if xx+ww > x+w then xx = x+w-ww end;
            --========================
            
            --======================
            if hide ~= true then;
                --ресуем ползунок
                ------ Пример квадрат -----
                gfx.gradrect(xx,yy,ww,hh, 0,0,0,1);
                ------ Пример круг -----
                gfx.r,gfx.g,gfx.b,gfx.a = 0,0,0,1;
                --gfx.circle(xx+6  ,yy+7,10,1);--только с фикс размером
                --gfx.roundrect(xx,yy   ,ww, hh,10,1 )--адаптив
            end;
            --======================
        end;
        
        ------
        if block == true or block == 1 then;gfx.rect(x, y, w, h,0)end;--block
        ------
         
        sldF=sldF or {};
        sldF.value = value;
        
        if mode == 1 then; sldF.value = (sldF.value+1)/2; end;
        
        if sldF.pull and gfx.mouse_cap&5~=5 then sldF.resistor=false end;
        if sldF.pull and gfx.mouse_cap&5==5 then sldF.resistor=true end;
        if gfx.mouse_cap&1~=1 and gfx.mouse_cap&5~=5 then sldF.pull=false end;
        
        local Mouse =
        gfx.mouse_x>=x and gfx.mouse_x<(x+w)and
        gfx.mouse_y>=y and gfx.mouse_y<(y+h);
        
        if Mouse and gfx.mouse_cap == 0 then sldF.resistor = true end;
        
        if gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 ~= 5 and sldF.resistor then;
            sldF.value = (gfx.mouse_x-x)/w; 
        elseif gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 == 5 and sldF.resistor then;
            if not sldF.pull then sldF.pull = true;
                sldF.gfx__mouse_x = gfx.mouse_x;
                sldF.value = (gfx.mouse_x-x)/w;
                sldF.value2 = sldF.value;   
            else;
               sldF.value=sldF.value2-(sldF.gfx__mouse_x-gfx.mouse_x)/(1000*(slowCtrl or 1));         
            end;
        elseif gfx.mouse_cap == 0 and not Mouse then;
            sldF.resistor = false;
            sldF.pull=false;
        end
           if sldF.value < 0 then sldF.value = 0 end;
           if sldF.value > 1 then sldF.value = 1 end;
        slidG(x,y,w,h,sldF.value);
        
        if mode == 1 then;sldF.value = (sldF.value-.5)*2; end;
        return tonumber(string.format("%.3f", sldF.value));
    end;
    
    
    
    -----------------
    local function loop();
        val = sliderG(true,20,20,150,20,val or 0, 2, 1);
    end;
    
    
    
    
    
    
    
    
    
