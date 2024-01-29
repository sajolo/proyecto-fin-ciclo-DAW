using System.ComponentModel.DataAnnotations;

namespace Biblioteca.Models
{
    public class Libro
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(200)]
        public string Titulo { get; set; }

        [Required]
        [MaxLength(50)]
        public string Autor { get; set; }

        [Required]
        [Range(int.MinValue, 2024)] //Permito números negativos para las publicaciones de a.C.
        public int AnhoPublicacion { get; set; }

        [Required]
        public bool Prestado { get; set; } = false;
    }
}
