using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Helps;

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

        private void cargar_combos()
        {
            Dictionary<string, string> lst_tipo_nota = new Dictionary<string, string>();
            lst_tipo_nota.Add("CHEQ", "Cheque");
            lst_tipo_nota.Add("DEPO", "Depósito");
            lst_tipo_nota.Add("NCBA", "Nota de crédito");
            lst_tipo_nota.Add("NDBA", "Nota de débito");
            ViewBag.lst_tipo_nota = lst_tipo_nota;
        }
        public ActionResult Nuevo()
        {
            ba_tipo_nota_Info model = new ba_tipo_nota_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_tipo_nota_Info model)
        {
            if(!bus_tipo.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ba_tipo_nota_Info model = bus_tipo.get_info(IdEmpresa, IdTipoNota);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ba_tipo_nota_Info model)
        {
            if(!bus_tipo.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ba_tipo_nota_Info model = bus_tipo.get_info(IdEmpresa, IdTipoNota);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(ba_tipo_nota_Info model)
        {
            if (!bus_tipo.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
    }
}