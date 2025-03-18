<?php
// Asegúrate de que este archivo reciba los datos del controlador
$puntaje = $_SESSION['puntaje'] ?? 0;
$clasificacion = $_SESSION['clasificacion'] ?? 'Sin clasificación';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado de la Encuesta</title>
    <link rel="stylesheet" href="../public/assets/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="Front/img/logo.png" alt="Logo">
            <h1 id="logo">Magallanes <br><span>Sostenible</span></h1>
        </div>
        <div class="welcome-message">
            <p>Beneficios   Pasos   Testimonios   Nosotros   Blog</p>
        </div>
        <div class="menu-icon">
            &#9776;
        </div>
    </nav>

    <div class="split-container">
        <div class="form-container">
            <p class="titulo">¡Gracias por completar la encuesta!</p>
            <p>Tu puntaje obtenido es: <strong><?php echo $puntaje; ?></strong></p>
            <p>Tu clasificación es: <strong><?php echo $clasificacion; ?></strong></p>

            <form action="user_auth.php?action=login" method="post">
                <input type="submit" value="Continuar">
            </form>
        </div>

        <div class="image-section">
            <img src="../img/imagen_lateral.jpg" alt="Imagen descriptiva">
        </div>
    </div>
</body>
</html>