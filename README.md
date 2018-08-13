>## template-function [>>>](https://github.com/ArchieScript/template-function/tree/master/template-function)
###### [ArchieScript/ReaScrit](https://github.com/ArchieScript/ReaScrit)
------------------------------------------------------------------------------------------------------------------
>### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [Get](https://github.com/ArchieScript/template-function/tree/master/template-function/Get)           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      [Set](https://github.com/ArchieScript/template-function/tree/master/template-function/Set)           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      [Save](https://github.com/ArchieScript/template-function/tree/master/template-function/Save)         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      [Rest](https://github.com/ArchieScript/template-function/tree/master/template-function/Rest)         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      [Gui](https://github.com/ArchieScript/template-function/tree/master/template-function/Gui)           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      [Lua](https://github.com/ArchieScript/template-function/tree/master/template-function/Lua)           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                                                  
---   
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#


>[Get](https://github.com/ArchieScript/template-function/tree/master/template-function/Get)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [GetInstrumentVSTi](https://github.com/ArchieScript/template-function/blob/master/template-function/Get/GetInstrumentVSTi.lua)                                      &nbsp;&nbsp;-- _Получить VSTi инструмент_
>
>
>
#
#

>[Save](https://github.com/ArchieScript/template-function/tree/master/template-function/Save) 
>
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [Save Solo Mute State All Tracks { [table] }](https://github.com/ArchieScript/template-function/blob/master/template-function/Save/Save%20Solo%20Mute%20State%20All%20Tracks%20%7B%20%5B%20table%20%5D%20%7D.lua)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [Save Restore selected items   {[table]}](https://github.com/ArchieScript/template-function/blob/master/template-function/Save/Save%20Restore%20selected%20items%20%20%20%7B%5Btable%5D%7D.lua)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [Save,Restore,selected tracks( guid { [table] } )](https://github.com/ArchieScript/template-function/blob/master/template-function/Save/Save%20restore%20selected%20tracks%20%7B%5Btablep%5D%7D.lua)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [SaveRestoreSelEnvPoint(Env, SaveRest)](https://github.com/ArchieScript/template-function/blob/master/template-function/Save/SaveRestoreSelEnvPoint.lua) -- Сохранить востановить выделенные точки автоматизации
>
>

#
#

>[Set](https://github.com/ArchieScript/template-function/tree/master/template-function/Set)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [SetCollapseFolderMCP (MPL)](https://github.com/ArchieScript/template-function/blob/master/template-function/Set/SetCollapseFolderMCP%20(MPL).lua)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [SetMediaItemLeftTrim( value , item )](https://github.com/ArchieScript/template-function/blob/master/template-function/Set/SetMediaItemLeftTrim(value%2Citem).lua) &nbsp;&nbsp;--_Установить левую часть элемента мультимедиа(обрезать,удленить с    лева)_
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                           [SetSoloMuteAllTracks(valSolo,valMute)](https://github.com/ArchieScript/template-function/blob/master/template-function/Set/SetSoloMuteAllTracks.lua)-- включть,выключиить звук во всех треках
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [SetToggleButtonOnOff(numb)](https://github.com/ArchieScript/template-function/blob/master/template-function/Set/SetToggleButtonOnOff.lua)-- Установить  Кнопку Переключателя Вкл Выкл
>



#
#
>[Rest](https://github.com/ArchieScript/template-function/tree/master/template-function/Rest)  
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [DeleteOnlyTrack(track)](https://github.com/ArchieScript/template-function/blob/master/template-function/Rest/DeleteOnlyTrack(track).lua ) -- При удалении последнего трека в папке не закидывает следующие треки в предыдущую папку 
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [reorderAllSelTrack( TrackIdx )](https://github.com/ArchieScript/template-function/blob/master/template-function/Rest/ReorderAllSelTrack.lua) -- Перемещает все выбранные треки непосредственно над дорожкой, указанной индексом 
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [CompareStrings(string,find_in_string )](https://github.com/ArchieScript/template-function/blob/master/template-function/Rest/CompareStrings.lua) -- Сравнить строки на совпадения
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [If_Equals(EqualsToThat,...)](https://github.com/ArchieScript/template-function/blob/master/template-function/Rest/If_Equals.lua) -- функция для сокращения условий  
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [msg('test',true false )](https://github.com/ArchieScript/template-function/blob/master/template-function/Rest/msg.lua) -- открыть консоль с сообщением
>



#
#
>[Gui](https://github.com/ArchieScript/template-function/tree/master/template-function/Gui) 
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [SetColorRGB(r,g,b,a)](https://github.com/ArchieScript/template-function/blob/master/template-function/Gui/SetColorRGB.lua)-- Установить  Цвет R.G.B.A. (RGB = Цвет; A = яркость) 
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [Mouse_Is_Inside(x, y, w, h)](https://github.com/ArchieScript/template-function/blob/master/template-function/Gui/Mouse_Is_Inside.lua)-- установить координаты мыши для кнопки
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                            [FontTextColor(text)](https://github.com/ArchieScript/template-function/blob/master/template-function/Gui/FontTextColor.lua)-- Объемный текст с установленными шрифтами



#
#
>[Lua](https://github.com/ArchieScript/template-function/tree/master/template-function/Lua)
>
>##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                             [string.gmatch](https://github.com/ArchieScript/template-function/blob/master/template-function/Lua/string.gmatchstring.gmatch.lua) <li> &nbsp;&nbsp;&nbsp;&nbsp; _подробнее [здесь](http://uopilot.tati.pro/index.php?title=String.gmatch_(Lua))_
>
>##### [tonumber(string.format("%.1f", X))](https://github.com/ArchieScript/template-function/blob/master/template-function/Lua/tonumber-string.format-.1f-%20user_input_str.lua) &nbsp;&nbsp;&nbsp;&nbsp;--СОКРОТИТЬ ЧИСЛО ПОСЛЕ ЗАПЯТОЙ
>





 
---
