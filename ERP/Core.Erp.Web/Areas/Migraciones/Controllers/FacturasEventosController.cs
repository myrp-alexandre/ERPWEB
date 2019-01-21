using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Migraciones;
using Core.Erp.Bus.Migraciones;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.Migraciones.Controllers
{
    [SessionTimeout]
    public class FacturasEventosController : Controller
    {
        FacturasEventos_Bus bus_facturas = new FacturasEventos_Bus();
        tb_comprobantes_sin_autorizacion_List Lis_tb_comprobantes_sin_autorizacion_List = new tb_comprobantes_sin_autorizacion_List();
        #region vistas 
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            return View(model);
        }

       
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_documentos_pendientes_enviar_sri(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdEmpresa = 0, int IdSucursal = 0)
        {

            ViewBag.IdEmpresa = IdEmpresa;
            ViewBag.IdSucursal = IdSucursal;
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);

            var model = bus_facturas.get_list();
            Lis_tb_comprobantes_sin_autorizacion_List.set_list(model);
            return PartialView("_GridViewPartial_documentos_pendientes_enviar_sri", model);
        }

        #endregion


        #region json
        public JsonResult guardar_aprobacion(string Ids)
        {
            string[] array = Ids.Split(',');
            var output = array.GroupBy(q => q).ToList();
            foreach (var item in output)
            {
                if (item.Key != "")
                {
                    //var info = Lis_tb_comprobantes_sin_autorizacion_List.get_list().Where(v => v.secuencia == Convert.ToDecimal(item.Key)).FirstOrDefault();
                    //if (info != null)
                       // bus_facturas.modificarEstado(info);
                }
            }
            return Json("", JsonRequestBehavior.AllowGet);
        }
        #endregion
    }


    public class tb_comprobantes_sin_autorizacion_List
    {
        string Variable = "tb_comprobantes_sin_autorizacion_List";
        public List<FacturasEventos_Info> get_list()
        {
            if (HttpContext.Current.Session[Variable] == null)
            {
                List<FacturasEventos_Info> list = new List<FacturasEventos_Info>();

                HttpContext.Current.Session[Variable] = list;
            }
            return (List<FacturasEventos_Info>)HttpContext.Current.Session[Variable];
        }

        public void set_list(List<FacturasEventos_Info> list)
        {
            HttpContext.Current.Session[Variable] = list;
        }

    }
}