document.addEventListener("DOMContentLoaded", function() {
  // Verificamos si existe 'rut' en localStorage
  if (!localStorage.getItem("rut")) {
    window.location.href = "../index.html";
  }
});