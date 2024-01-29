namespace Biblioteca.Models
{
    public class UsuarioConLogsViewModel
    {
        public Usuario Usuario { get; set; }
        public List<Log> LogsRecientes { get; set; }
        public List<LibroPrestado> LibrosPrestados { get; set; }
    }

}
