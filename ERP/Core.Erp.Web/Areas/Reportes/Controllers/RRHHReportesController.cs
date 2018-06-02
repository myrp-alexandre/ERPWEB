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


        public ActionResult ROL_001(int IdEmpresa=0, int IdNomina_Tipo = 0, int IdNomina_TipoLiqui= 0, int IdPeriodo=0)
        {
            ROL_001_Rpt model = new ROL_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdNomina.Value = IdNomina_Tipo;
            model.p_IdNominaTipo.Value = IdNomina_TipoLiqui;
            model.p_IdPeriodo.Value = IdPeriodo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdPeriodo == 0)
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ROL_002(int IdEmpresa = 0, int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            ROL_002_Rpt model = new ROL_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdNomina.Value = IdNomina_Tipo;
            model.p_IdNominaTipo.Value = IdNomina_TipoLiqui;
            model.p_IdPeriodo.Value = IdPeriodo;
            model.empresa = Session["nom_empresa"].ToString();
            if (IdPeriodo == 0)
                model.RequestParameters = false;
            return View(model);
        }


    }
}