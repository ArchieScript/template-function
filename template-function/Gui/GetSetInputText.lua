


    --======================================================
    --======================================================
    --======================================================
          --   Поле для ввода текста / Text box



 


-- Press_OK  1/true интер зажат
--           0/false интер не работает(заблокирован)
--           обычно nil

-- Text = Введенный текст или nil

-- active = true/false подсветка и активация ввода 
-- bufBlit = 0..1023  -- gfx.blit



local CaretPos,Nabirat_Text,Text_x,car_x,flicker; --(Не в цикле)


local function GetSetInputText(x,y,w,h,Press_OK,Text,active,bufBlit); 

    local gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a

    -------------------------
    local function Sub(s,i,j);
        local c,str,x = 0,"",0;
        for _, code in utf8.codes(s)do;
            c=c+1;if not j or j<0 then;j=c+i;x=1;end; 
            if c>=i and c<=j then;local symb=utf8.char(code);str=str..symb;end;
            if x==1 then j=nil end;  
        end;
        return str;
    end
    -------------------------
    x = (x + 2); w = (w - 5);          
    local Rus_char = {  [184]='ё',[224]='а',[225]='б',[226]='в',[227]='г',[228]='д',[229]='е',[230]='ж',
    [231]='з',[232]='и',[233]='й',[234]='к',[235]='л',[236]='м',[237]='н',[238]='о',[239]='п',[240]='р',
    [241]='с',[242]='т',[243]='у',[244]='ф',[245]='х',[246]='ц',[247]='ч',[248]='ш',[249]='щ',[250]='ъ',
    [251]='ы',[252]='ь',[253]='э',[254]='ю',[255]='я',[168]='Ё',[192]='А',[193]='Б',[194]='В',[195]='Г',
    [196]='Д',[197]='Е',[198]='Ж',[199]='З',[200]='И',[201]='Й',[202]='К',[203]='Л',[204]='М',[205]='Н',
    [206]='О',[207]='П',[208]='Р',[209]='С',[210]='Т',[211]='У',[212]='Ф',[213]='Х',[214]='Ц',[215]='Ч',
    [216]='Ш',[217]='Щ',[218]='Ъ',[219]='Ы',[220]='Ь',[221]='Э',[222]='Ю',[223]='Я'} 
    
    if type(Text)=='string'then Nabirat_Text = Text end;
    if not Nabirat_Text then Nabirat_Text =("")end;
    if not CaretPos then CaretPos =(utf8.len(""))end;
    local Enter,pressed,char = false,false,gfx.getchar();
    if active ~= true then char = 0 end;
    
    if char > 0 then;
        if char == 13 then; -- "Enter"
            Enter = true;
        elseif char == 1818584692 then; -- left <
            CaretPos = math.min(math.max(CaretPos-1,0), utf8.len(Nabirat_Text));
        elseif char == 1919379572 then; -- right >
            CaretPos = math.min(math.max(CaretPos+1,0),utf8.len(Nabirat_Text));
        elseif char == 8 then; -- "Backspace ←"
            if CaretPos > 0 then; 
                Nabirat_Text = Sub(Nabirat_Text,1,CaretPos-1)..Sub(Nabirat_Text,CaretPos+1,-1);
                CaretPos = math.min(math.max((CaretPos-1),0), utf8.len(Nabirat_Text));
            end;
        elseif char == 6579564 then; -- Delete 
            Nabirat_Text = Sub(Nabirat_Text,1,CaretPos)..Sub(Nabirat_Text,CaretPos+2,-1); 
        elseif char > 31 and char < 127 then; -- Input_Text         
            Nabirat_Text = Sub(Nabirat_Text,1,CaretPos)..string.char(char)..Sub(Nabirat_Text,CaretPos+1,utf8.len(Nabirat_Text));
            CaretPos = math.min(CaretPos + 1, utf8.len(Nabirat_Text));
        elseif char > 127 and char < 256 then; -- Input_Text_Cyrillic
            Nabirat_Text = Sub(Nabirat_Text,1,CaretPos)..Rus_char[char]..Sub(Nabirat_Text,CaretPos+1,utf8.len(Nabirat_Text));
            CaretPos = math.min(CaretPos + 1, utf8.len(Nabirat_Text));
        end;
        pressed = true;
    end;
    -----------------------------------
    if Press_OK == 1 or Press_OK == true then Enter = true end;
    if Press_OK == 0 or Press_OK == false then Enter = false end; 
    
    ---/bufBlit/-----------------------
    gfx.dest = bufBlit;
    gfx.setimgdim(bufBlit,-1,-1);
    gfx.setimgdim(bufBlit,gfx.w,gfx.h);
    gfx.a = 1;
    -----------------------------------
    
    ---/ поле ввода /-/ input field /---
    gfx.set(0.32, 0.31, 0.3);
    gfx.rect(x-2,y,w+5,h);-- прямоуг
    gfx.set(0.7,0.7,0.7);
    gfx.rect(x,y+2,w+1,h-4);-- прямоуг
    ---------------------------------
    
    ------/ MovingText /-------------
    Text_x = x;
    car_x = x + gfx.measurestr(Sub(Nabirat_Text,1,CaretPos));
    if (car_x-x) >= (w) then; 
         Text_x = (w+x)+x - car_x;
         car_x=(w + x); 
    end;
    ---------------------------------
    
    -------/ Text /------------------
    gfx.setfont(1,"Verdana", h/1.15);
    gfx.x = Text_x; gfx.y = y;
    gfx.set(0.11, 0.11, 0.11);
    gfx.drawstr(Nabirat_Text);
    --------------------------------- 
      
    -------/ BlinkingCursor /---------------------
    if active == true then;
        if not tonumber(flicker) then flicker = 0 end;
        if pressed == true then flicker = 0 end;
        if flicker < 15 then; -- мерцание
            gfx.set(0,0,0);
            gfx.rect(car_x, y+5, 1, h-10);
        end;
        flicker = flicker < 30 and flicker + 1 or 0;
    end;
    --------------------------------------------
    
    ---/bufBlit/-----------------------
    gfx.dest = -1;
    gfx.a = 1;
    gfx.blit(bufBlit,1,0, x,y,w,h,  x,y,w,h,0,0);
    ----------------------------------
    
    ------/ Рамка /-/ Frame /-------                        
    if active == true then;
        gfx.set(0,1,0);
    else;
        gfx.set(0.7,0.7,0.7);
    end;
    
    gfx.rect(x-2,y,w+5,h,0); -- прямоуг рамка 
    -----------------------------------------
    gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    
    return Enter,Nabirat_Text;
    ----------------------------------------------
end
--================================================





--**************************
--//////////////////////////
--\\\\\\\\\\\\\\\\\\\\\\\\\\
--//////////////////////////
--**************************

function mainloop()                            
   TTTTT,TTTTT22222= GetSetInputText(15, 15,300,25,nil,nil,true,150) 
   if    TTTTT then tyyy=5 end    
          
    reaper.defer(mainloop)
end

gfx.init("User_Input", 450, 200, 0, 50, 200)
mainloop()
