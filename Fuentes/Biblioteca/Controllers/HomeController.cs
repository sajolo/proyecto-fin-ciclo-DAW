using Biblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging; // Añadido para ILogger
using System.Diagnostics;
using System.Linq; // Añadido para FirstOrDefault

namespace Biblioteca.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly BibliotecaContext _context;

        public HomeController(ILogger<HomeController> logger, BibliotecaContext context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        [HttpPost]
        public IActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Aquí añado la lógica de autenticación
                var user = _context.Usuarios.FirstOrDefault(u => u.Nombre == model.Usuario && u.Password == model.Contraseña);

                if (user != null)
                {
                    // Aquí guardo la información del usuario en la sesión
                    HttpContext.Session.SetString("UserId", user.Id.ToString());
                    HttpContext.Session.SetString("UserName", user.Nombre);
                    HttpContext.Session.SetString("UserRol", user.Rol ? "Administrador" : "Usuario");

                    // Llamada al método para devolver los libros automáticamente antes de redirigir al usuario
                    var manager = new BibliotecaManager(_context);
                    manager.DevolverLibrosAutomaticamente();

                    return RedirectToAction("MiCuenta", "Usuario");
                }
                else
                {
                    ModelState.AddModelError("", "Usuario o contraseña inválidos");
                }
            }

            return View("Index", model); // Si la autenticación falla, devuelve al usuario a la vista de inicio de sesión con un mensaje de error
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}
