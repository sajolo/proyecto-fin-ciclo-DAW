document.addEventListener('DOMContentLoaded', function () {
    var darkModeStyleSheet = document.getElementById('dark-mode-style');
    var themeToggle = document.getElementById('theme-toggle');

    themeToggle.addEventListener('click', function () {
        var isDarkModeEnabled = !darkModeStyleSheet.disabled;
        darkModeStyleSheet.disabled = isDarkModeEnabled;
        themeToggle.textContent = isDarkModeEnabled ? 'Modo Claro' : 'Modo Oscuro';

        // Guardar la preferencia del tema en localStorage
        localStorage.setItem('darkMode', !isDarkModeEnabled);
    });

    // Cargar la preferencia del tema
    var darkMode = localStorage.getItem('darkMode');
    darkModeStyleSheet.disabled = darkMode !== "true";
    themeToggle.textContent = darkMode === "true" ? 'Modo Oscuro' : 'Modo Claro';
});
