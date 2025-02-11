<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><?php echo isset($pageTitle) ? $pageTitle : 'Mi Aplicación'; ?></title>
    <!-- Nota: como este archivo se incluye desde la carpeta views, la ruta a los assets debe ser relativa al documento final (public/index.php) -->
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/main.js" defer></script>
</head>
<body>
    <header>
        <h1>Mi Aplicación</h1>
    </header>
    <main>
