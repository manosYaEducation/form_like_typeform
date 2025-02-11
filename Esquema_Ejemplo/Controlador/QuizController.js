import Question from "../Modelo/Question.js";
import QuizView from "../Vista/QuizView.js";

class QuizController {
    constructor() {

        // preguntas base para la prueba de concepto
        this.questions = [
            new Question("¿Capital de Francia?", ["Madrid", "París", "Londres"], "París"),
            new Question("¿2 + 2?", ["3", "4", "5"], "4"),
            new Question("¿Quién escribió 'Cien años de soledad'?", null, "Gabriel García Márquez")
        ];
        this.currentIndex = 0;
        this.view = new QuizView();
        this.showNextQuestion();
    }

// para cerrar el cuestionario
    showNextQuestion() {
        if (this.currentIndex < this.questions.length) {
          //  this.view.renderQuestion(this.questions[this.currentIndex], (answer) => this.checkAnswer(answer));
            this.view.renderQuestion(this.questions[this.currentIndex], (answer) => this.nextQuestion(answer));
        
        
        } else {
            this.view.container.innerHTML = "<h2>🎉 ¡Quiz terminado!</h2>";
        }
    }

  
    nextQuestion(answer) {
        console.log(answer);


        if (answer === "" || answer === null) {
        

            this.view.showBlankError();

            setTimeout(() => {
                this.currentIndex;
                this.showNextQuestion();
            }, 3000);
            

        }
        else{
            
            this.view.showMessage();

            setTimeout(() => {
                this.currentIndex++;
                this.showNextQuestion();
            }, 1000);
    

                }

            }

    //Chequear si esta bien la respuesta si tuviera una respuesta correcta
    // checkAnswer(answer) {
    //     const isCorrect = this.questions[this.currentIndex].isCorrect(answer);
    //     this.view.showResult(isCorrect);
    //     setTimeout(() => {
    //         this.currentIndex++;
    //         this.showNextQuestion();
    //     }, 1000);
    // }
}

export default QuizController;