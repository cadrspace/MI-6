-- Настройки MQTT
adrMQTT = "qqqqqq" -- адрес брокера
portMQTT = "1883" -- порт
myClient = "qqqqqq" -- Имя клиента у брокера
passMQTT = "qqqqqq" --пароль у брокера
myName = "1" -- имя устройства
topic1 = "qqqqqq" --топик в который отправляется ON и OFF - cтатус устройства
topic2 = "qqqqqq" --топик в который отправляется время срабатывания
topic3 = "qqqqqq" --топик из которого читаем команды "start" и "stop"

print("start program")
wifi.setmode(wifi.STATION) -- установка режима
wifi.sta.clearconfig() -- очистка от барахла
local scfg={} -- таблица установок режима
scfg.auto = true -- входить и поддерживать сеть автоматически
scfg.save = true -- запомнить эти установки во флэше
scfg.ssid = "netname" -- название сетки
scfg.pwd = "netpwd"-- пароль сетки
wifi.sta.config(scfg) -- конфигурируем сеть
wifi.sta.connect()
tmr.alarm(0, 1000, tmr.ALARM_SINGLE,  function()dofile("main.lua") end)
 
--инициализация диода
rpin = 1
gpin = 2
bpin = 3

gpio.mode(rpin,gpio.OUTPUT)
gpio.mode(gpin,gpio.OUTPUT)
gpio.mode(bpin,gpio.OUTPUT)

gpio.write(rpin,gpio.LOW)
gpio.write(gpin,gpio.LOW)
gpio.write(bpin,gpio.LOW)

--инициализация прерываний

pwrpin=4
spin=5

gpio.mode(pwrpin,gpio.OUTPUT)
gpio.mode(spin,gpio.INT,gpio.PULLUP)

gpio.trig(spin)
stime=0