<?php
header('Content-Type: application/json');
require_once 'connection.php';

function getJsonInput() {
    return json_decode(file_get_contents('php://input'), true);
}

$method = $_SERVER['REQUEST_METHOD'];
$entity = strtolower($_GET['entity'] ?? '');

// Mappa entità e campi previsti
$entities = [
    'serra' => ['id_serra', 'nome', 'created_at'],
    'utente' => ['id_utente', 'nome', 'email', 'ruolo'],
    'sensore' => ['id_sensore', 'id_serra', 'tipo', 'unita_misura', 'posizione', 'is_active'],
    'lettura' => ['id_lettura', 'id_sensore', 'valore', 'created_at'],
    'soglia_allarme' => ['id_soglia', 'id_sensore', 'id_utente', 'valore_max', 'valore_min', 'azione']
];

if (!isset($entities[$entity])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Entità non valida o mancante. Usa ?entity=serra|utente|sensore|lettura|soglia_allarme']);
    exit;
}

$table = strtoupper($entity);
$fields = $entities[$entity];

switch ($method) {
    case 'GET':
        // Lettura dati (tutti o per id)
        $id_field = $fields[0];
        if (isset($_GET['id'])) {
            $id = intval($_GET['id']);
            $sql = "SELECT * FROM $table WHERE $id_field = $id";
            $result = $conn->query($sql);
            echo json_encode($result->fetch_assoc());
        } else {
            $sql = "SELECT * FROM $table ORDER BY $id_field DESC";
            $result = $conn->query($sql);
            $rows = [];
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
            echo json_encode($rows);
        }
        break;
    case 'POST':
        // Inserimento nuovo dato
        $data = getJsonInput();
        $insert_fields = [];
        $insert_values = [];
        foreach ($fields as $f) {
            if ($f === $fields[0] || $f === 'created_at') continue; // skip PK e timestamp
            if (isset($data[$f])) {
                $insert_fields[] = $f;
                $insert_values[] = "'" . $conn->real_escape_string($data[$f]) . "'";
            }
        }
        $sql = "INSERT INTO $table (" . implode(',', $insert_fields) . ") VALUES (" . implode(',', $insert_values) . ")";
        if ($conn->query($sql)) {
            echo json_encode(['success' => true, 'id' => $conn->insert_id]);
        } else {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => $conn->error, 'sql' => $sql]);
        }
        break;
    case 'PUT':
        // Aggiornamento dato esistente
        $data = getJsonInput();
        $id_field = $fields[0];
        $id = intval($data[$id_field] ?? 0);
        if (!$id) {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'ID mancante']);
            break;
        }
        $set = [];
        foreach ($fields as $f) {
            if ($f === $id_field || $f === 'created_at') continue;
            if (isset($data[$f])) {
                $set[] = "$f='" . $conn->real_escape_string($data[$f]) . "'";
            }
        }
        $sql = "UPDATE $table SET " . implode(',', $set) . " WHERE $id_field=$id";
        if ($conn->query($sql)) {
            echo json_encode(['success' => true]);
        } else {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => $conn->error, 'sql' => $sql]);
        }
        break;
    case 'DELETE':
        // Eliminazione dato
        $id_field = $fields[0];
        if (isset($_GET['id'])) {
            $id = intval($_GET['id']);
            $sql = "DELETE FROM $table WHERE $id_field = $id";
            if ($conn->query($sql)) {
                echo json_encode(['success' => true]);
            } else {
                http_response_code(400);
                echo json_encode(['success' => false, 'error' => $conn->error, 'sql' => $sql]);
            }
        } else {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'ID mancante']);
        }
        break;
    default:
        http_response_code(405);
        echo json_encode(['success' => false, 'error' => 'Metodo non supportato']);
}
$conn->close();
?>
