<?php 
$pageTitle = "Administración de Preguntas - Lista";
include __DIR__ . '/../templates/header.php';
?>
<div class="container">
    <h2>Lista de Preguntas</h2>
    <a href="index.php?action=admin&admin_action=add" class="btn">Agregar Nueva Pregunta</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Pregunta</th>
                <th>Opciones</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($questions as $q): ?>
            <tr>
                <td><?php echo $q['id']; ?></td>
                <td><?php echo htmlspecialchars($q['question_text']); ?></td>
                <td>
                    A: <?php echo htmlspecialchars($q['option_a']); ?><br>
                    B: <?php echo htmlspecialchars($q['option_b']); ?><br>
                    C: <?php echo htmlspecialchars($q['option_c']); ?><br>
                    D: <?php echo htmlspecialchars($q['option_d']); ?>
                </td>
                <td>
                    <a href="index.php?action=admin&admin_action=edit&id=<?php echo $q['id']; ?>">Editar</a> | 
                    <a href="index.php?action=admin&admin_action=delete&id=<?php echo $q['id']; ?>" onclick="return confirm('¿Está seguro de eliminar esta pregunta?');">Eliminar</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php include __DIR__ . '/../templates/footer.php'; ?>
