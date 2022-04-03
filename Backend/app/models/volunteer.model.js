const sql = require('./db.js');
const VolunteerQueryData = require('./query-models/volunteer-query-data.model.js');
const logger = require('../logger');

const Volunteer = function (body) {
    this.name = body.name;
    this.village = body.village;
    this.date_joined = body.date_joined;
    this.role = body.role;
    this.phone = body.phone;
};

// add new volunteer
Volunteer.prototype.create = function() {
    return new Promise((resolve, reject) => {
        sql.query('INSERT INTO volunteers (name, village, date_joined, role, phone) VALUES (?)',
        [[this.name, this.village, this.date_joined, this.role, this.phone]],
        function(err, results) {
            if (err) reject (err);
            else resolve(results.insertId);
        });
    });
}

// list all volunteers
Volunteer.listAll = function () {
    return new Promise(function (resolve, reject) {
        sql.query('SELECT * FROM volunteers', 
        function (err, rows) {
            if (err) reject (err);
            else {
                resolve(rows);
            }
        });
    });
};

Volunteer.queryData = function (query_params) {
    return new Promise((resolve, reject) => {
      const q = new VolunteerQueryData(query_params);
      q.constructQuery();
      const page_query =`SELECT COUNT(*) AS count FROM volunteers ${q.query}`
      const data_query = ` 
      SELECT
        volunteers.volunteer_id, volunteers.name, volunteers.village, volunteers.date_joined, volunteers.role, volunteers.phone
      FROM volunteers 
        ${q.query}
      LIMIT ${q.offset}, ${q.limit}
      `;
      sql.query(data_query, (err, row) => {
        if (err) reject(err);
        page_count = row
      }); 
      sql.query(page_query, (error, page) => { 
        if (error) reject(error);
        sql.query(data_query, (err, row) => {
          if (err) reject(err);
            resolve([page[0],row])
        }); 
      });
    });
  };


module.exports = Volunteer;