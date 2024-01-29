using System.ComponentModel.DataAnnotations;

namespace Biblioteca.Models
{
    public class LoginViewModel
    {
        [Required]
        public string Usuario { get; set; }

        [Required]
        public string Contraseña { get; set; }
    }

}
