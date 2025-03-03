// main.js
document.addEventListener("DOMContentLoaded", function() {
  // Leer el categoryId de la URL (si existe)
  const params = new URLSearchParams(window.location.search);
  const categoryId = params.get('category_id') || 0;

  // Referencias a los botones "Anterior" y "Siguiente"
  const prevButton = document.getElementById("prev");
  const nextButton = document.getElementById("next");

  let items = [];         // array de <div class="item">
  let active = 0;         // índice de la pregunta activa
  let isAnimating = false;
  let selectedAnswers = []; // se definirá tras conocer cuántas preguntas hay

  // 1. Llamar a fetch_questions.php con el parámetro category_id
  fetch(`fetch_questions.php?category_id=${categoryId}`)
    .then(response => response.json())
    .then(data => {
      if (data.status === 'success') {
        const questions = data.questions;
        // Inicializa el array de respuestas seleccionadas
        selectedAnswers = new Array(questions.length).fill(null);

        // Construir dinámicamente los .item
        buildSliderItems(questions);

        // Ejecutar loadShow() para posicionar la pregunta activa
        loadShow();

        // Asignar eventos a los botones de opciones
        attachOptionEvents();
      } else {
        console.error('Error al obtener preguntas:', data.message);
      }
    })
    .catch(err => console.error('Fetch error:', err));

  // 2. Construir cada .item y meterlo en "items"
  function buildSliderItems(questions) {
    const sliderContainer = document.getElementById("sliderContainer");
    questions.forEach((q, index) => {
      // Crear el contenedor .item
      const itemDiv = document.createElement('div');
      itemDiv.classList.add('item', 'quiz-card');

      // Título/pregunta
      const pQuestion = document.createElement('p');
      pQuestion.textContent = `${index + 1}.- ${q.question_text}`;
      itemDiv.appendChild(pQuestion);

      // Contenedor de opciones
      const optionsDiv = document.createElement('div');
      optionsDiv.classList.add('options');

      // Crear 4 botones
      const btnA = document.createElement('button');
      btnA.textContent = `A. ${q.option_a}`;

      const btnB = document.createElement('button');
      btnB.textContent = `B. ${q.option_b}`;

      const btnC = document.createElement('button');
      btnC.textContent = `C. ${q.option_c}`;

      const btnD = document.createElement('button');
      btnD.textContent = `D. ${q.option_d}`;

      // Añadirlos al contenedor
      optionsDiv.appendChild(btnA);
      optionsDiv.appendChild(btnB);
      optionsDiv.appendChild(btnC);
      optionsDiv.appendChild(btnD);

      itemDiv.appendChild(optionsDiv);

      // Agregar el item al sliderContainer
      sliderContainer.appendChild(itemDiv);

      // Guardar en array "items"
      items.push(itemDiv);
    });
  }

  // 3. Función loadShow() para posicionar los items (efecto carrusel)
  function loadShow() {
    if (isAnimating) return;
    isAnimating = true;

    // Transición suave
    items.forEach(item => {
      item.style.transition = 'all 0.75s';
    });

    // Elemento activo
    items[active].style.transform = 'translate(-50%, -50%) scale(1.5)';
    items[active].style.opacity = '1';
    items[active].style.filter = 'none';
    items[active].style.zIndex = '1';

    // Elementos siguientes
    let stt = 0;
    for (let i = active + 1; i < items.length; i++) {
      stt++;
      items[i].style.transform = `translate(calc(-50% + ${120 * stt}px), -50%) scale(${1 - 0.1 * stt})`;
      items[i].style.opacity = (stt > 2) ? '0' : '0.5';
      items[i].style.filter = 'blur(10px)';
      items[i].style.zIndex = '-1';
    }

    // Elementos anteriores
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

    // Restablecer estado de botones (si ya había seleccionado algo)
    const currentOptions = items[active].querySelectorAll('.options button');
    currentOptions.forEach((btn, index) => {
      if (selectedAnswers[active] === index) {
        // ya estaba seleccionada
        btn.classList.add('selected');
        // Restaurar texto original si se había convertido
        btn.textContent = btn.getAttribute('data-original-text') || btn.textContent;
      } else {
        btn.classList.remove('selected', 'siguiente');
        btn.textContent = btn.getAttribute('data-original-text') || btn.textContent;
      }
    });
  }

  // 4. Botones "Anterior" y "Siguiente"
  nextButton.addEventListener('click', function() {
    if (!isAnimating && active < items.length - 1) {
      active++;
      loadShow();
    }
  });

  prevButton.addEventListener('click', function() {
    if (!isAnimating && active > 0) {
      active--;
      loadShow();
    }
  });

  // 5. Adjuntar eventos a las opciones (seleccionar respuesta y avanzar)
  function attachOptionEvents() {
    const allOptionButtons = document.querySelectorAll('.options button');
    allOptionButtons.forEach((button) => {
      button.addEventListener('click', function() {
        // Encontrar qué .item corresponde
        const parentItem = this.closest('.item');
        const questionIndex = items.indexOf(parentItem);

        // Índice local (0..3) de la opción
        const optionButtons = parentItem.querySelectorAll('.options button');
        const localIndex = Array.from(optionButtons).indexOf(this);

        // Si ya estaba seleccionada la misma, avanzar
        if (selectedAnswers[questionIndex] === localIndex) {
          if (!isAnimating && active < items.length - 1) {
            active++;
            loadShow();
          }
          return;
        }

        // Quitar "selected" y "siguiente" de las demás
        optionButtons.forEach(btn => {
          btn.classList.remove('selected', 'siguiente');
          if (btn.getAttribute('data-original-text')) {
            btn.textContent = btn.getAttribute('data-original-text');
          }
          btn.style.cssText = '';
        });

        // Marcar esta como seleccionada
        this.classList.add('selected');
        selectedAnswers[questionIndex] = localIndex;

        // Convertir en "Siguiente pregunta"
        setTimeout(() => {
          this.setAttribute('data-original-text', this.textContent);
          this.textContent = 'Siguiente pregunta';
          this.classList.add('siguiente');
          this.style.cssText = 'background: rgb(141, 255, 118); color: #222;';
        }, 50);
      });
    });
  }
});
