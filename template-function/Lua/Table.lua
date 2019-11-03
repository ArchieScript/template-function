









    --/ Искать в таблице значение /--
    --  Проверить существует ли значение в таблице
    
    function SearchTable(table, val);
        for k, v in pairs(table) do;
            if v == val then return true end;
        end;
        return false;
    end;  
    ---------------------------------
 
 
 
 
 
 
 
    -------- / Сравнить две таблицы / --------
    function ComparedTwoTables(table1, table2);
        if #table1 ~= #table2 then return false end;
        for key, val in pairs(table1) do;
            if table2[key] ~= val then;
                return false;
            end;
        end;
        for key, val in pairs(table2) do;
            if table1[key] ~= val then;
                return false;
            end;
        end;
        return true;
    end;
    ------------------------------------------



------------------------------------------
--Lua: удалить дубликаты элементов - lua-table
https://codeindex.ru/q/59645164-lua-udalit-dublikati-elementov-lua-table.html
-------------------------------------------




-------------------------------------------
Copy Table / Создать копию таблицы
http://lua-users.org/wiki/CopyTable
-------------------------------------------







