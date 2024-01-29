using Microsoft.EntityFrameworkCore;

namespace Biblioteca.Models
{
    public class BibliotecaManager
    {

        private readonly BibliotecaContext _data;
        public BibliotecaManager(BibliotecaContext data)
        {
            _data = data;
        }

        //Implemento métodos:

        //LIBROS
        public IEnumerable<Libro> GetAllLibros()
        {
            var libros = from Libros in _data.Libros select Libros;
            return libros;
        }

        public Libro GetLibro(int Id)
        {
            return _data.Libros.FirstOrDefault(libro => libro.Id == Id);
        }

        public IEnumerable<Libro> GetLibroByAnho(int AnhoPublicacion)
        {
            var libros = from Libros in _data.Libros where Libros.AnhoPublicacion == AnhoPublicacion select Libros;
            return libros;
        }

        //CRUD de Libros:
        public Libro CrearLibro(Libro libro, int usuarioId)
        {
            _data.Libros.Add(libro);
            _data.SaveChanges();

            // Crear log de la acción
            CrearLog(new Log
            {
                UsuarioId = usuarioId,
                TipoAccion = TipoAccion.Crear,
                Descripcion = $"Creación del libro '{libro.Titulo}'",
                FechaAccion = DateTime.Now
            });

            return libro;
        }

        public Libro EditarLibro(Libro libro, int usuarioId)
        {
            _data.Libros.Update(libro);
            _data.SaveChanges();

            // Crear log de la acción
            CrearLog(new Log
            {
                UsuarioId = usuarioId,
                TipoAccion = TipoAccion.Modificar,
                Descripcion = $"Modificación del libro '{libro.Titulo}'",
                FechaAccion = DateTime.Now
            });

            return libro;
        }

        public void EliminarLibro(int Id, int usuarioId)
        {
            var libro = GetLibro(Id);
            if (libro != null)
            {
                _data.Libros.Remove(libro);
                _data.SaveChanges();

                // Crear log de la acción
                CrearLog(new Log
                {
                    UsuarioId = usuarioId,
                    TipoAccion = TipoAccion.Eliminar,
                    Descripcion = $"Eliminación del libro '{libro.Titulo}'",
                    FechaAccion = DateTime.Now
                });
            }
        }

        //Agrego un nuevo Log al contexto y guardo los cambios en la base de datos:
        private void CrearLog(Log log)
        {
            _data.Logs.Add(log);
            _data.SaveChanges();
        }

        //LIBROS PRESTADOS

        public IEnumerable<LibroPrestado> GetAllLibrosPrestados()
        {
            var librosPrestados = from LibrosPrestados in _data.LibrosPrestados select LibrosPrestados;
            return librosPrestados;
        }

        public LibroPrestado GetLibroPrestado(int Id)
        {
            return _data.LibrosPrestados.FirstOrDefault(libroPrestado => libroPrestado.Id == Id);
        }

        // Método que convierte un libro disponible en libro prestado y registra la acción:
        public bool PrestarLibro(int libroId, int usuarioId)
        {
            // Buscar el libro en la base de datos
            var libro = _data.Libros.FirstOrDefault(l => l.Id == libroId);

            // Comprobar si el libro existe y si está disponible
            if (libro == null || libro.Prestado)
            {
                return false; // El libro no existe o ya está prestado
            }

            // Cambiar el estado del libro a "Prestado"
            libro.Prestado = true;

            // Crear una nueva entrada en la tabla LibrosPrestados
            var nuevoPrestamo = new LibroPrestado
            {
                LibroId = libroId,
                UsuarioId = usuarioId,
                FechaPrestamo = DateTime.Now // Establece la fecha actual como fecha de préstamo
            };

            _data.LibrosPrestados.Add(nuevoPrestamo);

            // Crear un nuevo log para el préstamo del libro
            var log = new Log
            {
                UsuarioId = usuarioId,
                TipoAccion = TipoAccion.PedirPrestado,
                Descripcion = $"El libro '{libro.Titulo}' ha sido prestado.",
                FechaAccion = DateTime.Now
            };

            _data.Logs.Add(log);

            // Guardar los cambios en la base de datos
            _data.SaveChanges();

            return true; // El libro se ha prestado con éxito
        }

        //Método que devuelve los libros automáticamente cuando pasa una semana desde su préstamo:
        public void DevolverLibrosAutomaticamente()
        {
            var librosPrestados = _data.LibrosPrestados
                .Include(lp => lp.Libro)
                .Where(lp => lp.FechaPrestamo.AddDays(7) <= DateTime.Now)
                .ToList();

            foreach (var prestado in librosPrestados)
            {
                prestado.Libro.Prestado = false; // Marca el libro como no prestado
                _data.LibrosPrestados.Remove(prestado); // Elimina el registro de libro prestado
            }

            _data.SaveChanges(); // Guarda los cambios en la base de datos
        }


        //USUARIOS

        public IEnumerable<Usuario> GetAllUsuarios()
        {
            var usuarios = from Usuarios in _data.Usuarios select Usuarios;
            return usuarios;
        }

        public Usuario GetUsuario(int id)
        {
            return _data.Usuarios.FirstOrDefault(usuario => usuario.Id == id);
        }

        //CRUD de usuarios:
        public Usuario CrearUsuario(Usuario usuario)
        {
            _data.Usuarios.Add(usuario);
            _data.SaveChanges();
            return usuario;
        }

        public Usuario EditarUsuario(Usuario usuario)
        {
            _data.Usuarios.Update(usuario);
            _data.SaveChanges();
            return usuario;
        }

        public void EliminarUsuario(int id)
        {
            var usuario = GetUsuario(id);
            if (usuario != null)
            {
                _data.Usuarios.Remove(usuario);
                _data.SaveChanges();
            }
        }

        //LOGS

        public IEnumerable<Log> GetAllLogs()
        {
            var logs = from Logs in _data.Logs
                             select Logs;
            return logs;
        }

        public Log GetLog(int Id)
        {
            return _data.Logs.FirstOrDefault(log => log.Id == Id);
        }

        public IEnumerable<Log> GetLogByTipoAccion(TipoAccion accion)
        {
            var logs = from Logs in _data.Logs
                         where Logs.TipoAccion == accion
                         select Logs;
            return logs;
        }

        public UsuarioConLogsViewModel GetUsuarioConLogsViewModel(int usuarioId)
        {
            var usuario = _data.Usuarios.FirstOrDefault(u => u.Id == usuarioId);
            var logsRecientes = _data.Logs.Where(l => l.UsuarioId == usuarioId)
                                           .OrderByDescending(l => l.FechaAccion)
                                           .Take(10)
                                           .ToList();
            var librosPrestados = _data.LibrosPrestados
                                       .Where(lp => lp.UsuarioId == usuarioId)
                                       .Include(lp => lp.Libro) // Incluir los datos del libro
                                       .ToList();

            return new UsuarioConLogsViewModel
            {
                Usuario = usuario,
                LogsRecientes = logsRecientes,
                LibrosPrestados = librosPrestados
            };
        }


    }
}
