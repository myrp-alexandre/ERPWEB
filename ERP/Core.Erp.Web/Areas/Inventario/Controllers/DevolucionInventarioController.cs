using Core.Erp.Bus.General;
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
    public class DevolucionInventarioController : Controller
    {
        #region Variables
        in_devolucion_inven_Bus bus_devolucion = new in_devolucion_inven_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        in_devolucion_inven_det_List List_det = new in_devolucion_inven_det_List();
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            return View(model);
        }
        public ActionResult GridViewPartial_devolucion(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            var model = bus_devolucion.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_devolucion",model);
        }
        #endregion

        #region Metodos
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Dictionary<string, string> lst_signo = new Dictionary<string, string>();
            lst_signo.Add("+", "Ingreso por devolución");
            lst_signo.Add("-", "Egreso por devolución");            
            ViewBag.lst_signo = lst_signo;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo()
        {
            in_devolucion_inven_Info model = new in_devolucion_inven_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa)
            };
            cargar_combos();
            return View(model);
        }

        public ActionResult Modificar(decimal IdDev_Inven = 0)
        {
            return View();
        }
        public ActionResult Anular(decimal IdDev_Inven = 0)
        {
            return View();
        }
        #endregion

        public JsonResult GetMovimientos(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            bool resultado = false;



            return Json(resultado,JsonRequestBehavior.AllowGet);
        }

        #region Detalle
        public ActionResult GridViewPartial_devolucion_det()
        {
            var model = List_det.get_list();
            return PartialView("_GridViewPartial_devolucion_det",model);
        }
        public ActionResult GridViewPartial_devolucion_det_x_cruzar()
        {
            return PartialView("_GridViewPartial_devolucion_det_x_cruzar");
        }
        #endregion
    }

    public class in_devolucion_inven_det_List
    {
        public List<in_devolucion_inven_det_Info> get_list()
        {
            if (HttpContext.Current.Session["in_devolucion_inven_det_Info"] == null)
            {
                List<in_devolucion_inven_det_Info> list = new List<in_devolucion_inven_det_Info>();

                HttpContext.Current.Session["in_devolucion_inven_det_Info"] = list;
            }
            return (List<in_devolucion_inven_det_Info>)HttpContext.Current.Session["in_devolucion_inven_det_Info"];
        }

        public void set_list(List<in_devolucion_inven_det_Info> list)
        {
            HttpContext.Current.Session["in_devolucion_inven_det_Info"] = list;
        }

        public void AddRow(in_devolucion_inven_det_Info info_det)
        {
            List<in_devolucion_inven_det_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            info_det.cant_devuelta = info_det.cant_devuelta;
            list.Add(info_det);
        }

        public void UpdateRow(in_devolucion_inven_det_Info info_det)
        {
            in_devolucion_inven_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.cant_devuelta = info_det.cant_devuelta;
        }

        public void DeleteRow(int secuencia)
        {
            List<in_devolucion_inven_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}