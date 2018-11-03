var express = require('express');

var app = express();

var mishens_ID = [
	"101",
	"102",
	"103",
	"104",
	"105",
	"106"
];

	

//установка механизма представления handlebars
var handlebars = require('express-handlebars').create({defaultLayout:'main' });var handlebars = require('express-handlebars').create({
defaultLayout:'main',
helpers: {
section: function(name, options){
if(!this._sections) this._sections = {};
this._sections[name] = options.fn(this);
return null;
}
}
});
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');

app.set('port', process.env.PORT || 3000);

app.use(express.static(__dirname + '/public'));

//12.10.18------------------ добавляем маршрут страници с формой и разбираем ответ пришедний в теле POST

app.get('/nursery-rhyme', function(req, res){
res.render('nursery-rhyme');
});
app.get('/data/nursery-rhyme', function(req, res){
res.json({
animal: 'бельчонок',
bodyPart: 'хвост',
adjective: 'пушистый',
noun: 'черт',
});
});
app.use(require('body-parser'). urlencoded({ extended: true }));

app.get('/newsletter', function(req, res){
// мы изучим CSRF позже... сейчас мы лишь
// заполняем фиктивное значение
res.render('newsletter', { csrf: 'CSRF token goes here' });
});
app.post('/process', function(req, res){
if(req.xhr || req.accepts('json,html' )==='json' ){
// если здесь есть ошибка, то мы должны отправить { error: 'описание ошибки' }
res.send({ success: true });
} else {
// если бы была ошибка, нам нужно было бы перенаправлять на страницу ошибки
res.redirect(303, '/thank-you' );
}
})

app.post('/process' , function(req, res){
console.log('Form (from querystring): ' + req.query. form);
console.log('CSRF token (from hidden form field): ' + req.body._csrf);
console.log('Name (from visible form field): ' + req.body.name);
console.log('Email (from visible form field): ' + req.body.email);
res.redirect(303, '/thank-you' );
});

//end-----------------------

app.get('/', function(req, res){
		res.render('home');
});
app.get('/about', function(req, res){
	var randomMishens = mishens_ID[Math.floor(Math.random() * mishens_ID.length)];
		res.render('about', {mishens_id: randomMishens});
});


//Пользовательская страница 404
app.use(function(req,res, next ){
	//res.type('text/plain');
	res.status(404);
	res.render('404');
});
//обработчик ошибки 500
app.use(function(req,res, next ){
	console.error(err.stack);
	res.status(500);
	res.render('500');
});
app.listen(app.get('port'), function(){
		console.log( 'Express запущен на http://localhost:' + app.get('port') + ': нажмите Ctrl+C для завершения' );
});

const app_client = require('./app_client');
const prog_man = require('./prog_man');
//const EventEmitter12 = require('events');
//const app_man = new EventEmitter12();
//app_man = new EventEmitter12();
//exports.app_man = app_man;

//app_client.on('error', (err) => {
//  console.log('whoops! there was an error');
//});
process.on('uncaughtException', (err) => {
	console.log('whoops! there was an error in mishen.js' + err);
});

app_client.on('for_app_man', (data) => {console.log('событие из app_client обработано. data = ' + data);
});	

 prog_man.on('done',showResults);
 
 function showResults(){
	 console.log('программа завершена - вывожу результаты.');
 }
 ;

 
 prog_man.start;
 
