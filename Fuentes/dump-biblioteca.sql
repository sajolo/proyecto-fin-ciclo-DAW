USE [master]
GO
/****** Object:  Database [Biblioteca]    Script Date: 16/11/2023 19:40:57 ******/
CREATE DATABASE [Biblioteca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Biblioteca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Biblioteca_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Biblioteca] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteca] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [Biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteca] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Biblioteca] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Biblioteca] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Biblioteca', N'ON'
GO
ALTER DATABASE [Biblioteca] SET QUERY_STORE = ON
GO
ALTER DATABASE [Biblioteca] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Biblioteca]
GO
/****** Object:  User [saul]    Script Date: 16/11/2023 19:40:57 ******/
CREATE USER [saul] FOR LOGIN [saul] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Libros]    Script Date: 16/11/2023 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Libros](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](255) NOT NULL,
	[Autor] [nvarchar](50) NOT NULL,
	[AnhoPublicacion] [int] NOT NULL,
	[Prestado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibrosPrestados]    Script Date: 16/11/2023 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibrosPrestados](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[LibroId] [int] NOT NULL,
	[FechaPrestamo] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 16/11/2023 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[TipoAccion] [int] NOT NULL,
	[Descripcion] [nvarchar](500) NOT NULL,
	[FechaAccion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 16/11/2023 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Rol] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Libros] ON 

INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1, N'1984', N'George Orwell', 1949, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (2, N'To Kill a Mockingbird', N'Harper Lee', 1960, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (3, N'Moby-Dick', N'Herman Melville', 1851, 1)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (4, N'Don Quijote', N'Miguel de Cervantes', 1615, 1)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (5, N'The Great Gatsby', N'F. Scott Fitzgerald', 1925, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (6, N'Pride and Prejudice', N'Jane Austen', 1813, 1)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1008, N'Frankestein', N'Mery Shelly', 1818, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1009, N'El Lazarillo de Tormes', N'Anónimo', 1515, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1010, N'La mil y una noches', N'Anónimo', 1702, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1011, N'Los tres mosqueteros', N'Alexandre Dumas', 1844, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1012, N'Cumbres Borrascosas', N'Emily Bronte', 1847, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1013, N'Jane Eyre', N'Charlotte Bronte', 1847, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1014, N'Madame Bovary', N'Flaubert', 1857, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1015, N'Grandes esperanzas', N'Charles Dickens', 1861, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1016, N'Crimen y castigo', N'Dostoievski', 1866, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1017, N'Mujercitas', N'Louisa May Alcott', 1869, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1018, N'Ana Karenina', N'Tolstoi', 1877, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1019, N'El retrato de Dorian Gray', N'Oscar Wilde', 1890, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1020, N'La señora Dalloway', N'Virginia Woolf', 1925, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1021, N'El gran Gatsby', N'Fitzgerald', 1925, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1022, N'El amor en los tiempos del cólera', N'García Márquez', 1985, 0)
INSERT [dbo].[Libros] ([Id], [Titulo], [Autor], [AnhoPublicacion], [Prestado]) VALUES (1023, N'El viejo y el mar', N'Hemingway', 1951, 1)
SET IDENTITY_INSERT [dbo].[Libros] OFF
GO
SET IDENTITY_INSERT [dbo].[LibrosPrestados] ON 

INSERT [dbo].[LibrosPrestados] ([Id], [UsuarioId], [LibroId], [FechaPrestamo]) VALUES (5, 2, 6, CAST(N'2023-11-13T12:59:33.183' AS DateTime))
INSERT [dbo].[LibrosPrestados] ([Id], [UsuarioId], [LibroId], [FechaPrestamo]) VALUES (6, 2, 3, CAST(N'2023-11-13T13:14:54.530' AS DateTime))
INSERT [dbo].[LibrosPrestados] ([Id], [UsuarioId], [LibroId], [FechaPrestamo]) VALUES (7, 3, 4, CAST(N'2023-11-13T13:15:09.697' AS DateTime))
INSERT [dbo].[LibrosPrestados] ([Id], [UsuarioId], [LibroId], [FechaPrestamo]) VALUES (8, 1, 1023, CAST(N'2023-11-16T19:13:56.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[LibrosPrestados] OFF
GO
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (1, 1, 3, N'El libro ''1984'' ha sido prestado.', CAST(N'2023-11-13T11:59:26.543' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (2, 1, 3, N'El libro ''To Kill a Mockingbird'' ha sido prestado.', CAST(N'2023-11-13T12:03:58.800' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (3, 1, 3, N'El libro ''Moby-Dick'' ha sido prestado.', CAST(N'2023-11-13T12:08:15.723' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (4, 1, 3, N'El libro ''1984'' ha sido prestado.', CAST(N'2023-11-13T12:18:27.943' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (5, 1, 2, N'Eliminación del libro ''El Lazarillo de Tormes''', CAST(N'2023-11-13T12:46:12.503' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (6, 1, 0, N'Creación del libro ''El Lazarillo de Tormes''', CAST(N'2023-11-13T12:46:42.753' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (7, 2, 3, N'El libro ''Pride and Prejudice'' ha sido prestado.', CAST(N'2023-11-13T12:59:33.220' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (8, 2, 3, N'El libro ''Moby-Dick'' ha sido prestado.', CAST(N'2023-11-13T13:14:54.553' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (9, 3, 3, N'El libro ''Don Quijote'' ha sido prestado.', CAST(N'2023-11-13T13:15:09.697' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (10, 1, 0, N'Creación del libro ''La mil y una noches''', CAST(N'2023-11-13T13:29:36.630' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (11, 1, 0, N'Creación del libro ''Los tres mosqueteros''', CAST(N'2023-11-13T13:29:57.130' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (12, 1, 0, N'Creación del libro ''Cumbres Borrascosas''', CAST(N'2023-11-13T13:30:11.717' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (13, 1, 0, N'Creación del libro ''Jane Eyre''', CAST(N'2023-11-13T13:30:26.877' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (14, 1, 0, N'Creación del libro ''Madame Bovary''', CAST(N'2023-11-13T13:30:42.363' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (15, 1, 0, N'Creación del libro ''Grandes esperanzas''', CAST(N'2023-11-13T13:31:06.483' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (16, 1, 0, N'Creación del libro ''Crimen y castigo''', CAST(N'2023-11-13T13:31:28.790' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (17, 1, 0, N'Creación del libro ''Mujercitas''', CAST(N'2023-11-13T13:31:47.873' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (18, 1, 0, N'Creación del libro ''Ana Karenina''', CAST(N'2023-11-13T13:32:01.360' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (19, 1, 0, N'Creación del libro ''El retrato de Dorian Gray''', CAST(N'2023-11-13T13:32:18.650' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (20, 1, 0, N'Creación del libro ''La señora Dalloway''', CAST(N'2023-11-13T13:32:36.667' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (21, 1, 0, N'Creación del libro ''El gran Gatsby''', CAST(N'2023-11-13T13:32:58.697' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (22, 1, 0, N'Creación del libro ''El amor en los tiempos del cólera''', CAST(N'2023-11-13T13:33:43.363' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (23, 1, 0, N'Creación del libro ''El viejo y el mar''', CAST(N'2023-11-16T19:13:43.997' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (24, 1, 3, N'El libro ''El viejo y el mar'' ha sido prestado.', CAST(N'2023-11-16T19:13:56.257' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (25, 1, 0, N'Creación del libro ''Prueba libro''', CAST(N'2023-11-16T19:16:15.253' AS DateTime))
INSERT [dbo].[Logs] ([Id], [UsuarioId], [TipoAccion], [Descripcion], [FechaAccion]) VALUES (26, 1, 2, N'Eliminación del libro ''Prueba libro''', CAST(N'2023-11-16T19:22:19.080' AS DateTime))
SET IDENTITY_INSERT [dbo].[Logs] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id], [Nombre], [Password], [Rol]) VALUES (1, N'Saul', N'saul1', 1)
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Password], [Rol]) VALUES (2, N'Manuel', N'manuel2', 0)
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Password], [Rol]) VALUES (3, N'Laura', N'laura3', 0)
INSERT [dbo].[Usuarios] ([Id], [Nombre], [Password], [Rol]) VALUES (4, N'Pedro', N'pedro4', 0)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[Libros] ADD  DEFAULT ((0)) FOR [Prestado]
GO
ALTER TABLE [dbo].[LibrosPrestados]  WITH CHECK ADD FOREIGN KEY([LibroId])
REFERENCES [dbo].[Libros] ([Id])
GO
ALTER TABLE [dbo].[LibrosPrestados]  WITH CHECK ADD FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Libros]  WITH CHECK ADD CHECK  (([Prestado]=(1) OR [Prestado]=(0)))
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD CHECK  (([TipoAccion]>=(0) AND [TipoAccion]<=(4)))
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD CHECK  (([Rol]=(1) OR [Rol]=(0)))
GO
USE [master]
GO
ALTER DATABASE [Biblioteca] SET  READ_WRITE 
GO
