using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Compras;

namespace Core.Erp.Web.Areas.Compras.Controllers
{
    public class CatalogoTipoComprasController : Controller
    {
        com_catalogo_tipo_Bus bus_catalogotipo = new com_catalogo_tipo_Bus();
        public ActionResult Index()
        {
            return View();
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_catipocompras()
        {
            var model = bus_catalogotipo.get_list(true);
            return PartialView("_GridViewPartial_catipocompras", model);
        }
    }
}