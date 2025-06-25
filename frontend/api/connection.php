<?php
// Parametri di connessione
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'serra';

// Crea la connessione
$conn = new mysqli($host, $user, $password, $dbname);

// Controlla la connessione
if ($conn->connect_error) {
    die('Connessione fallita: ' . $conn->connect_error);
}
// In produzione, non mostrare messaggi di successo
// echo 'Connessione riuscita!';
?>
