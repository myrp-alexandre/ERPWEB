using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class AuditoriaInventarioController : Controller
    {
        #region  Variables
        in_transferencia_Bus bus_transferencia = new in_transferencia_Bus();
        in_transferencia_Corregir_List ListaCorregirTransferencia = new in_transferencia_Corregir_List();
        List<in_transferencia_Info> Lista_CorregirTransferencia = new List<in_transferencia_Info>();
        #endregion

        public ActionResult Index()
        {
            in_transferencia_Info model = new in_transferencia_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual),
                fecha_correccion_transferencia = DateTime.Now.Date
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(in_transferencia_Info model)
        {            
            return View(model);
        }

        public ActionResult GridViewPartial_CorreccionTransferencias(DateTime? fecha_ini)
        {
            var IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date : Convert.ToDateTime(fecha_ini);

            var model = ListaCorregirTransferencia.get_list(IdTransaccionSession);

            return PartialView("_GridViewPartial_CorreccionTransferencias", model);
        }

        #region Json
        public JsonResult BuscarTransferencia(DateTime fecha_ini, int IdEmpresa = 0)
        {
            var IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date : Convert.ToDateTime(fecha_ini);

            var model = bus_transferencia.GetListRecosteoInventario(IdEmpresa, ViewBag.fecha_ini);
            ListaCorregirTransferencia.set_list(model, IdTransaccionSession);

            return Json(model, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CorregirTransferencia(DateTime fecha_ini, int IdEmpresa = 0)
        {
            var IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            Lista_CorregirTransferencia = ListaCorregirTransferencia.get_list(IdTransaccionSession);

            var Result = bus_transferencia.CorregirTransferencia(Lista_CorregirTransferencia, fecha_ini);

            List<in_transferencia_Info> model = new List<in_transferencia_Info>();            
            ListaCorregirTransferencia.set_list(model, IdTransaccionSession);

            return Json(Result, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }

    public class in_transferencia_Corregir_List
    {
        string Variable = "in_transferencia_Info";
        public List<in_transferencia_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<in_transferencia_Info> list = new List<in_transferencia_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<in_transferencia_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<in_transferencia_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }
    }
}