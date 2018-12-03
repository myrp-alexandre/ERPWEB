using Core.Erp.Bus.Presupuesto;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Info.SeguridadAcceso;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Presupuesto.Controllers
{
    public class GrupoPresupuestoController : Controller
    {
        // GET: Presupuesto/GrupoPresupuesto
        #region Variables
        pre_Grupo_Bus bus_Grupo = new pre_Grupo_Bus();
        seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Grupo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<pre_Grupo_Info> model = bus_Grupo.GetList(IdEmpresa, true);

            return PartialView("_GridViewPartial_Grupo", model);
        }
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbUsuario()
        {
            string model = "";
            return PartialView("_CmbUsuario", model);
        }

        public List<seg_usuario_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_usuario.get_list_bajo_demanda(args);
        }

        public seg_usuario_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_usuario.get_info_bajo_demanda(args);
        }
        #endregion
    }
}