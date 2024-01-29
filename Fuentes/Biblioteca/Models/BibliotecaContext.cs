using Microsoft.EntityFrameworkCore;

namespace Biblioteca.Models
{
  
    public class BibliotecaContext : DbContext
        {
        public BibliotecaContext(DbContextOptions<BibliotecaContext> options) : base(options) { }

        //Aquí incluyo un DbSet para cada clase que represente una entidad en base de datos:
        public DbSet<Libro> Libros { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<LibroPrestado> LibrosPrestados { get; set; }
        public DbSet<Log> Logs { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Libro>()
                .Property(e => e.Prestado)
                .HasConversion<int>();  //Convierte el bool en un int al guardar en la base de datos

            modelBuilder.Entity<Usuario>()
                .Property(u => u.Rol)
                .HasConversion<int>(); //Convierte el bool en un int al guardar en la base de datos
        }

    }
}
