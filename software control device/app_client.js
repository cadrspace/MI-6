//подключаем events и выдаём экземпляр класса при экспорте модуля??{port:1883, username:'llEngi', password:'4a3bc3e1556841979cd1e7963c150f2a'}

const EventEmitter = require('events');

module.exports = new EventEmitter();

const prog_man = require('./prog_man');

//навсякий случай обработка ошибок

//prog_man.on('error', (err) => {
//  console.log('whoops! there was an error');
//});
process.on('uncaughtException', (err) => {
  console.log('whoops! there was an error in app_client.js'+ err);
});
//-----------------------------------------------------------------

//подключаем  mqtt 
var mqtt = require ('mqtt')
var client = mqtt.connect('mqtt://io.adafruit.com',{port:1883, username:'llEngi', password:'4a3bc3e1556841979cd1e7963c150f2a'})

//обрабатываем пришедшие сообщения

client.on ('connect', function(){
	//console.log('в колбэке client.on')
	client.subscribe('llEngi/feeds/sensors-slash-1-slash-out',function(err){
		if(!err){
			//client.publish('llEngi/feeds/sensors-slash-1-slash-out','Hello mqtt')
		}
	})
	client.subscribe('llEngi/feeds/sensors-slash-1-slash-in');
	client.subscribe('llEngi/feeds/sensors-slash-11-slash-out');
	client.subscribe('llEngi/feeds/sensors-slash-11-slash-in');
	client.subscribe('llEngi/feeds/sensors-slash-22-slash-out');
	client.subscribe('llEngi/feeds/sensors-slash-22-slash-in');
	client.subscribe('llEngi/feeds/sensors-slash-33-slash-out');
	client.subscribe('llEngi/feeds/sensors-slash-33-slash-in');
	client.subscribe('llEngi/feeds/sensors-slash-44-slash-out');
	client.subscribe('llEngi/feeds/sensors-slash-44-slash-in');
	
})

client.on('message',function(topic,message){
	//console.log(topic.toString() + '  '+message.toString())
	if(topic == 'llEngi/feeds/sensors-slash-1-slash-out')
	module.exports.emit('1', "1", message.toString());

	if(topic == 'llEngi/feeds/sensors-slash-11-slash-out')
	module.exports.emit('11', "11", message.toString());

	if(topic == 'llEngi/feeds/sensors-slash-22-slash-out')
	module.exports.emit('22', "22", message.toString());

	if(topic == 'llEngi/feeds/sensors-slash-33-slash-out')
	module.exports.emit('33', "33", message.toString());

	if(topic == 'llEngi/feeds/sensors-slash-44-slash-out')
	module.exports.emit('44', "44", message.toString());

	//else module.exports.emit('for_prog_man', message.toString());
})

client.on('error',function(err){
	console.log(err.toString())
})

prog_man.on('start',function(data){
	var topicl = ('llEngi/feeds/sensors-slash-' + data + '-slash-in');   //топик на который отправляем команду старт
	var datal = 'start';												 //текст команды
	client.publish(topicl,datal);
	console.log('отправлено брокеру на топик = '+ topicl + ' ,сообщение = ' + datal);
});
//---------------------------------------------------------------------
//setTimeout(() => {
//	module.exports.emit('ready');
//	}, 1000);
	
//setTimeout(() => {
//	module.exports.emit('stady');
//	}, 10000);
	
//setTimeout(() => {
//	module.exports.emit('go');
//	}, 30000);