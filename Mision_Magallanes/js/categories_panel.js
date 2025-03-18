document.addEventListener("DOMContentLoaded", function(){
  const categoriesTableBody = document.querySelector("#categoriesTable tbody");
  const categoryFormContainer = document.getElementById("categoryFormContainer");
  const formTitle = document.getElementById("formTitle");
  const categoryIdInput = document.getElementById("categoryId");
  const categoryNameInput = document.getElementById("categoryName");
  const btnNewCategory = document.getElementById("btnNewCategory");
  const btnSaveCategory = document.getElementById("btnSaveCategory");
  const btnCancel = document.getElementById("btnCancel");

  // 1. Al iniciar, listar categorías
  listCategories();

  // 2. Botón "Nueva Categoría"
  btnNewCategory.addEventListener("click", () => {
    formTitle.textContent = "Nueva Categoría";
    categoryIdInput.value = "";
    categoryNameInput.value = "";
    categoryFormContainer.style.display = "block";
  });

  // 3. Botón "Guardar" (agregar o editar)
  btnSaveCategory.addEventListener("click", () => {
    const id = categoryIdInput.value;
    const name = categoryNameInput.value.trim();
    if(!name){
      alert("El nombre no puede estar vacío.");
      return;
    }

    if(id){
      // Editar
      editCategory(id, name);
    } else {
      // Agregar
      addCategory(name);
    }
  });

  // 4. Botón "Cancelar"
  btnCancel.addEventListener("click", () => {
    categoryFormContainer.style.display = "none";
  });

  // --- Funciones CRUD ---

  function listCategories(){
    fetch('../../fetch_categories.php?action=list')
      .then(res => res.json())
      .then(data => {
        if(data.status === 'success'){
          renderCategories(data.categories);
        } else {
          console.error(data.message);
        }
      })
      .catch(err => console.error(err));
  }

  function addCategory(name){
    const formData = new FormData();
    formData.append('name', name);

    fetch('fetch_categories.php?action=add', {
      method: 'POST',
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      if(data.status === 'success'){
        categoryFormContainer.style.display = "none";
        listCategories(); // refrescar lista
      } else {
        alert("Error al agregar: " + data.message);
      }
    })
    .catch(err => console.error(err));
  }

  function editCategory(id, name){
    const formData = new FormData();
    formData.append('id', id);
    formData.append('name', name);

    fetch('fetch_categories.php?action=edit', {
      method: 'POST',
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      if(data.status === 'success'){
        categoryFormContainer.style.display = "none";
        listCategories();
      } else {
        alert("Error al editar: " + data.message);
      }
    })
    .catch(err => console.error(err));
  }

  function deleteCategory(id){
    if(!confirm("¿Eliminar esta categoría?")) return;

    const formData = new FormData();
    formData.append('id', id);

    fetch('fetch_categories.php?action=delete', {
      method: 'POST',
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      if(data.status === 'success'){
        listCategories();
      } else {
        alert("Error al eliminar: " + data.message);
      }
    })
    .catch(err => console.error(err));
  }

  // --- Renderizar la tabla con imagen de fondo para cada categoría ---
  function renderCategories(categories){
    categoriesTableBody.innerHTML = ""; // limpiar el tbody

    categories.forEach(cat => {
      const tr = document.createElement('tr');

      // Nueva celda para la imagen
      const tdImage = document.createElement('td');
      if (cat.image_url && cat.image_url.trim() !== "") {
        const divImage = document.createElement('div');
        // Ajusta el tamaño de la imagen según necesites:
        divImage.style.width = "100px";
        divImage.style.height = "100px";
        divImage.style.backgroundImage = `url('${cat.image_url}')`;
        divImage.style.backgroundSize = "cover";
        divImage.style.backgroundPosition = "center";
        divImage.style.backgroundRepeat = "no-repeat";
        tdImage.appendChild(divImage);
      } else {
        tdImage.textContent = "Sin imagen";
      }

      // Celda para ID
      const tdId = document.createElement('td');
      tdId.textContent = cat.id;

      // Celda para nombre
      const tdName = document.createElement('td');
      tdName.textContent = cat.name;

      // Celda para acciones (editar, eliminar)
      const tdActions = document.createElement('td');
      const btnEdit = document.createElement('button');
      btnEdit.textContent = "Editar";
      btnEdit.addEventListener('click', () => {
        formTitle.textContent = "Editar Categoría";
        categoryIdInput.value = cat.id;
        categoryNameInput.value = cat.name;
        categoryFormContainer.style.display = "block";
      });

      const btnDel = document.createElement('button');
      btnDel.textContent = "Eliminar";
      btnDel.style.marginLeft = "8px";
      btnDel.addEventListener('click', () => {
        deleteCategory(cat.id);
      });

      tdActions.appendChild(btnEdit);
      tdActions.appendChild(btnDel);

      tr.appendChild(tdImage);
      tr.appendChild(tdId);
      tr.appendChild(tdName);
      tr.appendChild(tdActions);

      categoriesTableBody.appendChild(tr);
    });
  }
});
