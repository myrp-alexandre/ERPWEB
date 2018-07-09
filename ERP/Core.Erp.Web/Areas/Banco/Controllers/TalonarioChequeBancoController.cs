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
    public class TalonarioChequeBancoController : Controller
    {
        ba_Talonario_cheques_x_banco_Bus bus_talonario = new ba_Talonario_cheques_x_banco_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_talonario_cheque()
        {
            List<ba_Talonario_cheques_x_banco_Info> model = new List<ba_Talonario_cheques_x_banco_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model = bus_talonario.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_talonario_cheque", model);
        }
    }
}