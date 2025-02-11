<?php 
$pageTitle = "Registro de Usuario";
// Como este archivo está en "views", usamos __DIR__ . '/templates/header.php'
include __DIR__ . '/templates/header.php';
?>
<div class="container">
    <h2>Registro de Usuario</h2>
    <?php if(isset($error) && !empty($error)): ?>
        <div class="alert"><?php echo $error; ?></div>
    <?php endif; ?>
    <form id="registerForm" action="index.php?action=register" method="post">
        <div class="form-group">
            <label for="rut">RUT:</label>
            <input type="text" name="rut" id="rut" required>
        </div>
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" id="nombre" required>
        </div>
        <div class="form-group">
            <label for="correo">Correo:</label>
            <input type="email" name="correo" id="correo" required>
        </div>
        <button type="submit">Registrarse</button>
    </form>
</div>
<?php include __DIR__ . '/templates/footer.php'; ?>
