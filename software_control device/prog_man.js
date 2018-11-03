const app_client = require('./app_client');


app_client.on('error', (err) => {
  console.log('whoops! there was an error in prog_man.js == ' + err);
});

//обьявляем переменные
var hits = [];
var targets = new Map();
var idAndForm = new Map();
var nextCadr = false;
var currentCadr = 0;
var instructionsNum = 1;
var activeMishens = new Array("11","22","33","44","1");			//надо заполнить динамически реальными id мишеней
var freeMishens = activeMishens;



//программа по умолчанию
var prog123 = [];


prog123.push(new Array());

//формы программы  
var p00 = new Map();
 p00.set('num', [1,4]);
 p00.set('rdm', false);
 p00.set('stopFactorTime', true);
 p00.set('stopValue', 10000);
 p00.set('nextCadr', false);
 
  var p01 = new Map();
 p00.set('num', [2,3]);
 p00.set('rdm', false);
 p00.set('stopFactorTime', false);
 p00.set('stopValue', 2);
 p00.set('nextCadr', true);
 
 /*//отрабатывает нормально
  var p10 = new Map();
 p00.set('num', 5);
 p00.set('rdm', true);
 p00.set('stopFactorTime', false);
 p00.set('stopValue', 5);
 p00.set('nextCadr', false);
 */
 
//проверяем 2 условие rdm false
  var p10 = new Map();
 p00.set('num', [22 , 44, 33]);
 p00.set('rdm', false);
 p00.set('stopFactorTime', false);
 p00.set('stopValue', 2);
 p00.set('nextCadr', false);
 
 
//первый кадр первая форма 
prog123[0][0] = p00

//первый кадр вторая форма
prog123[0][1] = p01
  
//второй кадр первая форма
prog123.push(new Array());
prog123[1][0] = p10

//конец программы

var currentProgram = prog123;							

const EventEmitter = require('events');
module.exports = new EventEmitter();

function start_cadr(program){
		
	var indexl =1;       //= currentProgram[currentCadr].length; //временно заменён на 1////////////////////////
	var freeMishens = activeMishens;
	instructionsNum = indexl;
	
	//запускаем каждую форму в кадре в своём потоке
	
	for(var i=0; i < indexl ; i++){
	run_program(currentProgram[currentCadr][i]);
	}
}

function killed(id, forma, _){		
	
	var localForma = idAndForm.get(id);
	
	console.log('попадание засчитано по мишени id ='+id);
	hits[id] = hits[id] || localForma.get('stopValue')
	hits[id] = hits[id] - 1;
	console.log('осталось попасть '+hits[id] +' раз');
	if(hits[id] != 0){
		module.exports.emit("start",id);
		app_client.once(id,killed);
	}
	else{		
		if (localForma.get('rdm')){	
			var uslovie = localForma.get('num');
		}else {
			var uslovie = localForma.get('num').length;
		}
		if(targets.has(forma.toString()) ){
		var tmp = targets.get(forma.toString());
		}else{
		var tmp = false
		}
		var tmp2 = tmp || uslovie;
		var tmp3 = forma.toString();
		
		targets.set(tmp3,(tmp2 - 1));
		console.log(id+' убит, осталось '+targets.get(forma.toString())+' целей');
		if (targets.get(forma.toString())==0){
			console.log('все мишени поражены');
		check();
		
		}
	}
}

function check(){
	instructionsNum = instructionsNum - 1;
	if(instructionsNum == 0) {
		console.log('все условия кадра выполнены, проверяем есть ли кадр дальше');
		if(nextCadr) {
			console.log('запускаю следующий кадр');
			currentCadr++;
			clear();
			start_cadr(currentProgram);
		}
		else{
			console.log('кадров больше нет');
			module.exports.emit('done');
		}
	}	
}

function run_program(forma){
	console.log('условия остановки попадания = '+ !forma.get('stopFactorTime'));
	
	//если остановка по времени -
	if(forma.get('stopFactorTime')) {
		console.log('in if stopFactorTime');
		var timer = setTimeout(check,forma[stopValue]);
		timer();										
		
		//если рандомные -
		if(forma.get('rdm')) {
		for(var i=0; i < forma.get('num'); i++){
			var randomId = freeMishens[Math.floor(Math.random()*freeMishens.length)];
			module.exports.emit('start',randomId);
			freeMishens.splice(freeMishens.indexOf(randomId),freeMishens.indexOf(randomId)); //спорный момент, возможно надо менять этот случайный айди с последним и удалять последний
			
		}
		}
		//если выборочные -
		else{
			for( var i in forma.get('num')){
			module.exports.emit('start', activeMishens[i]);
			app_client.once((activeMishens[i]+''),function(arg){var ololooooo = 321;});//заглушка пока
			freeMishens.splice(freeMishens.indexOf(i),freeMishens.indexOf(i));
			
			}
		}
	}
	//если остановка по попаданиям +
	else{
		console.log('случайный выбор мишеней = '+forma.get('rdm'));
		var needShot = forma.get('stopValue');
		var hits = [];
		
		
		//если рандомные +
		if(forma.get('rdm')) {
			var target = forma.get('num');
			console.log('target ='+target);
			for(var i=0; i < forma.get('num'); i++){
				console.log('в перебре генерирующем рандомные id');
			var randomId = freeMishens[Math.floor(Math.random()*freeMishens.length)];
			hits[randomId] = needShot;
			console.log('по мишени с id '+randomId+' нужно попасть '+hits[randomId]);
			app_client.once((randomId+""),killed);
			module.exports.emit("start",randomId);
			idAndForm.set(randomId, forma);
			freeMishens.splice(freeMishens.indexOf(randomId),1); 
			console.log('freeMishens ='+freeMishens);
			}
		}
		//если выборочные +
		else{
			console.log('выборочные номера мишеней = '+forma.get('num'));	
			
			var asdasd = forma.get('num');
			var target = asdasd.length;
			console.log('target ='+target);
			for (var id in forma.get('num')){
			var hz = asdasd[id]+'';
			hits[hz] = needShot;
			console.log('по мишени с id '+hz+' нужно попасть '+hits[hz]);
			app_client.once(hz,killed); 
			module.exports.emit("start",hz);
			idAndForm.set(hz, forma);
			freeMishens.splice(freeMishens.indexOf(hz),1);
			console.log('freeMishens ='+freeMishens);
			}
		}
	}
	
}

exports.start = start_cadr(prog123);
