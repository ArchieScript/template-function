












 -- координаты мыши для кнопки
 
      x - от левого края до кнопки
      y - от верха до кнопки
      w - от левого края кнопки до правого края кнопки
      h - от верхнего края кнопки до нижнего края кнопки







    local function Mouse_Is_Inside(x, y, w, h) --мышь находится внутри
        local mouse_x, mouse_y = gfx.mouse_x, gfx.mouse_y
        local inside =
        mouse_x >= x and mouse_x < (x + w) and
        mouse_y >= y and mouse_y < (y + h)
        return inside
    end



