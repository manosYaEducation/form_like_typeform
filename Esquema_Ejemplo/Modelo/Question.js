class Question {
    constructor(text, options = null, correctAnswer) {
        this.text = text;
        this.options = options; // Puede ser null si es pregunta de texto
        this.correctAnswer = correctAnswer;
    }

    isCorrect(answer) {
        return this.correctAnswer === answer;
    }
}

export default Question;