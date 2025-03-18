// js/questions_panel.js
document.addEventListener("DOMContentLoaded", function(){
    const questionsTableBody = document.querySelector("#questionsTable tbody");
    const questionFormContainer = document.getElementById("questionFormContainer");
    const formTitle = document.getElementById("formTitle");
  
    const questionIdInput = document.getElementById("questionId");
    const questionTextInput = document.getElementById("questionText");
    const optionAInput = document.getElementById("optionA");
    const optionBInput = document.getElementById("optionB");
    const optionCInput = document.getElementById("optionC");
    const optionDInput = document.getElementById("optionD");
    const categorySelect = document.getElementById("categorySelect");
  
    const btnNewQuestion = document.getElementById("btnNewQuestion");
    const btnSaveQuestion = document.getElementById("btnSaveQuestion");
    const btnCancel = document.getElementById("btnCancel");
  
    // Al iniciar, listar preguntas y categorías
    listQuestions();
    loadCategories();
  
    // Botón "Nueva Pregunta"
    btnNewQuestion.addEventListener("click", () => {
      formTitle.textContent = "Nueva Pregunta";
      questionIdInput.value = "";
      questionTextInput.value = "";
      optionAInput.value = "";
      optionBInput.value = "";
      optionCInput.value = "";
      optionDInput.value = "";
      categorySelect.value = ""; // Limpia el select
      questionFormContainer.style.display = "block";
    });
  
    // Botón "Guardar"
    btnSaveQuestion.addEventListener("click", () => {
      const id = questionIdInput.value;
      const question_text = questionTextInput.value.trim();
      const option_a = optionAInput.value.trim();
      const option_b = optionBInput.value.trim();
      const option_c = optionCInput.value.trim();
      const option_d = optionDInput.value.trim();
      const category_id = categorySelect.value;
  
      if(!question_text || !option_a || !option_b || !option_c || !option_d){
        alert("Faltan campos de la pregunta");
        return;
      }
  
      if(!category_id){
        alert("Seleccione una categoría");
        return;
      }
  
      if(id){
        // Editar
        editQuestion(id, question_text, option_a, option_b, option_c, option_d, category_id);
      } else {
        // Agregar
        addQuestion(question_text, option_a, option_b, option_c, option_d, category_id);
      }
    });
  
    // Botón "Cancelar"
    btnCancel.addEventListener("click", () => {
      questionFormContainer.style.display = "none";
    });
  
    // --- Funciones CRUD ---
    function listQuestions(){
      fetch('fetch_questions_crud.php?action=list')
        .then(res => res.json())
        .then(data => {
          if(data.status === 'success'){
            renderQuestions(data.questions);
          } else {
            console.error(data.message);
          }
        })
        .catch(err => console.error(err));
    }
  
    function addQuestion(question_text, option_a, option_b, option_c, option_d, category_id){
      const formData = new FormData();
      formData.append('question_text', question_text);
      formData.append('option_a', option_a);
      formData.append('option_b', option_b);
      formData.append('option_c', option_c);
      formData.append('option_d', option_d);
      formData.append('category_id', category_id);
  
      fetch('fetch_questions_crud.php?action=add', {
        method: 'POST',
        body: formData
      })
      .then(res => res.json())
      .then(data => {
        if(data.status === 'success'){
          questionFormContainer.style.display = "none";
          listQuestions();
        } else {
          alert("Error al agregar: " + data.message);
        }
      })
      .catch(err => console.error(err));
    }
  
    function editQuestion(id, question_text, option_a, option_b, option_c, option_d, category_id){
      const formData = new FormData();
      formData.append('id', id);
      formData.append('question_text', question_text);
      formData.append('option_a', option_a);
      formData.append('option_b', option_b);
      formData.append('option_c', option_c);
      formData.append('option_d', option_d);
      formData.append('category_id', category_id);
  
      fetch('fetch_questions_crud.php?action=edit', {
        method: 'POST',
        body: formData
      })
      .then(res => res.json())
      .then(data => {
        if(data.status === 'success'){
          questionFormContainer.style.display = "none";
          listQuestions();
        } else {
          alert("Error al editar: " + data.message);
        }
      })
      .catch(err => console.error(err));
    }
  
    function deleteQuestion(id){
      if(!confirm("¿Eliminar esta pregunta?")) return;
  
      const formData = new FormData();
      formData.append('id', id);
  
      fetch('fetch_questions_crud.php?action=delete', {
        method: 'POST',
        body: formData
      })
      .then(res => res.json())
      .then(data => {
        if(data.status === 'success'){
          listQuestions();
        } else {
          alert("Error al eliminar: " + data.message);
        }
      })
      .catch(err => console.error(err));
    }
  
    // --- Renderizar tabla ---
    function renderQuestions(questions){
      questionsTableBody.innerHTML = "";
      questions.forEach(q => {
        const tr = document.createElement('tr');
  
        const tdId = document.createElement('td');
        tdId.textContent = q.id;
  
        const tdQText = document.createElement('td');
        tdQText.textContent = q.question_text;
  
        const tdA = document.createElement('td');
        tdA.textContent = q.option_a;
  
        const tdB = document.createElement('td');
        tdB.textContent = q.option_b;
  
        const tdC = document.createElement('td');
        tdC.textContent = q.option_c;
  
        const tdD = document.createElement('td');
        tdD.textContent = q.option_d;
  
        const tdCat = document.createElement('td');
        tdCat.textContent = q.category_name ? q.category_name : "(Sin categoría)";
  
        const tdActions = document.createElement('td');
        // Botón Editar
        const btnEdit = document.createElement('button');
        btnEdit.textContent = "Editar";
        btnEdit.addEventListener('click', () => {
          // Cargar datos en el form
          formTitle.textContent = "Editar Pregunta";
          questionIdInput.value = q.id;
          questionTextInput.value = q.question_text;
          optionAInput.value = q.option_a;
          optionBInput.value = q.option_b;
          optionCInput.value = q.option_c;
          optionDInput.value = q.option_d;
          categorySelect.value = q.category_id || ""; 
          questionFormContainer.style.display = "block";
        });
  
        // Botón Eliminar
        const btnDel = document.createElement('button');
        btnDel.textContent = "Eliminar";
        btnDel.style.marginLeft = "8px";
        btnDel.addEventListener('click', () => {
          deleteQuestion(q.id);
        });
  
        tdActions.appendChild(btnEdit);
        tdActions.appendChild(btnDel);
  
        tr.appendChild(tdId);
        tr.appendChild(tdQText);
        tr.appendChild(tdA);
        tr.appendChild(tdB);
        tr.appendChild(tdC);
        tr.appendChild(tdD);
        tr.appendChild(tdCat);
        tr.appendChild(tdActions);
  
        questionsTableBody.appendChild(tr);
      });
    }
  
    // --- Cargar categorías para el <select> ---
    function loadCategories(){
      fetch('fetch_categories.php?action=list')
        .then(res => res.json())
        .then(data => {
          if(data.status === 'success'){
            const cats = data.categories;
            categorySelect.innerHTML = '<option value="">-- Seleccione --</option>';
            cats.forEach(cat => {
              const opt = document.createElement('option');
              opt.value = cat.id;
              opt.textContent = cat.name;
              categorySelect.appendChild(opt);
            });
          } else {
            console.error("Error al cargar categorías:", data.message);
          }
        })
        .catch(err => console.error(err));
    }
  });
  