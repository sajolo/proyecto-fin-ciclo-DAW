using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Biblioteca.Models
{
    public class LibroPrestado
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [ForeignKey("Usuario")]
        public int UsuarioId { get; set; }

        [Required]
        [ForeignKey("Libro")]
        public int LibroId { get; set; }

        [Required]
        public DateTime FechaPrestamo { get; set; } = DateTime.Now; //Inicializo por defecto a la fecha actual

        //Propiedades de navegación:
        public virtual Usuario Usuario { get; set; }
        public virtual Libro Libro { get; set; }
    }
}
