const mysql = require('mysql2');

const connectionConfig = {
  host: "100.120.7.187",
  port: 3307,
  user: 'laravel', // Or 'root' for testing
  password: 'laravel', // Replace with the actual password
};

const connection = mysql.createConnection(connectionConfig);

connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MaxScale:', err);
    return;
  }
  console.log('Successfully connected to MaxScale!');

  connection.query('SELECT @@version;', (error, results) => {
    if (error) {
      console.error('Error executing query:', error);
    } else {
      console.log('MaxScale version:', results[0]['@@version']);
    }
    connection.end();
  });
});