using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using Core.Erp.Web.Reportes.ActivoFijo;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    [SessionTimeout]
    public class ActivoFijoReportesController : Controller
    {
        Af_Activo_fijo_Bus bus_activo = new Af_Activo_fijo_Bus();
        public ActionResult CmbActivo_fijo()
        {
            int model = new int();
            return PartialView("_CmbActivo_fijo", model);
        }

        public List<Af_Activo_fijo_Info> get_list_bajo_demanda_af(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_activo.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }

        public Af_Activo_fijo_Info get_info_bajo_demanda_af(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_activo.get_info_bajo_demanda(Convert.ToInt32(SessionFixed.IdEmpresa), args);
        }

        #region Json
        public JsonResult cargar_categoria(int IdEmpresa = 0 , int IdActivoFijoTipo = 0)
        {
            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var resultado = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            resultado.Add(new Af_Activo_fijo_Categoria_Info
            {
                IdEmpresa = IdEmpresa,
                IdCategoriaAF = 0,
                Descripcion = "Todos"
            });
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
        public ActionResult ACTF_001(decimal Id_Mejora_Baja_Activo = 0, string Id_Tipo = "" )
        {
            ACTF_001_Rpt model = new ACTF_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_Id_Mejora_Baja_Activo.Value = Id_Mejora_Baja_Activo;
            model.p_Id_Tipo.Value = Id_Tipo;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult ACTF_002(decimal IdVtaActivo = 0)
        {
            ACTF_002_Rpt model = new ACTF_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdVtaActivo.Value = IdVtaActivo;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);
        }
        public ActionResult ACTF_003(decimal IdRetiroActivo = 0)
        {
            ACTF_003_Rpt model = new ACTF_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdRetiroActivo.Value = IdRetiroActivo;
            model.usuario = SessionFixed.IdUsuario.ToString();
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);

        }
        public ActionResult ACTF_004()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Estado_Proceso = ""
            };

            if (model.mostrar_agrupado)
            {
                ACTF_004_detalle_Rpt model_detalle = new ACTF_004_detalle_Rpt();
                model_detalle.p_IdEmpresa.Value = model.IdEmpresa;
                model_detalle.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                model_detalle.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                model_detalle.p_fecha_corte.Value = model.fecha_fin;
                model_detalle.p_Estado_Proceso.Value = model.Estado_Proceso;
                model_detalle.p_IdUsuario.Value = SessionFixed.IdUsuario;
                cargar_combos(model);

                model_detalle.usuario = SessionFixed.IdUsuario;
                model_detalle.empresa = SessionFixed.NomEmpresa;
                ViewBag.report = model_detalle;
            }
            else
            {
                ACTF_004_resumen_Rpt model_resumen = new ACTF_004_resumen_Rpt();
                model_resumen.p_IdEmpresa.Value = model.IdEmpresa;
                model_resumen.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                model_resumen.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                model_resumen.p_fecha_corte.Value = model.fecha_fin;
                model_resumen.p_Estado_Proceso.Value = model.Estado_Proceso;
                model_resumen.p_IdUsuario.Value = SessionFixed.IdUsuario;
                cargar_combos(model);

                model_resumen.usuario = SessionFixed.IdUsuario;
                model_resumen.empresa = SessionFixed.NomEmpresa;
                ViewBag.report = model_resumen;
            }
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult ACTF_004(cl_filtros_Info model)
        {

            if (model.mostrar_agrupado)
            {
                ACTF_004_detalle_Rpt report = new ACTF_004_detalle_Rpt();
                report.p_IdEmpresa.Value = model.IdEmpresa;
                report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                report.p_Estado_Proceso.Value = model.Estado_Proceso;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_corte.Value = model.fecha_fin;
                report.usuario = SessionFixed.IdUsuario.ToString();
                report.empresa = SessionFixed.NomEmpresa.ToString();
                cargar_combos(model);
                ViewBag.Report = report;
            }
            else
            {
                ACTF_004_resumen_Rpt report = new ACTF_004_resumen_Rpt();
                report.p_IdEmpresa.Value = model.IdEmpresa;
                report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
                report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
                report.p_Estado_Proceso.Value = model.Estado_Proceso;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_corte.Value = model.fecha_fin;
                report.usuario = SessionFixed.IdUsuario.ToString();
                report.empresa = SessionFixed.NomEmpresa.ToString();
                cargar_combos(model);
                ViewBag.Report = report;
            }
            return View(model);
        }
        private void cargar_combos(cl_filtros_Info model)
        {

            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var lst_categoria = bus_categoria.get_list(model.IdEmpresa, model.IdActivoFijoTipo, false);
            lst_categoria.Add(new Af_Activo_fijo_Categoria_Info
            {
                IdEmpresa = model.IdEmpresa,
                IdCategoriaAF = 0,
                Descripcion = "Todos"
            });
            ViewBag.lst_categoria = lst_categoria;

            Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
            var lst_estado = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_ESTADO_AF), false);
            lst_estado.Add(new Af_Catalogo_Info
            {
                IdCatalogo = "",
                Descripcion = "Todos"
            });
            ViewBag.lst_estado = lst_estado;
            
            Af_Activo_fijo_tipo_Bus bus_activo = new Af_Activo_fijo_tipo_Bus();
            var lst_activo = bus_activo.get_list(model.IdEmpresa, false);
            lst_activo.Add(new Af_Activo_fijo_tipo_Info
            {
                IdEmpresa = model.IdEmpresa,
                IdActivoFijoTipo = 0,
                Af_Descripcion = "Todos"
            });
            ViewBag.lst_activo = lst_activo;

            Af_Activo_fijo_Bus bus_act = new Af_Activo_fijo_Bus();
            var lst_act = bus_act.get_list(model.IdEmpresa, false);
            lst_act.Add(new Af_Activo_fijo_Info
            {
                IdEmpresa = model.IdEmpresa,
                IdActivoFijo = 0,
                Af_Nombre = "Todos"
            });
            ViewBag.lst_act = lst_act;

        }
        public ActionResult ACTF_005()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Estado_Proceso = ""

            };
            ACTF_005_Rpt report = new ACTF_005_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
            report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
            report.p_fecha_corte.Value = model.fecha_fin;
            report.p_Estado_Proceso.Value = model.Estado_Proceso;
            report.usuario = SessionFixed.IdUsuario.ToString();
            report.empresa = SessionFixed.NomEmpresa.ToString();
            ViewBag.Report = report;
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult ACTF_005(cl_filtros_Info model)
        {
            ACTF_005_Rpt report = new ACTF_005_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdActivoFijoTipo.Value = model.IdActivoFijoTipo;
            report.p_IdCategoriaAF.Value = model.IdCategoriaAF;
            report.p_Estado_Proceso.Value = model.Estado_Proceso;
            report.p_fecha_corte.Value = model.fecha_fin;
            cargar_combos(model);
            report.usuario = SessionFixed.IdUsuario.ToString();
            report.empresa = SessionFixed.NomEmpresa.ToString();
            ViewBag.Report = report;
            return View(model);
        }

        public ActionResult ACTF_006()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdActivoFijo = 0
            };
            ACTF_006_Rpt report = new ACTF_006_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdActivoFijo.Value = model.IdActivoFijo;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult ACTF_006(cl_filtros_Info model)
        {
            ACTF_006_Rpt report = new ACTF_006_Rpt();
            report.p_IdEmpresa.Value = model.IdEmpresa;
            report.p_IdActivoFijo.Value = model.IdActivoFijo;
            ViewBag.Report = report;
            return View(model);
        }
        public ActionResult ACTF_007(int IdActivoFijo = 0)
        {
            ACTF_007_Rpt model = new ACTF_007_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.p_IdActivoFijo.Value = IdActivoFijo;
            model.empresa = SessionFixed.NomEmpresa.ToString();
            return View(model);

        }
    }
}