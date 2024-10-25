const express = require('express');
const app = express();
const hbs = require('hbs');
const wax = require('wax-on');
wax.on(hbs.handlebars);
wax.setLayoutPath("./views/layouts");


const helpers = require('handlebars-helpers');

helpers({
    'handlebars': hbs.handlebars
})

require('dotenv').config();

const {createConnection} = require('mysql2/promise');

app.set("view engine", "hbs");

app.use(express.urlencoded());

async function main() {

    const connection = await createConnection({
        'host': process.env.DB_HOST, // or 127.0.0.1
        'user': process.env.DB_USER,
        'database': process.env.DB_DATABASE, // name of the database to use
        'password': process.env.DB_PASSWORD
    });

    // app.get('/students', async (req, res) => {
    //     let [students] = await connection.execute('SELECT * FROM students INNER JOIN tutors ON students.student_id = tutors.tutor_id ');
    //     res.render('layouts/students', {
    //         'students': students
    //     })
    // })
    
        app.get('/students', async (req,res) => {
        let[ students] = await connection.execute
    ('SELECT *, students.first_name AS students_first_name, students.last_name AS students_last_name, tutors.first_name AS tutors_first_name, tutors.last_name AS tutors_last_name FROM students INNER JOIN tutors ON students.tutor_id = tutors.tutor_id ORDER BY students_first_name ASC ;');
  console.log(students)
res.render ('layouts/students', {
'students' : students
})
})

    
    app.get('/students/create', async function (req, res) {
        const [tutors] = await connection.execute('SELECT * FROM tutors');
        res.render('students/create', {
            "tutors": tutors
        })
    });



    app.post('/students/create', async function (req, res) {
        // req.body will contain what the user has submitted through the form
        // we are using PREPARED STATEMENTS (to counter SQL injection attacks)
        const sql = `
            INSERT INTO students (first_name, last_name,date_of_birth, tutor_id)
            VALUES (?, ?, ?, ?);`

        const bindings = [
            req.body.first_name,
            req.body.last_name,
            req.body.date_of_birth,
            req.body.tutor_id
         ]

        await connection.execute(sql, bindings);
        res.redirect('/students');
    });





    app.get('/students/:student_id/edit', async function (req, res) {

        const studentId = req.params.student_id;

        const [students] = await connection.execute('SELECT * FROM students WHERE student_id = ?',[studentId]);

        const student = students[0];

        const [tutors] = await connection.execute('SELECT * FROM tutors');

        res.render('students/edit', {
            student,
            tutors
        })
    });



    app.post('/students/:student_id/edit', async function (req, res) {
        try {
            const { first_name, last_name, date_of_birth, tutor_id, } = req.body;

            if (!first_name || !last_name || !date_of_birth || !tutor_id) {
                throw new Exception("Invalid values");
            }

            const sql = `UPDATE students SET first_name=?, last_name=?, date_of_birth=?, tutor_id=?
                            WHERE student_id = ?;`

            const bindings = [first_name, last_name, date_of_birth, tutor_id, req.params.student_id];

        await connection.execute(sql, bindings);

            res.redirect("/students");
        } catch (e) {
            res.status(400).send("Error " + e);
        }
    });

    app.get('/students/:student_id/delete', async function (req, res) {
        // display a confirmation form 
        const [students] = await connection.execute(
            "SELECT * FROM students WHERE student_id =?", [req.params.student_id]
        );
        const student = students[0];

        res.render('students/delete', {
            student
        })

    });

    app.post('/students/:student_id/delete', async function (req, res) {
        await connection.execute('DELETE FROM students WHERE student_id = ?',
             [req.params.student_id]);
        res.redirect('/students');
    });
}

main();



app.listen(3000, function () {
    console.log("Server has started");
})