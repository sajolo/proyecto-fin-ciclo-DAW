using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Biblioteca.Models;
using Biblioteca.Filters;

namespace Biblioteca.Controllers
{
    [AuthorizeUser]
    public class LibroController : Controller
    {
       private readonly BibliotecaContext _context;
       
       public LibroController(BibliotecaContext context)
        {
            _context = context;
        }

        //Acciones:

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ListaLibros(string searchString)
        {
            var librosQuery = from l in _context.Libros select l;

            // Aplico el filtro de búsqueda si searchString no está vacío
            if (!string.IsNullOrEmpty(searchString))
            {
                librosQuery = librosQuery.Where(l => l.Titulo.Contains(searchString) || l.Autor.Contains(searchString));
            }

            // Ejecuto la consulta y envío los resultados a la vista
            var librosFiltrados = librosQuery.ToList();
            return View("ListaLibros", librosFiltrados);
        }


        public IActionResult DetallesLibro(int Id)
        {
            var manager = new BibliotecaManager(_context);
            var libroElegido = manager.GetLibro(Id);
            return View("DetallesLibro", libroElegido);
        }

        //CRUD:

        public IActionResult CrearLibro()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CrearLibro([Bind("Id,Titulo,Autor,AnhoPublicacion,Prestado")] Libro libro)
        {
            if (ModelState.IsValid)
            {
                var userId = Convert.ToInt32(HttpContext.Session.GetString("UserId"));
                var manager = new BibliotecaManager(_context);
                manager.CrearLibro(libro, userId);
                return RedirectToAction(nameof(ListaLibros));
            }
            return View(libro);
        }

        public IActionResult EditarLibro(int Id)
        {
            var manager = new BibliotecaManager(_context);
            var libro = manager.GetLibro(Id);
            if(libro == null)
            {
                return NotFound();
            }
            return View(libro);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult EditarLibro(int id, [Bind("Id,Titulo,Autor,AnhoPublicacion,Prestado")] Libro libro)
        {
            if (id != libro.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var userId = Convert.ToInt32(HttpContext.Session.GetString("UserId"));
                var manager = new BibliotecaManager(_context);
                manager.EditarLibro(libro, userId);
                return RedirectToAction(nameof(ListaLibros));
            }
            return View(libro);
        }

        public IActionResult EliminarLibro(int id)
        {
            var manager = new BibliotecaManager(_context);
            var libro = manager.GetLibro(id);
            if(libro == null)
            {
                return NotFound();
            }
            return View(libro);
        }

        [HttpPost, ActionName("EliminarLibro")]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarLibroConfirm(int id)
        {
            var manager = new BibliotecaManager(_context);
            var userId = Convert.ToInt32(HttpContext.Session.GetString("UserId"));
            manager.EliminarLibro(id, userId);
            return RedirectToAction(nameof(ListaLibros));
        }

        public IActionResult PedirPrestado(int id)
        {
            var userId = HttpContext.Session.GetString("UserId");
            if (string.IsNullOrEmpty(userId))
            {
                return RedirectToAction("Login", "Home");
            }

            // Intentar prestar el libro utilizando el manager
            var manager = new BibliotecaManager(_context);
            bool prestamoExitoso = manager.PrestarLibro(id, Convert.ToInt32(userId));

            if (!prestamoExitoso)
            {
                TempData["ErrorMensaje"] = "El libro ya está prestado o no está disponible.";
            }
            else
            {
                TempData["SuccessMensaje"] = "El libro ha sido prestado con éxito.";
            }

            return View("DetallesLibro", manager.GetLibro(id));
        }




    }
}
