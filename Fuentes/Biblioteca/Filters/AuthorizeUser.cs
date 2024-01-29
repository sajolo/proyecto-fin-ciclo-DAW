using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

//Creo un filtro de acción personalizado para manejar la auorización del acceso a determinadas páginas (añadiendo el filtro encima del controlador)

namespace Biblioteca.Filters
{
    public class AuthorizeUser : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var userId = context.HttpContext.Session.GetString("UserId");
            if (userId == null)
            {
                context.Result = new RedirectToActionResult("Index", "Home", null);
            }
        }
    }
}
