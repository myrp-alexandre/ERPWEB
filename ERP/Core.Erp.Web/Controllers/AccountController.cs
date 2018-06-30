using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Core.Erp.Web.Models;
using Core.Erp.Info.SeguridadAcceso;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Bus.General;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Controllers
{
    public class AccountController : Controller
    {
        seg_Usuario_x_Empresa_Bus bus_usuario_x_empresa = new seg_Usuario_x_Empresa_Bus();
        seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
        tb_empresa_Bus bus_empresa = new tb_empresa_Bus();        
        [AllowAnonymous]
        public ActionResult Login()
        {            
            LoginModel model = new LoginModel();
            return View(model);
        }
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(LoginModel model)
        {
            seg_usuario_Info info_usuario = bus_usuario.validar_login(model.IdUsuario, model.Contrasena);
            if(info_usuario != null)
            {
                if (info_usuario.CambiarContraseniaSgtSesion)
                    return RedirectToAction("CambiarContrasena", new { IdUsuario = model.IdUsuario });
                return RedirectToAction("LoginEmpresa",new {IdUsuario = model.IdUsuario});
            }
            ViewBag.mensaje = "Credenciales incorrectas";
            return View(model);
        }
        [AllowAnonymous]
        public ActionResult LoginEmpresa(string IdUsuario = "")
        {
            var lst = bus_usuario_x_empresa.get_list(IdUsuario);
            if (lst.Count == 0)
                return RedirectToAction("Login");

            var lst_empresa = bus_empresa.get_list(true);

            lst = (from q in lst
                   join e in lst_empresa
                   on q.IdEmpresa equals e.IdEmpresa
                   select new seg_Usuario_x_Empresa_Info
                   {
                       IdEmpresa = q.IdEmpresa,
                       em_nombre = e.em_nombre
                   }).ToList();

            ViewBag.lst_empresas = lst;
            LoginModel model = new LoginModel
            {
                IdUsuario = IdUsuario
            };
            return View();
        }
        [HttpPost]
        public ActionResult LoginEmpresa(LoginModel model)
        {
            var info_empresa = bus_empresa.get_info(model.IdEmpresa);
            if (info_empresa == null)
                return View(model);
            Session["IdUsuario"] = model.IdUsuario;
            Session["IdEmpresa"] = model.IdEmpresa;
            Session["nom_empresa"] = info_empresa.em_nombre;
            SessionFixed.IdEmpresa = model.IdEmpresa.ToString();
            return RedirectToAction("Index","Home");
        }

        

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            Session["IdUsuario"] = null;
            return RedirectToAction("Index", "Home");
        }

        public ActionResult CambiarContrasena(string IdUsuario = "")
        {
            LoginModel model = new LoginModel { IdUsuario = IdUsuario};
            return View(model);
        }
        [HttpPost]
        public ActionResult CambiarContrasena(LoginModel model)
        {
            model.Contrasena = string.IsNullOrEmpty(model.Contrasena) ? "" : model.Contrasena.Trim();
            model.new_Contrasena = string.IsNullOrEmpty(model.new_Contrasena) ? "" : model.new_Contrasena.Trim();
            if (model.Contrasena == model.new_Contrasena)
            {
                ViewBag.mensaje = "La nueva contraseña no debe ser igual a la anterior";
                return View(model);
            }
            if (!bus_usuario.modificarDB(model.IdUsuario,model.Contrasena,model.new_Contrasena))
            {
                ViewBag.mensaje = "Credenciales incorrectas, por favor corrija";
                return View(model);
            }
            return RedirectToAction("Login");
        }
    }
}