using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Importacion;
using Core.Erp.Info.Importacion;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.Importacion.Controllers
{
    public class ParametrosImportacionController : Controller
    {
        imp_parametro_Bus bus_parametro = new imp_parametro_Bus();
        public ActionResult Index()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            imp_parametro_Info model = bus_parametro.get_info(IdEmpresa);
            if (model == null)
                model = new imp_parametro_Info { IdEmpresa = IdEmpresa };
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(imp_parametro_Info model)
        {
            if (!bus_parametro.guardarDB(model))
                ViewBag.mensaje = "No se pudieron actualizar los registros";
            cargar_combos();
            return View(model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_tipo_Bus bus_comprobante_tipo = new ct_cbtecble_tipo_Bus();
            var lst_tipo = bus_comprobante_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;
        }
    }
}