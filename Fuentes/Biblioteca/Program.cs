using Biblioteca.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.Cookies;

var builder = WebApplication.CreateBuilder(args);

//A�adimos contexto y cadena de conexi�n:
builder.Services.AddDbContext<BibliotecaContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("ConexionMontecastelo")));

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSession(); //A�adimos para trabajar con variables de sesi�n

// Configuraci�n de autenticaci�n
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options => {
        options.LoginPath = "/Home/Login";
        options.AccessDeniedPath = "/Home/AccessDenied";
    });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseSession(); //A�adimos para trabajar con variables de sesi�n
app.UseRouting();

app.UseAuthentication(); // Middleware de autenticaci�n
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
