using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Compras;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.Compras;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class OrdenCompraLocalController : Controller
    {
        #region Varibales
            com_ordencompra_local_Bus bus_ordencompra = new com_ordencompra_local_Bus();
            cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
            com_TerminoPago_Bus bus_termino = new com_TerminoPago_Bus();
            com_catalogo_Bus bus_catalogo = new com_catalogo_Bus();
            com_estado_cierre_Bus bus_estado = new com_estado_cierre_Bus();
            com_comprador_Bus bus_comprador = new com_comprador_Bus();
            com_departamento_Bus bus_departamento = new com_departamento_Bus();
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        #endregion

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbProveedor_COM()
        {
            com_ordencompra_local_Info model = new com_ordencompra_local_Info();
            return PartialView("_CmbProveedor_COM", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.PROVEE.ToString());
        }
        #endregion

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ordencompralocal()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_ordencompra.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_ordencompralocal", model);
        }

        private void cargar_combos(int IdEmpresa)
        {
            var lst_termino = bus_termino.get_list(false);
            ViewBag.lst_termino = lst_termino;

            var lst_apro = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoCOM.EST_APRO), false);
            ViewBag.lst_apro = lst_apro;

            var lst_rec = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoCOM.EST_REC), false);
            ViewBag.lst_rec = lst_rec;

            var lst_estado = bus_estado.get_list(false);
            ViewBag.lst_estado = lst_estado;

            var lst_comprador = bus_comprador.get_list(IdEmpresa,false);
            ViewBag.lst_comprador = lst_comprador;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_dep = bus_departamento.get_list(IdEmpresa, false);
            ViewBag.lst_dep = lst_dep;
        }

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            com_ordencompra_local_Info model = new com_ordencompra_local_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(com_ordencompra_local_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_ordencompra.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, int IdSucursal = 0 ,  decimal IdOrdenCompra = 0)
        {
            com_ordencompra_local_Info model = bus_ordencompra.get_info(IdEmpresa, IdSucursal, IdOrdenCompra);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(com_ordencompra_local_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;

            if (!bus_ordencompra.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, int IdSucursal = 0, decimal IdOrdenCompra = 0)
        {
            com_ordencompra_local_Info model = bus_ordencompra.get_info(IdEmpresa, IdSucursal, IdOrdenCompra);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(com_ordencompra_local_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;

            if (!bus_ordencompra.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}