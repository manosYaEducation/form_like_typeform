<?php 
$pageTitle = "Formulario de Preguntas";
include __DIR__ . '/templates/header.php';
?>
<div class="container">
    <h2>Formulario de Preguntas - Página <?php echo $page; ?></h2>
    <form id="questionForm" action="index.php?action=saveAnswers" method="post">
        <?php foreach($questions as $index => $question): ?>
            <div class="question-block">
                <p><strong><?php echo ($offset + $index + 1) . ". " . $question['question_text']; ?></strong></p>
                <div class="options">
                    <label>
                        <input type="radio" name="answer[<?php echo $question['id']; ?>]" value="A" required>
                        <?php echo $question['option_a']; ?>
                    </label>
                    <label>
                        <input type="radio" name="answer[<?php echo $question['id']; ?>]" value="B">
                        <?php echo $question['option_b']; ?>
                    </label>
                    <label>
                        <input type="radio" name="answer[<?php echo $question['id']; ?>]" value="C">
                        <?php echo $question['option_c']; ?>
                    </label>
                    <label>
                        <input type="radio" name="answer[<?php echo $question['id']; ?>]" value="D">
                        <?php echo $question['option_d']; ?>
                    </label>
                </div>
            </div>
        <?php endforeach; ?>
        <input type="hidden" name="page" value="<?php echo $page; ?>">
        <input type="hidden" name="totalPages" value="<?php echo $totalPages; ?>">
        <button type="submit">Siguiente</button>
    </form>
</div>
<?php include __DIR__ . '/templates/footer.php'; ?>
