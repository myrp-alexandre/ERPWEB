using Core.Erp.Web.Reportes.ActivoFijo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Reportes.ActivoFijo;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.ActivoFijo;

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
        public ActionResult ACTF_004(DateTime fecha_corte, int IdActivoFijoTipo = 0,int  IdCategoriaAF= 0, string Estado_Proceso ="",string IdUsuario="", bool  mostrar_detallado = false)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdActivoFijoTipo = IdActivoFijoTipo,
                IdCategoriaAF = IdCategoriaAF,
                Estado_Proceso = Estado_Proceso,
                IdUsuario = IdUsuario,
                fecha_fin = fecha_corte == null ? DateTime.Now : Convert.ToDateTime(fecha_corte),
            };


            if (mostrar_detallado)
            {
                ACTF_004_detalle_Rpt model_detalle = new ACTF_004_detalle_Rpt();
                model_detalle.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_detalle.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                model_detalle.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                model_detalle.p_fecha_corte.Value = model.fecha_fin;
                model_detalle.p_Estado_Proceso.Value = model.Estado_Proceso;
                model_detalle.p_IdUsuario.Value = model.IdUsuario;

                model_detalle.usuario = Session["IdUsuario"].ToString();
                model_detalle.empresa = Session["nom_empresa"].ToString();
                if (IdActivoFijoTipo != 0)
                {
                    model_detalle.p_IdEmpresa.Visible = false;
                }
                else
                    model_detalle.RequestParameters = false;
                ViewBag.report = model_detalle;
            }
            else
            {
                ACTF_004_resumen_Rpt model_resumen = new ACTF_004_resumen_Rpt();
                model_resumen.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_resumen.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                model_resumen.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                model_resumen.p_fecha_corte.Value = model.fecha_fin;
                model_resumen.p_Estado_Proceso.Value = model.Estado_Proceso;
                model_resumen.p_IdUsuario.Value = model.IdUsuario;

                model_resumen.usuario = Session["IdUsuario"].ToString();
                model_resumen.empresa = Session["nom_empresa"].ToString();
                if (IdActivoFijoTipo != 0)
                {
                    model_resumen.p_IdEmpresa.Visible = false;
                }
                else
                    model_resumen.RequestParameters = false;
                ViewBag.report = model_resumen;
            }
            cargar_combos(model);
            return View();
        }
        [HttpPost]
        public ActionResult ACTF_004(cl_filtros_Info model, bool mostrar_detallado = false)
        {
           if(mostrar_detallado)
            {
                ACTF_004_detalle_Rpt report = new ACTF_004_detalle_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                report.p_Estado_Proceso.Value = model.Estado_Proceso;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_corte.Value = model.fecha_fin;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            else
            {
                ACTF_004_resumen_Rpt report = new ACTF_004_resumen_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                report.p_Estado_Proceso.Value = model.Estado_Proceso;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_corte.Value = model.fecha_fin;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            return View(model);
        }

        private void cargar_combos(cl_filtros_Info model)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, model.IdActivoFijoTipo, false);
            ViewBag.lst_categoria = lst_categoria;

            Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
            var lst_estado = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_ESTADO_AF), false);
            ViewBag.lst_estado = lst_estado;

        }
        public ActionResult ACTF_005(DateTime fecha_corte, int IdActivoFijoTipo = 0, int IdCategoriaAF = 0, string Estado_Proceso = "")
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdActivoFijoTipo = IdActivoFijoTipo,
                IdCategoriaAF = IdCategoriaAF,
                Estado_Proceso = Estado_Proceso,
                fecha_fin = fecha_corte == null ? DateTime.Now : Convert.ToDateTime(fecha_corte),
            };

            ACTF_005_Rpt report = new ACTF_005_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
            report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
            report.p_fecha_corte.Value = model.fecha_fin;
            report.p_Estado_Proceso.Value = model.Estado_Proceso;

            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
            if (IdActivoFijoTipo != 0)
            {
                report.p_IdEmpresa.Visible = false;
            }
            else
                report.RequestParameters = false;
            ViewBag.Report = report;
            cargar_combos(model);
            return View();
        }
        [HttpPost]
        public ActionResult ACTF_005(cl_filtros_Info model)
        {
            ACTF_005_Rpt report = new ACTF_005_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
            report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
            report.p_Estado_Proceso.Value = model.Estado_Proceso;
            report.p_fecha_corte.Value = model.fecha_fin;
            cargar_combos(model);

            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View();
        }
    }
}