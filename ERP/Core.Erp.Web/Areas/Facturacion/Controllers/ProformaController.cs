using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class ProformaController : Controller
    {
        fa_proforma_Bus bus_proforma = new fa_proforma_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_proforma()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<fa_proforma_Info> model = new List<fa_proforma_Info>();
            model = bus_proforma.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_proforma", model);
        }
    }
}