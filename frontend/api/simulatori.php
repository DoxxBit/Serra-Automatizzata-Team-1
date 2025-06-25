<?php
require_once 'connection.php';

function generaValore($tipo) {
    switch ($tipo) {
        case 'temperature':
            return rand(150, 350) / 10; // 15.0 - 35.0 °C
        case 'humidity':
            return rand(300, 900) / 10; // 30.0 - 90.0 %
        case 'light':
            return rand(100, 1000); // 100 - 1000 lux
        default:
            return 0;
    }
}

while (true) {
    $sql = "SELECT id_sensore, tipo FROM SENSORE WHERE is_active = 1";
    $result = $conn->query($sql);
    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $id_sensore = $row['id_sensore'];
            $tipo = $row['tipo'];
            $valore = generaValore($tipo);
            $stmt = $conn->prepare("INSERT INTO LETTURA (id_sensore, valore) VALUES (?, ?)");
            $stmt->bind_param('id', $id_sensore, $valore);
            $stmt->execute();
            $stmt->close();
            echo "[" . date('Y-m-d H:i:s') . "] Sensore $id_sensore ($tipo): $valore inserito.\n";
        }
    } else {
        echo "Nessun sensore attivo trovato.\n";
    }
    flush();
    sleep(10);
}
$conn->close();
?>
