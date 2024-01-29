using System.ComponentModel.DataAnnotations;

namespace Biblioteca.Models
{
    public class Usuario
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string Nombre { get; set; }

        [Required]
        [RegularExpression(@"^(?=.*\d).+$", ErrorMessage = "La contraseña debe contener al menos un número.")]
        public string Password { get; set; }

        [Required]
        public bool Rol { get; set; } = false;
    }
}
