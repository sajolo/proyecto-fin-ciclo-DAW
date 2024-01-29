using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Biblioteca.Models
{
    public enum TipoAccion
    {
        Crear = 0,
        Modificar = 1,
        Eliminar = 2,
        PedirPrestado = 3,
        DevolverLibro = 4
    }

    public class Log
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("Usuario")]
        public int UsuarioId { get; set; }

        [Required]
        [EnumDataType(typeof(TipoAccion))]
        public TipoAccion TipoAccion { get; set; }

        [Required]
        [MaxLength(200)]
        public string Descripcion { get; set; }

        [Required]
        public DateTime FechaAccion { get; set; } = DateTime.Now; //Inicializo por defecto a la fecha actual
    }
}
