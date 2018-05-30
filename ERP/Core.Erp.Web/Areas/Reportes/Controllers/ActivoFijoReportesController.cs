using Core.Erp.Web.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class ActivoFijoReportesController : Controller
    {
        public ActionResult VWACTF_001(decimal Id_Mejora_Baja_Activo = 0, string Id_Tipo = "" )
        {
            VWACTF_001_Rpt model = new VWACTF_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_Id_Mejora_Baja_Activo.Value = Id_Mejora_Baja_Activo;
            model.p_Id_Tipo.Value = Id_Tipo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (Id_Mejora_Baja_Activo == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult VWACTF_002(decimal IdVtaActivo = 0)
        {
            VWACTF_002_Rpt model = new VWACTF_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdVtaActivo.Value = IdVtaActivo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdVtaActivo == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult VWACTF_003(decimal IdRetiroActivo = 0)
        {
            VWACTF_003_Rpt model = new VWACTF_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdRetiroActivo.Value = IdRetiroActivo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdRetiroActivo == 0)
                model.RequestParameters = false;
            return View(model);
        }
    }
}