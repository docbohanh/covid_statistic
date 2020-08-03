'use strict';

var express = require('express');
var port = process.env.PORT || 3000;
var app = express();

var axios = require("axios");
var cheerio = require('cheerio');

var bodyParser = require('body-parser');
app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true })); 

app.get('/api/coronavirus', function (req, res) {
  res.setHeader('Content-Type', 'application/json');

  axios.get('http://www.worldometers.info/coronavirus') 
    .then((response) => {
      if(response.status === 200) {

        const html = response.data;
        const $ = cheerio.load(html); 
          
        var rows = $("table#main_table_countries_today tbody tr"); 
        
        var data = [];

        rows.each((i, elem) => {
          const row = [];
          $(elem).children("td").each((i, elem) => {
            row.push($(elem).text().trim().replace(/,/g, "")) 
          });
            
          data.push({
            'country': row[1],
            'totalCases': row[2],
            'newCases': row[3],
            'totalDeaths': row[4],
            'newDeaths': row[5],
            'totalRecovered': row[6],
            'activeCases': row[8],
            'seriousCritical': row[9],
            'area': row[15]
          });
        })

        var jsonSuccess = {
          'code': 1,
          'message': 'Web crawler data from http://www.worldometers.info/coronavirus',
          'data': data
        };  
        res.send(jsonSuccess);

      }
    }, (error) => res.send({
      'code': 0,
      'message': 'Failed',
      'data': error
    })
  );
});

app.listen(port, function () {
  console.log(`Example app listening on port !`);
});