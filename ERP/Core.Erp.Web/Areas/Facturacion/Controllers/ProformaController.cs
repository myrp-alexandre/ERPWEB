using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class ProformaController : Controller
    {
        fa_proforma_Bus bus_proforma = new fa_proforma_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        string mensaje = string.Empty;

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proforma()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<fa_proforma_Info> model = new List<fa_proforma_Info>();
            model = bus_proforma.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_proforma", model);
        }

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbCliente_Proforma()
        {
            fa_proforma_Info model = new fa_proforma_Info();
            return PartialView("_CmbCliente_Proforma", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        #endregion


        private bool validar(fa_proforma_Info i_validar, ref string msg)
        {
            i_validar.IdEntidad = i_validar.IdCliente;
            return true;
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_bodega = lst_bodega;

            fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;

            fa_TerminoPago_Bus bus_pago = new fa_TerminoPago_Bus();
            var lst_pago = bus_pago.get_list(false);
            ViewBag.lst_pago = lst_pago;
        }
        public ActionResult Nuevo()
        {
            fa_proforma_Info model = new fa_proforma_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal),
                pf_fecha = DateTime.Now,
                pf_fecha_vcto = DateTime.Now
        };
        cargar_combos();
        return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_proforma_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario_creacion = Session["IdUsuario"].ToString();
            if (!bus_proforma.guardarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdSucursal = 0 , decimal IdProforma = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_proforma_Info model = bus_proforma.get_info(IdEmpresa, IdSucursal, IdProforma);
                if(model == null)
                return RedirectToAction("Index");
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_proforma_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.IdUsuario_modificacion = Session["IdUsuario"].ToString();

            if (!bus_proforma.modificarDB(model))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdSucursal = 0, decimal IdProforma = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_proforma_Info model = bus_proforma.get_info(IdEmpresa, IdSucursal, IdProforma);
            if (model == null)
                return RedirectToAction("Index");
            model.IdEntidad = model.IdCliente;
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_proforma_Info model)
        {
            model.IdUsuario_anulacion = Session["IdUsuario"].ToString();

            if (!bus_proforma.anularDB(model))
            {
                cargar_combos();
                return View(model);
            };
            return RedirectToAction("Index");
        }
    }
}