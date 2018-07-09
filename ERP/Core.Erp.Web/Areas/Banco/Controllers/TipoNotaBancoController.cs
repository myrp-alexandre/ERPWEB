using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class TipoNotaBancoController : Controller
    {
        ba_tipo_nota_Bus bus_tipo = new ba_tipo_nota_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipo_nota(int IdTipoNota = 0)
        {
            List<ba_tipo_nota_Info> model = new List<ba_tipo_nota_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_tipo.get_list(IdEmpresa, IdTipoNota, true);
            return PartialView("_GridViewPartial_tipo_nota", model);
        }

        public ActionResult Nuevo()
        {
            ba_tipo_nota_Info model = new ba_tipo_nota_Info();
            return View(model);
        }

        private void cargar_combos()
        {
            
        }

    }
}