using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.General;
using Core.Erp.Info.Helps;
using DevExpress.Web;
using Core.Erp.Web.Helps;
using Core.Erp.Info.General;

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    [SessionTimeout]
    public class ProveedorController : Controller
    {
        #region Variables
        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();
        tb_Catalogo_Bus bus_catalogo = new tb_Catalogo_Bus();
        ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
        tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
        cp_codigo_SRI_Bus bus_codigo = new cp_codigo_SRI_Bus();
        cp_proveedor_clase_Bus bus_clase = new cp_proveedor_clase_Bus();
        tb_banco_Bus bus_banco = new tb_banco_Bus();
        #endregion

        #region Metodos ComboBox bajo demanda banco
        public ActionResult CmbBanco_Proveedor()
        {
            int model = new int();
            return PartialView("_CmbBanco_Proveedor", model);
        }
        public List<tb_banco_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_banco.get_list_bajo_demanda(args);
        }
        public tb_banco_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_banco.get_info_bajo_demanda(args);
        }
        #endregion


        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proveedor()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_proveedor.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_proveedor", model);
        }

        #endregion

        #region Metodos

        private void cargar_combos(int IdEmpresa, string IdTipoSRI = "")
        {
            var lst_banco = bus_banco.get_list(false);
            ViewBag.lst_banco = lst_banco;
            var lst_tipo_cta = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIP_CTA_AC), false);
            ViewBag.lst_tipo_cta = lst_tipo_cta;
            var lst_tipo_doc = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPODOC), false);
            ViewBag.lst_tipo_doc = lst_tipo_doc;
            var lst_tipo_naturaleza = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPONATPER), false);
            ViewBag.lst_tipo_naturaleza = lst_tipo_naturaleza;

            
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;

            var lst_ciudad = bus_ciudad.get_list("",false);
            ViewBag.lst_ciudad = lst_ciudad;

            var lst_codigo = bus_codigo.get_list(IdTipoSRI, false);
            ViewBag.lst_codigo = lst_codigo;

            var lst_clase = bus_clase.get_list(IdEmpresa, false);
            ViewBag.lst_clase = lst_clase;


        }
        #endregion

        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0 )
        {
            cp_proveedor_Info model = new cp_proveedor_Info
            {
                IdEmpresa = IdEmpresa,
                IdClaseProveedor = 1,
                info_persona = new Info.General.tb_persona_Info
                {
                    pe_Naturaleza = "NATU",
                    IdTipoDocumento = "CED"
                }
            };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_proveedor_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_proveedor.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdProveedor = 0)
        {
            cp_proveedor_Info model = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_proveedor_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario.ToString();
            if(!bus_proveedor.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , decimal IdProveedor = 0)
        {
            cp_proveedor_Info model = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_proveedor_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_proveedor.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        #region json
        public JsonResult get_info_x_num_cedula(int IdEmpresa = 0 , string pe_cedulaRuc = "")
        {
            var resultado = bus_proveedor.get_info_x_num_cedula(IdEmpresa, pe_cedulaRuc);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_clase_proveedor(int IdEmpresa = 0 , int IdClaseProveedor = 0)
        {
            cp_proveedor_clase_Bus bus_clase = new cp_proveedor_clase_Bus();
            cp_proveedor_clase_Info resultado = bus_clase.get_info(IdEmpresa, IdClaseProveedor);
            if (resultado == null)
                resultado = new cp_proveedor_clase_Info();

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info(int IdEmpresa = 0 , decimal IdProveedor = 0 )
        {
            var resultado = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}