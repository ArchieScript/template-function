
String.gmatch (Lua)  Подробнее на сайте: http://uopilot.tati.pro/index.php?title=String.gmatch_(Lua)

string.gmatch
-------------

var - переменная, которой на каждой итерации будет присвоен результат поиска.
s - строка. 
шаблон - что искать или регулярное выражение. 

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



s = {E381ED88-09E1-4598-BC91-5FD79DEB2094}{D5B223F4-C268-4C2D-B47F-01ED019016CB}{37657532-5AE9-4C41-8347-A1C2A6CB96D0}

for <var> in string.gmatch( s , "{..-}" ) do
    bla bla bla
end

на выходе   {E381ED88-09E1-4598-BC91-5FD79DEB2094}
            {D5B223F4-C268-4C2D-B47F-01ED019016CB}
            {37657532-5AE9-4C41-8347-A1C2A6CB96D0}

--    --    --    --    --    --    --    --    --    --


s = &1.0&0.0&0.0&0.0&1.0&1.0&1.0&1.0

for <var> in string.gmatch( s , "[^&]+") do
    bla bla bla
end

на выходе   1.0
            0.0
            0.0
            0.0
            1.0
            1.0
            1.0
            1.0






