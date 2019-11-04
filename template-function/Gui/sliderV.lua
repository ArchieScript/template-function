--sliderV
-- Слайдер вертикаль




    
    
    
    
    
    
    -- block = Отчертить рамку для ориентации, а так всегда 0
    -- x,y,w,h = размер рамки (фейдера) (всего фейдера)
    -- value = значение фейдера  (значение в зависимости от mode)
    -- slowCtrl Замедление при ctrl. чем больше значения - тем больше замедление, обычно 2
    -- mode =0 значение фейдера от 0 до 1; =1 значение фейдера от -1 до 1;
    
    
    local sldF;
    local function sliderV(block,x,y,w,h,value,slowCtrl,mode,hide);
        
        local function slidV(x,y,w,h,val);
            -----------
            --Ресуем колею слайдера, если надо уже, то x+.. y-..
            gfx.gradrect(x+5,y,w-10,h, 1,1,1,1);--пример
            -----------
            
            --======================
            --тут ничего не трогать
            local xx = x;
            local ww = w;
            local hh = (h/100*10);
            local yy = (h+y)-(h*val)-hh/2;
            --что бы полз.не заезжал за гран. на пол полз.--
            if yy < y then yy = y end;
            if yy+hh > y+h then yy = y+h-hh end;
            --======================
            
            --======================
            --ресуем ползунок
            if hide ~= true then;
                ------ Пример квадрат -----
                -- gfx.gradrect(xx,yy   ,ww, hh, 0,0,0,1);
                ------ Пример круг -----
                gfx.r,gfx.g,gfx.b,gfx.a = 0,0,0,1;
                gfx.circle(xx+9  ,yy+7,10,1);
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
            sldF.value = ((y+h)-gfx.mouse_y)/h;
        elseif gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 == 5 and sldF.resistor then;
            if not sldF.pull then sldF.pull = true;
                sldF.gfx__mouse_y = gfx.mouse_y;
                sldF.value = (((y+h)-gfx.mouse_y)/h);
                sldF.value2 = sldF.value;
            else;
                sldF.value=sldF.value2+(sldF.gfx__mouse_y-gfx.mouse_y)/(1000*(slowCtrl or 1));
            end;
        elseif gfx.mouse_cap == 0 and not Mouse then;
            sldF.resistor = false;
            sldF.pull=false;
        end
           if sldF.value < 0 then sldF.value = 0 end;
           if sldF.value > 1 then sldF.value = 1 end;
        slidV(x,y,w,h,sldF.value);
        
        if mode == 1 then;sldF.value = (sldF.value-.5)*2; end;
        
        return tonumber(string.format("%.3f", sldF.value));
    end;
      
    
    
    --------------------
    local function loop();
        val = sliderV(true,20,20,20,150,val or 0, 2, 1);
    end;
    
    
    
    
    
    
    
    
    
    
    
    

    
