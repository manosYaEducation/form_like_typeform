<?php 
$pageTitle = "Administrar - Editar Pregunta";
include __DIR__ . '/../templates/header.php';
?>
<div class="container">
    <h2>Editar Pregunta</h2>
    <?php if(isset($error) && !empty($error)): ?>
        <div class="alert"><?php echo $error; ?></div>
    <?php endif; ?>
    <form action="index.php?action=admin&admin_action=edit&id=<?php echo $question['id']; ?>" method="post">
        <div class="form-group">
            <label for="question_text">Pregunta:</label>
            <textarea name="question_text" id="question_text" required><?php echo htmlspecialchars($question['question_text']); ?></textarea>
        </div>
        <div class="form-group">
            <label for="option_a">Opción A:</label>
            <input type="text" name="option_a" id="option_a" value="<?php echo htmlspecialchars($question['option_a']); ?>" required>
        </div>
        <div class="form-group">
            <label for="option_b">Opción B:</label>
            <input type="text" name="option_b" id="option_b" value="<?php echo htmlspecialchars($question['option_b']); ?>" required>
        </div>
        <div class="form-group">
            <label for="option_c">Opción C:</label>
            <input type="text" name="option_c" id="option_c" value="<?php echo htmlspecialchars($question['option_c']); ?>" required>
        </div>
        <div class="form-group">
            <label for="option_d">Opción D:</label>
            <input type="text" name="option_d" id="option_d" value="<?php echo htmlspecialchars($question['option_d']); ?>" required>
        </div>
        <button type="submit">Actualizar Pregunta</button>
    </form>
    <a href="index.php?action=admin&admin_action=list" class="btn">Volver a la lista</a>
</div>
<?php include __DIR__ . '/../templates/footer.php'; ?>
