using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class TarjetaCreditoPorProveedorController : Controller
    {
        // GET: General/tb_TarjetaCredito_x_cp_proveedor
        #region Variables
        tb_TarjetaCredito_x_cp_proveedor_Bus bus_TarjetaCredito_x_cp_proveedor;
        #endregion
        public TarjetaCreditoPorProveedorController()
        {
            bus_TarjetaCredito_x_cp_proveedor = new tb_TarjetaCredito_x_cp_proveedor_Bus();
        }

        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbProveedor_TarjetaCredito()
        {
            tb_TarjetaCredito_x_cp_proveedor_Info model = new tb_TarjetaCredito_x_cp_proveedor_Info();
            return PartialView("_CmbProveedor_TarjetaCredito", model);
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

        public ActionResult GridViewPartial_tarjeta_credito_proveedor()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            var model = bus_TarjetaCredito_x_cp_proveedor.GetList(true, IdEmpresa);

            return PartialView("_GridViewPartial_tarjeta_credito_proveedor", model);

        }


        #region Acciones
        public ActionResult Nuevo()
        {
            cargar_combo();
            tb_TarjetaCredito_x_cp_proveedor_Info model = new tb_TarjetaCredito_x_cp_proveedor_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_TarjetaCredito_x_cp_proveedor_Info model)
        {
            model.IdUsuario = SessionFixed.IdUsuario;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);

            if (bus_TarjetaCredito_x_cp_proveedor.validar_existe_tarjeta_proveedor(model.IdEmpresa, model.IdTransaccion, model.IdTarjeta, Convert.ToInt32(model.IdProveedor)))
            {
                cargar_combo();
                ViewBag.mensaje = "El proveedor ya tiene asignada la tarjeta de crédito";
                return View(model);
            }

            if (!bus_TarjetaCredito_x_cp_proveedor.GuardarBD(model))
            {
                cargar_combo();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdTransaccion = 0, int IdTarjeta = 0, decimal IdProveedor=0)
        {
            tb_TarjetaCredito_x_cp_proveedor_Info model = bus_TarjetaCredito_x_cp_proveedor.GetInfo(IdEmpresa, IdTransaccion, IdTarjeta, IdProveedor);            

            if (model == null)
                return RedirectToAction("Index");

            cargar_combo();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(tb_TarjetaCredito_x_cp_proveedor_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario;

            if (model.IdProveedor == 0)
            {
                cargar_combo();
                ViewBag.mensaje = "El campo proveedor es obligatorio";
                return View(model);
            }

            if (bus_TarjetaCredito_x_cp_proveedor.validar_existe_tarjeta_proveedor(model.IdEmpresa, model.IdTransaccion, model.IdTarjeta, Convert.ToInt32(model.IdProveedor)))
            {
                cargar_combo();
                ViewBag.mensaje = "El proveedor ya tiene asignada la tarjeta de crédito";
                return View(model);
            }

            if (!bus_TarjetaCredito_x_cp_proveedor.ModificarBD(model))
            {
                cargar_combo();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdTransaccion = 0, int IdTarjeta = 0, decimal IdProveedor = 0)
        {
            tb_TarjetaCredito_x_cp_proveedor_Info model = bus_TarjetaCredito_x_cp_proveedor.GetInfo(IdEmpresa,IdTransaccion, IdTarjeta, IdProveedor);

            if (model == null)
                return RedirectToAction("Index");

            cargar_combo();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(tb_TarjetaCredito_x_cp_proveedor_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario;

            if (!bus_TarjetaCredito_x_cp_proveedor.AnularBD(model))
            {
                cargar_combo();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        private void cargar_combo()
        {

            try
            {
                tb_TarjetaCredito_Bus bus_tarjeta_credito = new tb_TarjetaCredito_Bus();
                var lst_tarjeta_credito = bus_tarjeta_credito.GetList(false);
                ViewBag.lst_tarjeta_credito = lst_tarjeta_credito;
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion



    }
}