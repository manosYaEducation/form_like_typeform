document.addEventListener("DOMContentLoaded", function () {
  // 1. Tomar category_id de la URL
  const params = new URLSearchParams(window.location.search);
  let categoryId = parseInt(params.get('category_id')) || 0;

  let totalCategories = 0;
  let questions = [];
  let active = 0;               // índice de la pregunta activa
  let selectedAnswers = [];
  let isAnimating = false;
  let isSubmitting = false;     // Evitar doble envío

  // Mapeo de puntajes (A=4, B=3, C=2, D=1)
  const letterScores = { "A": 4, "B": 3, "C": 2, "D": 1 };

  // Referencia al botón "prev" (debe existir en el HTML con id="prev")
  const prevButton = document.getElementById("prev");

  // 2. Cargar preguntas de la categoría
  fetch(`../../fetch_questions.php?category_id=${categoryId}`)
    .then(res => res.json())
    .then(data => {
      console.log("Data from fetch_questions.php =>", data);
      if (data.status === 'success') {
        // Subtítulo con el nombre de la categoría (opcional)
        const categorySubtitle = document.getElementById('categorySubtitle');
        if (categorySubtitle && data.category_name) {
          categorySubtitle.textContent = data.category_name;
        }

        questions = data.questions;
        totalCategories = data.totalCategories;

        console.log("questions.length =>", questions.length);
        questions.forEach((q, i) => {
          console.log(`questions[${i}] =>`, q);
        });

        selectedAnswers = []; // Array vacío para las respuestas de esta categoría
        buildSliderItems();
        loadShow();
      } else {
        console.error("Error:", data.message);
      }
    })
    .catch(err => console.error("Fetch error:", err));

  // 3. Construir el carrusel de preguntas
  function buildSliderItems() {
    const sliderContainer = document.getElementById("sliderContainer");
    sliderContainer.innerHTML = "";

    // Crear contenedor para el botón "Pregunta anterior"
    const prevQuestionContainer = document.createElement('div');
    prevQuestionContainer.id = "prevQuestionContainer";
    prevQuestionContainer.className = "prev-question-container";

    // Crear botón "Pregunta anterior"
    const prevQuestionBtn = document.createElement('button');
    prevQuestionBtn.className = "prev-question-btn";
    prevQuestionBtn.textContent = "Pregunta anterior";
    prevQuestionBtn.addEventListener('click', () => {
      if (!isAnimating && active > 0) {
        active--;
        loadShow();
      }
    });

    prevQuestionContainer.appendChild(prevQuestionBtn);
    sliderContainer.appendChild(prevQuestionContainer);

    questions.forEach((q, index) => {
      const itemDiv = document.createElement('div');
      itemDiv.classList.add('item', 'quiz-card');

      const pQuestion = document.createElement('p');
      pQuestion.textContent = `${index + 1}.- ${q.question_text}`;
      itemDiv.appendChild(pQuestion);

      const optionsDiv = document.createElement('div');
      optionsDiv.classList.add('options');

      const letters = ['A', 'B', 'C', 'D'];
      letters.forEach(letter => {
        const btnOption = document.createElement('button');
        btnOption.textContent = `${letter}. ${q["option_" + letter.toLowerCase()]}`;

        btnOption.addEventListener('click', () => {
          handleOptionClick(index, letter, btnOption);
        });

        optionsDiv.appendChild(btnOption);
      });

      itemDiv.appendChild(optionsDiv);
      sliderContainer.appendChild(itemDiv);
    });
  }

  // 4. Manejar clic en una opción
  function handleOptionClick(questionIndex, letter, button) {
    console.log(`handleOptionClick => questionIndex=${questionIndex}, letter=${letter}`);
    console.log("questions[questionIndex] =>", questions[questionIndex]);

    if (questionIndex !== active) {
      console.log(" -> Click en pregunta no activa, ignorado.");
      return;
    }

    // Si el botón ya tiene la clase 'siguiente', avanzamos
    if (button.classList.contains('siguiente')) {
      console.log(" -> Botón ya tiene 'siguiente', avanzando...");
      nextButtonHandler({ currentTarget: button });
      return;
    }

    // Nueva condición: Si el botón ya está seleccionado pero no tiene "siguiente",
    // lo transformamos en botón de avanzar y llamamos a nextButtonHandler.
    if (button.classList.contains('selected') && !button.classList.contains('siguiente')) {
      console.log(" -> Opción ya seleccionada, transformándola y avanzando...");
      button.setAttribute('data-original-text', button.textContent);
      if (questionIndex === questions.length - 1) {
        button.textContent = "Siguiente categoría";
      } else {
        button.textContent = "Siguiente pregunta";
      }
      button.classList.add('siguiente');
      button.style.cssText = 'background: rgb(141, 255, 118); color: #222;';
      nextButtonHandler({ currentTarget: button });
      return;
    }

    // Procesar selección si aún no estaba marcada
    const answerObj = {
      question_id: parseInt(questions[questionIndex].id, 10),
      selected_option: letter,
      score: letterScores[letter] || 0
    };

    // Agregar o actualizar la respuesta en selectedAnswers
    const existingIndex = selectedAnswers.findIndex(ans => ans.question_id === answerObj.question_id);
    if (existingIndex !== -1) {
      selectedAnswers[existingIndex] = answerObj;
    } else {
      selectedAnswers.push(answerObj);
    }

    // Quitar 'selected' y 'siguiente' de las demás opciones de la misma pregunta
    const siblingButtons = button.parentElement.querySelectorAll('button');
    siblingButtons.forEach(b => {
      b.classList.remove('selected', 'siguiente');
      b.disabled = false;
      if (b.getAttribute('data-original-text')) {
        b.textContent = b.getAttribute('data-original-text');
      }
      b.style.cssText = '';
    });

    // Marcar la opción elegida
    button.classList.add('selected');

    // Transformar en "Siguiente pregunta" o "Siguiente categoría"
    setTimeout(() => {
      button.setAttribute('data-original-text', button.textContent);
      if (questionIndex === questions.length - 1) {
        button.textContent = "Siguiente categoría";
      } else {
        button.textContent = "Siguiente pregunta";
      }
      button.classList.add('siguiente');
      button.style.cssText = 'background: rgb(141, 255, 118); color: #222;';
      button.addEventListener('click', nextButtonHandler);
    }, 50);
  }

  // 5. Listener para el botón "siguiente"
  function nextButtonHandler(e) {
    e.currentTarget.disabled = true;
    e.currentTarget.removeEventListener('click', nextButtonHandler);
    goNextQuestion(e.currentTarget);
  }

  // 6. Función para avanzar a la siguiente pregunta
  function goNextQuestion(btn) {
    console.log(`goNextQuestion() called. active=${active}, questions.length=${questions.length}`);
    if (active < questions.length - 1) {
      active++;
      loadShow();
    } else {
      // Última pregunta => submit
      if (isSubmitting) return;
      isSubmitting = true;

      submitAnswers()
        .then(serverData => {
          isSubmitting = false;
          if (!serverData.hasNextCategory) {
            const scoreDiv = document.getElementById("scoreContainer");
            if (scoreDiv) {
              scoreDiv.textContent = `Cuestionario completado.`;
              scoreDiv.style.display = "block";
            }
            if (btn) {
              btn.textContent = "Volver al inicio";
              btn.disabled = false;
              btn.addEventListener('click', () => {
                window.location.href = 'modelo_negocio.html';
              });
            }
          } else {
            categoryId++;
            window.location.href = `modelo_negocio_questions.html?category_id=${categoryId}`;
          }
        })
        .catch(err => {
          isSubmitting = false;
          console.error("Error al enviar respuestas:", err);
          alert("Ocurrió un error al guardar las respuestas: " + err.message);
        });
    }
  }

  // 7. Posicionar el carrusel de preguntas
  function loadShow() {
    if (isAnimating) return;
    isAnimating = true;

    const items = document.querySelectorAll('.item');
    items.forEach((item, index) => {
      item.style.transition = 'all 0.75s';
      item.classList.remove('active');
      if (index === active) {
        item.classList.add('active');
      }
    });

    items[active].style.transform = 'translate(-50%, -50%) scale(1.5)';
    items[active].style.opacity = '1';
    items[active].style.filter = 'none';
    items[active].style.zIndex = '1';

    let stt = 0;
    for (let i = active + 1; i < items.length; i++) {
      stt++;
      items[i].style.transform = `translate(calc(-50% + ${120 * stt}px), -50%) scale(${1 - 0.1 * stt})`;
      items[i].style.opacity = (stt > 2) ? '0' : '0.5';
      items[i].style.filter = 'blur(10px)';
      items[i].style.zIndex = '-1';
    }

    stt = 0;
    for (let i = active - 1; i >= 0; i--) {
      stt++;
      items[i].style.transform = `translate(calc(-50% - ${120 * stt}px), -50%) scale(${1 - 0.1 * stt})`;
      items[i].style.opacity = (stt > 2) ? '0' : '0.5';
      items[i].style.filter = 'blur(10px)';
      items[i].style.zIndex = '-1';
    }

    setTimeout(() => {
      isAnimating = false;
    }, 500);

    // Restablecer el estado de las opciones de la pregunta actual
    const currentOptions = items[active].querySelectorAll('.options button');
    currentOptions.forEach((btn, index) => {
      if (selectedAnswers[active] === index) {
        // Si la pregunta ya fue respondida, añadimos también 'siguiente'
        btn.classList.add('selected', 'siguiente');
        btn.textContent = btn.getAttribute('data-original-text') || btn.textContent;
        // Agregar el listener de avance (en caso de que no esté agregado)
        btn.removeEventListener('click', nextButtonHandler);
        btn.addEventListener('click', nextButtonHandler);
      } else {
        btn.classList.remove('selected', 'siguiente');
        btn.textContent = btn.getAttribute('data-original-text') || btn.textContent;
      }
    });
  }

  // 8. Enviar respuestas
  function submitAnswers() {
    const validAnswers = selectedAnswers.filter(ans => ans && ans.question_id && ans.selected_option);
    const payload = {
      category_id: categoryId,
      answers: validAnswers
    };

    console.log("selectedAnswers =>", selectedAnswers);
    console.log("validAnswers =>", validAnswers);
    console.log("Payload:", JSON.stringify(payload));

    return fetch('../../submit_answers.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
      .then(res => {
        if (!res.ok) {
          return res.text().then(text => { throw new Error(`HTTP ${res.status}: ${text}`); });
        }
        return res.json();
      })
      .then(data => {
        if (!data.success) {
          throw new Error(data.message || 'Error desconocido al guardar respuestas');
        }
        return data;
      });
  }

  // 9. Configurar el botón "prev" para retroceder en la pregunta
  if (prevButton) {
    prevButton.addEventListener('click', function () {
      if (!isAnimating && active > 0) {
        active--;
        loadShow();
      }
    });
  }
});