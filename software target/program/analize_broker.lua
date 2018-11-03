-- копируем обе глобальные переменные в локальные
local top = mtop
local data = mload

-- Если пришёл старт
if data == "start" then
    -- засекаем время старта
    stime = tmr.now()

    --зажигаем нужный цвет диода
    gpio.write(rpin,gpio.LOW)
    gpio.write(bpin,gpio.LOW)
    gpio.write(gpin,gpio.HIGH)

    --запускаем приём и обработку прерываний

    gpio.trig(spin,"none")
    gpio.trig(spin,"both",function(level,time)
        local reptime = time-stime 
        gpio.trig(spin,"none")

        gpio.write(bpin,gpio.LOW)
        gpio.write(gpin,gpio.LOW)
        gpio.write(rpin,gpio.HIGH)
        
        m:publish(topic2,reptime,1,1,function()print("publishing "..reptime)end)
        end)
end   

if data == "stop" then

    gpio.trig(spin,"none")

    gpio.write(gpin,gpio.LOW)
    gpio.write(rpin,gpio.LOW)
    gpio.write(bpin,gpio.HIGH)
    
end
