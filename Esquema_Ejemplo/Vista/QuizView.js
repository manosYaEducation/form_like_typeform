class QuizView {
    constructor() {
        this.container = document.getElementById("quiz-container");
    }

    renderQuestion(question, onSubmit) {
        this.container.innerHTML = ""; // Limpiar contenido

        const questionText = document.createElement("h2");
        questionText.textContent = question.text;
        this.container.appendChild(questionText);

        if (question.options) { // preguntas con alternativas
            question.options.forEach((option) => {
                const button = document.createElement("button");
                button.textContent = option;
                button.onclick = () => onSubmit(option);
                this.container.appendChild(button);
            });
        } else {// preguntas abiertas
            const input = document.createElement("input");
            input.type = "text";
            input.placeholder = "Escribe tu respuesta...";
            const submitBtn = document.createElement("button");
            submitBtn.textContent = "Enviar";
            submitBtn.onclick = () => onSubmit(input.value);
            this.container.appendChild(input);
            this.container.appendChild(submitBtn);
        }
    }


    //Mensajes 


    showResult(isCorrect) {
        this.container.innerHTML = `<h2>${isCorrect ? "✅ Correcto!" : "❌ Incorrecto"}</h2>`;
    }

    showMessage() {
        this.container.innerHTML = `<h2> "✅ Siguiente Pregunta ✅" </h2>`;
    }

    showBlankError() {
        this.container.innerHTML = `<h2> "❌ Debes ingresar información en la Respuesta ❌" </h2>`;
    }

}

export default QuizView;