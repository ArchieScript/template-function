














    ---- кол-во ключей в таблице -------------
    local function CountTable(table);
        local x = 0;
        for k,v in pairs(table)do;
            x = x + 1;
        end;
        return x;
    end; 
    ------------------------------------------








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

--delete Duplicates Value In Table
--удалить повторяющиеся значения в таблице


    local function deleteDuplicatesValueInTable(tbl);
        local X, res = {},{};
        for _,v in ipairs(tbl) do;
            if (not X[v]) then;
                res[#res+1] = v;
                X[v] = true;
            end;
        end;
        return res
    end;
-------------------------------------------




-------------------------------------------
Copy Table / Создать копию таблицы
http://lua-users.org/wiki/CopyTable

-------

function table.clone(org)
  return {table.unpack(org)}
end

local abc = {5,12,1}
local def = table.clone(abc)
table.sort(def)
print(abc[2], def[2]) -- 12	5

-------------------------------------------







