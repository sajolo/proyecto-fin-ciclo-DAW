using Biblioteca.Models;
using Microsoft.AspNetCore.Mvc;
using Biblioteca.Filters;

namespace Biblioteca.Controllers
{

    [AuthorizeUser]
    public class UsuarioController : Controller
    {

        private readonly BibliotecaContext _context;

        public UsuarioController(BibliotecaContext context)
        {
            _context = context;
        }

        //ACTIONS:

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult GestionUsuarios()
        {
            var manager = new BibliotecaManager(_context);
            var usuarios = manager.GetAllUsuarios();
            return View("GestionUsuarios", usuarios);
        }

        //CRUD:

        public IActionResult CrearUsuario()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CrearUsuario([Bind("Id,Nombre,Password,Rol")] Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                var manager = new BibliotecaManager(_context);
                manager.CrearUsuario(usuario);
                return RedirectToAction(nameof(GestionUsuarios));
            }
            return View(usuario);
        }

        public IActionResult EditarUsuario(int Id)
        {
            var manager = new BibliotecaManager(_context);
            var usuario = manager.GetUsuario(Id);
            if (usuario == null)
            {
                return NotFound();
            }
            return View(usuario);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditarUsuario(int id, [Bind("Id,Nombre,Password,Rol")] Usuario usuario)
        {
            if (id != usuario.Id)
            {
                return NotFound();
            }
            if (ModelState.IsValid)
            {
                var manager = new BibliotecaManager(_context);
                manager.EditarUsuario(usuario);
                return RedirectToAction(nameof(GestionUsuarios));
            }
            return View(usuario);
        }

        public IActionResult EliminarUsuario(int id)
        {
            var manager = new BibliotecaManager(_context);
            var usuario = manager.GetUsuario(id);
            if (usuario == null)
            {
                return NotFound();
            }
            return View(usuario);
        }

        [HttpPost, ActionName("EliminarUsuario")]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarUsuarioConfirm(int id)
        {
            var manager = new BibliotecaManager(_context);
            manager.EliminarUsuario(id);
            return RedirectToAction(nameof(GestionUsuarios));
        }

        public IActionResult MiCuenta()
        {
            var userId = HttpContext.Session.GetString("UserId");
            if (!string.IsNullOrEmpty(userId))
            {
                var manager = new BibliotecaManager(_context);
                var usuarioConLogs = manager.GetUsuarioConLogsViewModel(Convert.ToInt32(userId));
                return View(usuarioConLogs);
            }
            return RedirectToAction("Index", "Home");
        }

    }
}
