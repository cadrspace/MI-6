local modn = ...
print("Got name", modn)
-- Локальная таблица
local M = {}
M.getwifi = function(call)
    -- есть ли сетка?
    local ip = (wifi.sta.getip())
    -- функция выполнит callback и
    -- выгрузит модуль  из памяти
    local killall = function()
       -- выполнение callback
       if call then call() end
       -- самоуничтожение модуля
       package.loaded[modn] = nil
    end

    -- если мы не в сетке
    if not ip then
        -- создаем СОБЫТИЕ - постоянный таймер на 5 секунд
      tmr.create():alarm(5000, 1, function(t)
            -- узнаем есть ли сетка
            ip = (wifi.sta.getip())
            print("ip now", ip)
            -- если сеть
            if ip then
                -- останавливаем таймер
                tmr.stop(t)
                -- убиваем таймер
                tmr.unregister(t)
                -- убиваем переменную, что содержит таймер
                t = nil
                -- выполняем что надо
                killall()
            end
        end)
        -- событие обработки соединения создано -
        -- начинаем само соединение
        wifi.sta.connect()
    -- ну а если в мы в сетке
    else
        -- выполняем что надо
        killall()
    end
end
return M
