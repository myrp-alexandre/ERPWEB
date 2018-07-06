using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.CuentasPorCobrar;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class TipoCobroController : Controller
    {
        cxc_cobro_tipo_Bus bus_tipocobro = new cxc_cobro_tipo_Bus();
        cxc_cobro_tipo_Param_conta_x_sucursal_Bus bus_tipo_param = new cxc_cobro_tipo_Param_conta_x_sucursal_Bus();
        tipo_param_det_List Lst_tipo_param_det = new tipo_param_det_List();

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipocobro()
        {
            List<cxc_cobro_tipo_Info> model = new List<cxc_cobro_tipo_Info>();
            model = bus_tipocobro.get_list(true);
            return PartialView("_GridViewPartial_tipocobro", model);
        }

        private void cargar_combos()
        {
            cxc_cobro_tipo_motivo_Bus bus_motivocobro = new cxc_cobro_tipo_motivo_Bus();
            var lst_motivo_cobro = bus_motivocobro.get_list();
            ViewBag.lst_motivo_cobro = lst_motivo_cobro;

            cxc_CatalogoTipo_Bus bus_catalogotipo = new cxc_CatalogoTipo_Bus();
            var lst_catalogotipo = bus_catalogotipo.get_list();
            ViewBag.lst_catalogotipo = lst_catalogotipo;

            Dictionary<string, string> lst_cta = new Dictionary<string, string>();
            lst_cta.Add("CAJA", "CAJA");
            lst_cta.Add("TIPO_COBRO", "TIPO COBRO");
            ViewBag.lst_cta = lst_cta;
        }
        public ActionResult Nuevo()
        {
            cxc_cobro_tipo_Info model = new cxc_cobro_tipo_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cxc_cobro_tipo_Info model)
        {
            if (bus_tipocobro.validar_existe_IdCobro_tipo(model.IdCobro_tipo))
            {
                ViewBag.mensaje = "El codigo ya se encuentra registrado";
                cargar_combos();
                return View(model);
            }
            if (!bus_tipocobro.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(string IdCobro_tipo = "")
        {
            cxc_cobro_tipo_Info model = bus_tipocobro.get_info(IdCobro_tipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(cxc_cobro_tipo_Info model)
        {
            if (!bus_tipocobro.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(string IdCobro_tipo = "")
        {
            cxc_cobro_tipo_Info model = bus_tipocobro.get_info(IdCobro_tipo);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(cxc_cobro_tipo_Info model)
        {
            if (!bus_tipocobro.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_param(string IdCobro_tipo = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cxc_cobro_tipo_Param_conta_x_sucursal_Info model = new cxc_cobro_tipo_Param_conta_x_sucursal_Info();
  //           model.Lst_tipo_param_det = bus_tipo_param.get_list(IdEmpresa, IdCobro_tipo);
            cargar_combos_det();
            return PartialView("~/Areas/CuentasPorCobrar/Views/TipoCobro/_GridViewPartial_tipo_param.cshtml", model);
        }

        private void cargar_combos_det()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            ct_plancta_Bus bus_cta = new ct_plancta_Bus();
            var lst_cta = bus_cta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cta = lst_cta;
        }

    }

    public class tipo_param_det_List
    {
        public List<cxc_cobro_tipo_Param_conta_x_sucursal_Info> get_list()
        {
            if (HttpContext.Current.Session["cxc_cobro_tipo_Param_conta_x_sucursal_Info"] == null)
            {
                List<cxc_cobro_tipo_Param_conta_x_sucursal_Info> list = new List<cxc_cobro_tipo_Param_conta_x_sucursal_Info>();

                HttpContext.Current.Session["cxc_cobro_tipo_Param_conta_x_sucursal_Info"] = list;
            }
            return (List<cxc_cobro_tipo_Param_conta_x_sucursal_Info>)HttpContext.Current.Session["cxc_cobro_tipo_Param_conta_x_sucursal_Info"];
        }

        public void set_list(List<cxc_cobro_tipo_Param_conta_x_sucursal_Info> list)
        {
            HttpContext.Current.Session["cxc_cobro_tipo_Param_conta_x_sucursal_Info"] = list;
        }

    }
}