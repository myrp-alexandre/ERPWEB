using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class ChequeBancoController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Nuevo()
        {
            return View();
        }

        public ActionResult Modificar()
        {
            return View();
        }

        public ActionResult Anular()
        {
            return View();
        }

        public ActionResult GridViewPartial_cheque(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            
            return PartialView("_GridViewPartial_cheque");
        }
    }
}