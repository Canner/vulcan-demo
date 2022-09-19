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
  console.log('inserting churners.csv ...');
  await runQuery(`
  create table churners as 
  select 
    cast(CLIENTNUM as varchar) as id,
    Customer_Age as age,
    Gender as gender,
    Education_Level as education_level,
    Marital_Status as marital_status,
    Income_Category as income_category,
    Card_Category as card_category,
    Months_on_book as months_on_book,
    Total_Relationship_Count as total_relationship_count,
    Months_Inactive_12_mon as months_inactive_12_mon,
    Contacts_Count_12_mon	as contacts_count_12_mon,
    Credit_Limit as	credit_limit,
    case
      when Attrition_Flag = 'Existing Customer' 
        then false
        else true 
    end as attrited
  from "churners.csv"
  `);
  console.log('done.');

  console.log('inserting customers.csv ...');
  await runQuery(`
  create table customers as 
  select 
    cast(id as varchar) as id,
    first_name,
    last_name,
    email
  from "customers.csv"
  `);
  console.log('done.');
})();