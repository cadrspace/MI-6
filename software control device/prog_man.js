const app_client = require('./app_client');
var hits = [];
var targets = new Map();
var idAndForm = new Map();

app_client.on('error', (err) => {
  console.log('whoops! there was an error in prog_man.js == ' + err);
});
//process.on('uncaughtException', (err) => {
//  console.log('whoops! there was an error in prog_man.js == ' + err);
//});//

//const app_man1 = require('./mishen');
//const app_man = app_man1.app_man;
//console.log('in prog_man.js');
//обьявляем переменные

var nextCadr = false;
var currentCadr = 0;
//var prog123 = new Map(['num', 2],['rdm', true],['stopFactorTime', true],['stopValue', 500],['next', false],['index', 1]]);

//программа по умолчанию
var prog123 = [];






//prog123[1][index]=2; 	//количество форм в кадре
prog123.push(new Array());


//prog123[0][0] = 14;

  

  
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
//prog123.push(new Array());
prog123[0][1] = p01
//  (['num', [2,3]],
//  ['rdm', false],
//  ['stopFactorTime', false],
 // ['stopValue', 2],
 // ['nextCadr', true]);
  
//второй кадр первая форма
//prog123[2][index]=1;
prog123.push(new Array());
prog123[1][0] = p10
//(
//  ['num', 3],
//  ['rdm', true],
//  ['stopFactorTime', false],
//  ['stopValue', 3],
 // ['nextCadr', false]);

//12345






//конец программы

var currentProgram = prog123;							
var instructionsNum = 1;
var activeMishens = new Array("11","22","33","44","1");			//надо заполнить динамически реальными id мишеней
var freeMishens = activeMishens;

const EventEmitter = require('events');
module.exports = new EventEmitter();
var count =0;

//app_man.on("run",function(){console.log('ii app_man.on');
	//start_cadr(currentProgram);}) ;                                                 
																						  
												  
												  
												  
function start_cadr(program){
	//console.log('in currentProgram. programm = '+ currentProgram);
	count++;
	
	var indexl =1;       //= currentProgram[currentCadr].length; //временно заменён на 1////////////////////////
	//console.log('indexl = '+ indexl);
	var freeMishens = activeMishens;
	instructionsNum = indexl;
	
	//запускаем каждую форму в кадре в своём потоке
	
	for(var i=0; i < indexl ; i++){
		//console.log('лог перед ран програм '+ count);
		count++;
		//console.log('currentProgram = '+ currentProgram);
		//console.log('currentProgram[currentCadr]= '+ currentProgram[currentCadr]);
		//console.log('currentProgram[currentCadr][i] = '+ currentProgram[currentCadr][i]);
		//for (var j in currentProgram[currentCadr][i]){
		//console.log(currentProgram[currentCadr][i]);
		//}
		//for (var [key, value] of currentProgram[currentCadr][i]) {
		// console.log(key + " = " + value);}
		//console.log('currentCadr ='+ currentCadr +' ,i = '+i);
		run_program(currentProgram[currentCadr][i]);
												//????
	}
}

function killed(id, forma, _){			//распарсить дату переданную из события emiter.on в функцию
	//console.log('in killed. idAndForm.get(id) = '+ idAndForm.get(id));
	var localForma = idAndForm.get(id);
	
	console.log('попадание засчитано по мишени id ='+id);
	hits[id] = hits[id] || localForma.get('stopValue')////////////////////тут встал - нужно индифицировать мишень? условие?
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
		//console.log('uslovie = '+uslovie);
		if(targets.has(forma.toString()) ){
		var tmp = targets.get(forma.toString());
		}else{
		var tmp = false
		}
		var tmp2 = tmp || uslovie;
		var tmp3 = forma.toString();
		
		//console.log('tmp ='+ tmp + " ,uslovie = "+ uslovie + ' ,forma.toString() = '+forma.toString());
		//console.log('var tmp2 = '+tmp2+' ,tmp3 = '+tmp3);
		targets.set(tmp3,(tmp2 - 1));// разобраться что не так/////////////////////nenenenenene
		//console.log('test8, target.get(forma.toString()) - 1 = '+(targets.get(forma.toString()) - 1));
		//targets.set(forma.toString(),(target.get(forma.toString()) - 1));
		console.log(id+' убит, осталось '+targets.get(forma.toString())+' целей');
		if (targets.get(forma.toString())==0){
			console.log('все мишени поражены');
		check();
		
		}
	}
}

function check(){
	//console.log('in check()');
	instructionsNum = instructionsNum - 1;
	//console.log('instructionsNum = '+instructionsNum);
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
	
	//если остановка по времени
	if(forma.get('stopFactorTime')) {
		console.log('in if stopFactorTime');
		var timer = setTimeout(check,forma[stopValue]);
		timer();										
		
		//если рандомные
		if(forma.get('rdm')) {
		for(var i=0; i < forma.get('num'); i++){
			var randomId = freeMishens[Math.floor(Math.random()*freeMishens.length)];
			module.exports.emit('start',randomId);
			freeMishens.splice(freeMishens.indexOf(randomId),freeMishens.indexOf(randomId)); //спорный момент, возможно надо менять этот случайный айди с последним и удалять последний
			
		}
		}
		//если выборочные
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
		//var target = forma.get('num');
		
		
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
			module.exports.emit("start",randomId);//////test
			idAndForm.set(randomId, forma);
			//console.log('randomId тип ='+ typeof randomId);
			freeMishens.splice(freeMishens.indexOf(randomId),1); //спорный момент, возможно надо менять этот случайный айди с последним и удалять последний
			//console.log('freeMishens ='+freeMishens);
			}
		}
		//если выборочные +++
		else{/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			console.log('выборочные номера мишеней = '+forma.get('num'));	
			
			var asdasd = forma.get('num');
			//console.log('массив номеров '+asdasd);
			var target = asdasd.length;
			console.log('target ='+target);
			for (var id in forma.get('num')){
			var hz = asdasd[id]+'';
			hits[hz] = needShot;
			console.log('по мишени с id '+hz+' нужно попасть '+hits[hz]);
			//console.log('hz тип ='+ typeof hz);
			app_client.once(hz,killed); 
			module.exports.emit("start",hz);
			idAndForm.set(hz, forma);////////
			//console.log('freeMishens.indexOf(asdasd[id]) = '+freeMishens.indexOf(hz));
			freeMishens.splice(freeMishens.indexOf(hz),1);/////
			//console.log('freeMishens ='+freeMishens);
			}
		}
	}
	
}

exports.start = start_cadr(prog123);



//обрабатываем события

//


