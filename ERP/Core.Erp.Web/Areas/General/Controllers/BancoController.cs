using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Web.Helps;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    [SessionTimeout]
    public class BancoController : Controller
    {
        #region Index

        tb_banco_Bus bus_banco = new tb_banco_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_banco()
        {
            List<tb_banco_Info> model = new List<tb_banco_Info>();
            model = bus_banco.get_list(true);
            return PartialView("_GridViewPartial_banco", model);
        }
        #endregion

        #region Acciones

        public ActionResult Nuevo()
        {
            tb_banco_Info model = new tb_banco_Info();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(tb_banco_Info model)
        {
            if (!bus_banco.guardarDB(model))
                return View(model);
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdBanco = 0)
        {
            tb_banco_Info model = bus_banco.get_info(IdBanco);
                if(model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_banco_Info model)
        {
            if (!bus_banco.modificarDB(model))
                return View(model);

            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdBanco = 0)
        {
            tb_banco_Info model = bus_banco.get_info(IdBanco);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_banco_Info model)
        {
            if (!bus_banco.anularDB(model))
                return View(model);
            return RedirectToAction("Index");
        }
        #endregion
    }
}