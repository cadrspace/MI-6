-- Глобальные переменные
mtop = "" -- Топик от брокера
mload = "" -- Данные в топике
local pass = passMQTT -- Пароль

-- Создаем MQTT объект
m = mqtt.Client(myClient, 60, myClient, pass)
print("m = ",m)
-- При потере связи брокер выдаст сообщение
m:lwt(topic1, "OFF", 0, 0)

-- Событие - потеря связи
m:on("offline", function(con)
    -- Закрыть соединение
    m:close()
    -- Сбросить флаг наличия связи с брокером
    mod.broker = false
end)

-- Событие - приход сообщения
m:on("message", function(conn, topic, data)

    -- Делаем соообщение глобальным
    mtop = topic
    mload = data

    -- Вызываем обработчик глобального сообщения
    dofile("analize_broker.lua")
end)

-- Выполняем соединение с брокером

m:connect(adrMQTT, portMQTT, 0, 0,
    function(con)
        
        -- Подписываемся на топики
        
        m:subscribe(topic1,0)
        m:subscribe(topic2,0)
        m:subscribe(topic3,0)
        -- Публикуем сообщение на брокере что мы в сети
        m:publish(topic1, "ON", 0,0)
        -- Устанавливаем флаг связи с брокером
        mod.broker = true
        -- зажигаем диод
        gpio.write(bpin,gpio.HIGH)
end)
