document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('loginForm');
    if (!form) {
        console.error("No se encontró el formulario con id 'loginForm'.");
        return;
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const nombreEmpresa = document.getElementById('nombreEmpresa').value.trim();
        const rutEmpresa = document.getElementById('rutEmpresa').value.trim();
        const nombreRepresentante = document.getElementById('nombreRepresentante').value.trim();
        const cargo = document.getElementById('cargo').value.trim();
        const correo = document.getElementById('correo').value.trim();

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
                // Guardar en localStorage
                localStorage.setItem("nombreEmpresa", nombreEmpresa);
                localStorage.setItem("rut", rutEmpresa);
                localStorage.setItem("nombreRepresentante", nombreRepresentante);
                localStorage.setItem("cargo", cargo);
                localStorage.setItem("correo", correo);

                window.location.href = 'Front/html/modelo_negocio.html';
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
