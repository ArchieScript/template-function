

-- Сохронить Востановить отрисованное изображение


        @Michael,  http://rmmedia.ru/threads/118091/page-20#post-1980321
        ----------------------------------------------------------------


       if update_gfx then -- cначала определяем триггер, по которому в какой-либо из буферов будет писаться графика
        gfx.dest = 1 -- номер буфера 1..32 (кажется)
        gfx.setimgdim(1, -1, -1) -- этим я сбрасываю графику внутри этого буфера, иначе она будет писаться поверх того, что уже есть
        gfx.setimgdim(1, w, h) -- определяем размеры записываемой графики
        gfx.a = 1
        gfx.rect(0,0, w,h) -- рисуем что требуется
      end


gfx.dest = -1  -- -1 - это основной слой
gfx.a = 1 -- альфа для буферов
gfx.blit(1, 1, 0, -- этим вытаскиваем первый буфер и сразу его переворачиваем/обрезаем/сжимаем при необходимости
          0,0,w,h,
          0,0,w,h,0,0)
-----------------------------------------------------------------------------------------------------------------




---=======================================
---======================================

local function gfxSaveScrin_buf(buf,h,w)    
    gfx.dest = buf
    gfx.setimgdim(buf, -1, -1)  
    gfx.setimgdim(buf, h, w)  
    gfx.a = 1
end 
  
  
local function gfxRestScrin_buf(buf,h,w)
    gfx.dest = -1
    gfx.a = 1
    gfx.blit(buf,1,0,0,0,gfx.w,gfx.h,0,0,gfx.w,gfx.h,0,0)
end 


---=======================================================
---=======================================================

























