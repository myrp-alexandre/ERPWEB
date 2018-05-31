using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Reportes.RRHH;
using Core.Erp.Bus.Reportes.RRHH;
using Core.Erp.Web.Reportes.RRHH;
using DevExpress.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class RRHHReportesController : Controller
    {


        public ActionResult VWROL_001(int IdEmpresa=0, int IdNomina=0, int IdNominaTipo=0, int IdPeriodo=0)
        {
            ROL_001_Rpt model = new ROL_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdNomina.Value = IdNomina;
            model.p_IdNominaTipo.Value = IdNominaTipo;
            model.p_IdPeriodo.Value = IdPeriodo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdPeriodo == 0)
                model.RequestParameters = false;
            return View(model);
        }


    }
}