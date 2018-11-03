var mishens = [
	"101",
	"102",
	"103",
	"104",
	"105",
	"106",
];
exports.getRandomId = function(){
	var idx = Math.floor(Math.random() * mishens.length);
	return mishens[idx];
};