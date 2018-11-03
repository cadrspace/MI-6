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



app.get('/', function(req, res){
		res.render('home');
});
app.get('/about', function(req, res){
	var randomMishens = mishens_ID[Math.floor(Math.random() * mishens_ID.length)];
		res.render('about', {mishens_id: randomMishens});
});


//Пользовательская страница 404
app.use(function(req,res, next ){
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

 //запуск программы по умолчанию
 prog_man.start;
 
