document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('loginForm');

  form.addEventListener('submit', function(e) {
      e.preventDefault();

      const nombreEmpresa = document.getElementById('nombreEmpresa').value.trim();
      const rutEmpresa = document.getElementById('rutEmpresa').value.trim();
      const nombreRepresentante = document.getElementById('nombreRepresentante').value.trim();
      const cargoRepresentante = document.getElementById('cargoRepresentante').value.trim();
      const correo = document.getElementById('correo').value.trim();

      // Enviar datos a user_auth.php?action=login
      fetch('user_auth.php?action=login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: new URLSearchParams({
              nombreEmpresa: nombreEmpresa,
              rutEmpresa: rutEmpresa,
              nombreRepresentante: nombreRepresentante,
              cargo: cargo,
              correo: correo
          })
      })
      .then(res => res.json())
      .then(data => {
          if (data.status === 'success') {
              window.location.href = 'modelo_negocio.html';
          } else {
              alert(data.message);
          }
      })
      .catch(err => {
          console.error('Error al autenticar:', err);
          alert('Ocurrió un error. Revisa la consola.');
      });
  });
});
