document.addEventListener("DOMContentLoaded", function() {
  const container = document.getElementById("categoriesContainer");
  if (!container) {
    console.error("No se encontró el contenedor #categoriesContainer");
    return;
  }

  // Cargar categorías
  fetch('../../fetch_categories.php?action=list')
    .then(res => res.json())
    .then(data => {
      if (data.status === 'success') {
        renderCategories(data.categories);
      } else {
        console.error("Error al obtener categorías:", data.message);
      }
    })


  let currentPercentage = 0;

  function renderCategories(categories) {
    container.innerHTML = "";

    // Renderizar cada categoría como link
    categories.forEach((cat, index) => {
      const link = document.createElement('a');
      link.classList.add('quiz-item');
      link.href = `modelo_negocio_questions.html?category_id=${cat.id}`;

      const contentDiv = document.createElement('div');
      contentDiv.classList.add('quiz-content');

      const h3 = document.createElement('h3');
      h3.textContent = cat.name;
      contentDiv.appendChild(h3);

      const img = document.createElement('img');
      img.src = (cat.image_url && cat.image_url.trim() !== "") ? cat.image_url : "img/img_ic/default.svg";
      img.alt = `Sección ${index + 1}`;
      contentDiv.appendChild(img);

      link.appendChild(contentDiv);

      if (cat.completed === true) {
        // Efecto de apagado
        link.classList.add('completed-section');
      }

      container.appendChild(link);
    });

    // Crear la tarjeta final (botón para enviar respuestas)
    const finalDiv = document.createElement('div');
    finalDiv.classList.add('quiz-item', 'submit-button');

    const finalContent = document.createElement('div');
    finalContent.classList.add('quiz-submit');

    const finalH3 = document.createElement('h3');
    finalH3.textContent = "Le enviaremos su puntuación al correo.";

    const finalImg = document.createElement('img');
    finalImg.src = "../img/enviar.svg";
    finalImg.alt = "Enviar respuestas";

    const finalBtn = document.createElement('button');
    finalBtn.type = "button";
    finalBtn.classList.add('send-answers-btn');
    finalBtn.textContent = "Enviar respuesta";
    // Ya NO lo deshabilitamos aquí.

    finalContent.appendChild(finalH3);
    finalContent.appendChild(finalImg);
    finalContent.appendChild(finalBtn);
    finalDiv.appendChild(finalContent);
    container.appendChild(finalDiv);

    // Llamar a updateProgress() ahora y cada 5s
    updateProgress();
    setInterval(updateProgress, 5000);

    // Manejador de click del botón final
    finalBtn.addEventListener('click', function() {
      // 1) Verificamos el progreso en tiempo real
      fetch('../../progress.php')
        .then(r => r.json())
        .then(data => {
          if (!data.success) {
            alert("Error al verificar el progreso: " + data.message);
            return;
          }
          const pct = Math.round(data.percentage);
          // 2) Si < 100, mostramos el mensaje
          if (pct < 100) {
            alert("Debes responder todas las preguntas para recibir el correo.");
            return;
          }
          // 3) Si es 100, redirigir directamente a PHPMailer.php
          //    PHPMailer.php se encargará de enviar el correo y redirigir a respuestafinal.html
          window.location.href = "../../PHPMailer.php";
        })
        .catch(err => {
          console.error("Error al verificar el progreso:", err);
          alert("Ocurrió un error al verificar tu progreso. Intenta de nuevo.");
        });
    });
  }

  // Función para actualizar la barra de progreso
  function updateProgress() {
    fetch('../../progress.php')
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          const fill = document.querySelector('.progress-fill');
          const percentText = document.querySelector('.progress-percent');
          const pct = Math.round(data.percentage);
          currentPercentage = pct;

          if (fill) fill.style.width = pct + "%";
          if (percentText) percentText.textContent = pct + "%";

          // Ya NO deshabilitamos el botón.
          // Confiamos en el click handler para mostrar el mensaje si < 100.
        } else {
          console.error("Progress error:", data.message);
        }
      })
      .catch(err => console.error("Error en updateProgress:", err));
  }
});
