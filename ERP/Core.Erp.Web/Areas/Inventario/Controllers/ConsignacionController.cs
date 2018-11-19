using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class ConsignacionController : Controller
    {
        // GET: Inventario/Consignacion

        #region Variables
        in_Consignacion_Bus bus_in_Consignacion;
        #endregion

        public ConsignacionController()
        {
            bus_in_Consignacion = new in_Consignacion_Bus();
        }

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        public ActionResult CmbProveedor_Consignacion()
        {
            in_Consignacion_Info model = new in_Consignacion_Info();
            return PartialView("_CmbProveedor_Consignacion", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda_proveedor(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda_proveedor(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }

        public List<tb_sucursal_Info> get_list_bajo_demanda_sucursal(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_sucursal.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        public tb_sucursal_Info get_info_bajo_demanda_sucursal(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_sucursal.get_info_bajo_demanda(Convert.ToInt32(SessionFixed.IdEmpresa), args);
        }
        #endregion

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GridViewPartial_consignacion()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            var model = bus_in_Consignacion.GetList(true, IdEmpresa);

            return PartialView("_GridViewPartial_consignacion", model);

        }

        #region Acciones
        public ActionResult Nuevo()
        {
            in_Consignacion_Info model = new in_Consignacion_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_Consignacion_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (!bus_in_Consignacion.GuardarBD(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
    }
}