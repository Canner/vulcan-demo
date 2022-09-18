#!/usr/bin/env node

const fs = require('fs');
const duckdb = require('duckdb');

console.log('remove db file');
if (fs.existsSync('demo.db'))
  fs.unlinkSync('demo.db');

const db = new duckdb.Database('demo.db');

async function runQuery(query) {
  return new Promise((resolve, reject) => {
    db.run(query, (err, res) => {
      if (err) return reject(err);
      return resolve(res);
    });
  })
}

(async () => {
  console.log('inserting BankChurners.csv ...');
  await runQuery(`create table bank_churners as select * from "BankChurners.csv"`);
  console.log('done.');
})();