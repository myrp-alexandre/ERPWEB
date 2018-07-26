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

namespace Core.Erp.Web.Areas.CuentasPorPagar.Controllers
{
    public class ProveedorController : Controller
    {



        cp_proveedor_Bus bus_proveedor = new cp_proveedor_Bus();


  
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proveedor()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cp_proveedor_Info> model = new List<cp_proveedor_Info>();
            model = bus_proveedor.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_proveedor", model);
        }

        private void cargar_combos(string IdTipoSRI = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_Catalogo_Bus bus_catalogo = new tb_Catalogo_Bus();
            var lst_tipo_cta = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIP_CTA_AC), false);
            ViewBag.lst_tipo_cta = lst_tipo_cta;
            var lst_tipo_doc = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPODOC), false);
            ViewBag.lst_tipo_doc = lst_tipo_doc;
            var lst_tipo_naturaleza = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPONATPER), false);
            ViewBag.lst_tipo_naturaleza = lst_tipo_naturaleza;

            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_cuentas;

            tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
            var lst_ciudad = bus_ciudad.get_list("",false);
            ViewBag.lst_ciudad = lst_ciudad;

            cp_codigo_SRI_Bus bus_codigo = new cp_codigo_SRI_Bus();
            var lst_codigo = bus_codigo.get_list(IdTipoSRI, false);
            ViewBag.lst_codigo = lst_codigo;

            cp_proveedor_clase_Bus bus_clase = new cp_proveedor_clase_Bus();
            var lst_clase = bus_clase.get_list(IdEmpresa, false);
            ViewBag.lst_clase = lst_clase;


        }

        public ActionResult Nuevo()
        {
            cp_proveedor_Info model = new cp_proveedor_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                IdClaseProveedor = 1,
                info_persona = new Info.General.tb_persona_Info
                {
                    pe_Naturaleza = "NATU",
                    IdTipoDocumento = "CED"
                }
            };
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_proveedor_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_proveedor.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(decimal IdProveedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_proveedor_Info model = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(cp_proveedor_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if(!bus_proveedor.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdProveedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_proveedor_Info model = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(cp_proveedor_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_proveedor.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #region json
        public JsonResult get_info_x_num_cedula(string pe_cedulaRuc = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_proveedor.get_info_x_num_cedula(IdEmpresa, pe_cedulaRuc);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_clase_proveedor(int IdClaseProveedor = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_proveedor_clase_Bus bus_clase = new cp_proveedor_clase_Bus();
            cp_proveedor_clase_Info resultado = bus_clase.get_info(IdEmpresa, IdClaseProveedor);
            if (resultado == null)
                resultado = new cp_proveedor_clase_Info();

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info(decimal IdProveedor)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_proveedor.get_info(IdEmpresa, IdProveedor);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}