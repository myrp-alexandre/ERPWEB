using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class EmpresaController : Controller
    {
        tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_empresa()
        {
            List<tb_empresa_Info> model = bus_empresa.get_list(true);
            return PartialView("_GridViewPartial_empresa", model);
        }

        public ActionResult Nuevo()
        {
            tb_empresa_Info model = new tb_empresa_Info
            {
                em_fechaInicioContable = DateTime.Now.Date
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_empresa_Info model)
        {

            if(Session["imagen"]!=null)
            model.em_logo = Session["imagen"] as byte[];
            if (!bus_empresa.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0)
        {
            tb_empresa_Info model = bus_empresa.get_info(IdEmpresa);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_empresa_Info model)
        {
            if (!bus_empresa.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0)
        {
            tb_empresa_Info model = bus_empresa.get_info(IdEmpresa);
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_empresa_Info model)
        {
            if (!bus_empresa.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }



    }
  
}


