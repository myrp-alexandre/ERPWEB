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
        public ActionResult ACTF_001(decimal Id_Mejora_Baja_Activo = 0, string Id_Tipo = "" )
        {
            ACTF_001_Rpt model = new ACTF_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_Id_Mejora_Baja_Activo.Value = Id_Mejora_Baja_Activo;
            model.p_Id_Tipo.Value = Id_Tipo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (Id_Mejora_Baja_Activo != 0)
            {
                model.p_IdEmpresa.Visible = false;
                model.p_Id_Mejora_Baja_Activo.Visible = false;
                model.p_Id_Tipo.Visible = false;
            }
            else
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult ACTF_002(decimal IdVtaActivo = 0)
        {
            ACTF_002_Rpt model = new ACTF_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdVtaActivo.Value = IdVtaActivo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdVtaActivo != 0)
            {
                model.p_IdEmpresa.Visible = false;
                model.p_IdVtaActivo.Visible = false;
            }
            else
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult ACTF_003(decimal IdRetiroActivo = 0)
        {
            ACTF_003_Rpt model = new ACTF_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdRetiroActivo.Value = IdRetiroActivo;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdRetiroActivo != 0)
            {
                model.p_IdEmpresa.Visible = false;
                model.p_IdRetiroActivo.Visible = false;
            }
            else
                model.RequestParameters = false;
            return View(model);

        }

    }
}