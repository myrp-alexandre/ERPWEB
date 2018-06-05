using Core.Erp.Web.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Reportes.ActivoFijo;

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
        public ActionResult ACTF_004(DateTime fecha_corte, int IdActivoFijoTipo = 0,int  IdCategoriaAF= 0, string Estado_Proceso ="",string IdUsuario="")
        {
            ACTF_004_detalle_Rpt model = new ACTF_004_detalle_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdActivoFijoTipo.Value = IdActivoFijoTipo;
            model.p_IdCategoriaAF.Value = IdCategoriaAF;
            model.p_fecha_corte.Value = fecha_corte;
            model.p_Estado_Proceso.Value = Estado_Proceso;
            model.p_IdUsuario.Value = IdUsuario;

            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdActivoFijoTipo != 0)
            {
                model.p_IdEmpresa.Visible = false;
            }
            else
                model.RequestParameters = false;
            return View(model);
        }
        public ActionResult ACTF_005()
        {
            return View();
        }
    }
}