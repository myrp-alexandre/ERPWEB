using Core.Erp.Bus.Presupuesto;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Presupuesto.Controllers
{
    public class PresupuestoController : Controller
    {
        // GET: Presupuesto/Presupuesto
        #region Variables
        pre_Presupuesto_Bus bus_Presupuesto  = new pre_Presupuesto_Bus();
        pre_Presupuesto_x_grupo_Bus bus_Presupuesto_x_grupo = new pre_Presupuesto_x_grupo_Bus();
        pre_Presupuesto_x_grupo_det_Bus bus_Presupuesto_x_grupo_det = new pre_Presupuesto_x_grupo_det_Bus();

        pre_GrupoDet_List Lista_x_grupo_det = new pre_GrupoDet_List();
        string mensaje = string.Empty;
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Presupuesto(int IdEmpresa, int IdSucursal, DateTime FechaInicio, DateTime FechaFin, bool MostrarAnulados)
        {
            List<pre_Presupuesto_Info> model = bus_Presupuesto.GetList(IdEmpresa, IdSucursal, FechaInicio, FechaFin, true);

            return PartialView("_GridViewPartial_Presupuesto", model);
        }
        #endregion

    }

    public class pre_Presupuesto_x_grupo_det_Lista
    {
        string Variable = "pre_Presupuesto_x_grupo_det_Info";
        public List<pre_Presupuesto_x_grupo_det_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<pre_Presupuesto_x_grupo_det_Info> list = new List<pre_Presupuesto_x_grupo_det_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<pre_Presupuesto_x_grupo_det_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<pre_Presupuesto_x_grupo_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(pre_Presupuesto_x_grupo_det_Info info_det, decimal IdTransaccionSession)
        {
            List<pre_Presupuesto_x_grupo_det_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdRubro = info_det.IdRubro;
            info_det.Cantidad = info_det.Cantidad;
            info_det.Monto = info_det.Monto;

            list.Add(info_det);
        }

        public void UpdateRow(pre_Presupuesto_x_grupo_det_Info info_det, decimal IdTransaccionSession)
        {
            pre_Presupuesto_x_grupo_det_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdRubro = info_det.IdRubro;
            edited_info.Cantidad = info_det.Cantidad;
            edited_info.Monto = info_det.Monto;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<pre_Presupuesto_x_grupo_det_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}