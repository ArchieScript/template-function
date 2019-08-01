




    --СКОПИРОВАТЬ ФАЙЛ ИЗ ДИРЕКТОРИИ В ДИРЕКТОРИЮ / ТЕСТ ТОЛЬКО НА WINDOWS

    -- file1 = путь и имя копируемого файла "путь/имя"
    -- file2 = путь и новое имя файла или имя из file1 "путь/имя"


    local function copyFile(file1,file2);
        local in_file = io.open(file1,"rb");
        if not in_file then return false end;
        local in_str = in_file:read("*a");
        in_file:close();
        ----
        local x,i = file2;
        while true do;
            i = (i or 0)+1;
            local check_file = io.open(file2,"r");
            if not check_file then break end;
            check_file:close();
            file2 = x;
            local pach, name = file2:match("(.+)[/\\](.+)");
            local name_no_extension = name:match("(.+)%..-$") or name:match(".+$");
            local extension = name:match(".+(%..-)$");
            file2 = pach.."/"..name_no_extension.."_"..i..extension;
        end;
        ----
        out_file = io.open(file2,"wb");
        if not out_file then return false end;
        out_file:write(in_str);
        out_file:close();
        return true;
    end;























