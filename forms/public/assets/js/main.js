// public/assets/js/main.js
document.addEventListener("DOMContentLoaded", function(){
    // Validación para el formulario de registro
    const registerForm = document.getElementById('registerForm');
    if(registerForm){
        registerForm.addEventListener('submit', function(e){
            const rut    = document.getElementById('rut').value.trim();
            const nombre = document.getElementById('nombre').value.trim();
            const correo = document.getElementById('correo').value.trim();
            if(rut === "" || nombre === "" || correo === ""){
                alert("Por favor, complete todos los campos.");
                e.preventDefault();
            }
        });
    }
    
    // Validación para el formulario de preguntas (si se requiere)
    const questionForm = document.getElementById('questionForm');
    if(questionForm){
        questionForm.addEventListener('submit', function(e){
            // Aquí se pueden agregar validaciones adicionales si es necesario.
        });
    }
});
