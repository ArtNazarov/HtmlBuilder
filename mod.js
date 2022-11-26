let fs = require('fs');
let evaluator = require('eval');

fs.readFile('nodex.inp', 'utf8', (err, data) => {
  	//if (err) { console.error(err); return; };
	let script  = evaluator(  data );
	let result = script(); // call function
	fs.writeFile('nodex.out', result, function (err) {
  	//if (err) return console.log(err);
	});
});
