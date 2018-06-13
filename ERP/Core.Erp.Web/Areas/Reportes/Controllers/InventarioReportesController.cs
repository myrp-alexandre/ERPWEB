using Core.Erp.Web.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Inventario;


namespace Core.Erp.Web.Areas.Reportes.Controllers
{
    public class InventarioReportesController : Controller
    {
        public ActionResult INV_001(int IdSucursal =0, int IdMovi_inven_tipo = 0, decimal IdNumMovi = 0)
        {
            INV_001_Rpt model = new INV_001_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdMovi_inven_tipo.Value = IdMovi_inven_tipo;
            model.p_IdNumMovi.Value = IdNumMovi;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdNumMovi == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult INV_002(int IdSucursal = 0, int IdMovi_inven_tipo = 0, decimal IdNumMovi = 0)
        {
            INV_002_Rpt model = new INV_002_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdMovi_inven_tipo.Value = IdMovi_inven_tipo;
            model.p_IdNumMovi.Value = IdNumMovi;
            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdNumMovi == 0)
                model.RequestParameters = false;
            return View(model);
        }

        public ActionResult INV_003(DateTime? fecha_corte, int IdSucursal= 0,int IdBodega= 0,decimal IdProducto =0,string IdCategoria ="",int IdLinea =0,int IdGrupo =0,int IdSubgrupo =0, bool mostrar_stock_0 = false)
        {

            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = IdSucursal,
                IdBodega = IdBodega,
                IdProducto = IdProducto,
                IdCategoria = IdCategoria,
                IdLinea = IdLinea,
                IdGrupo = IdGrupo,
                IdSubGrupo =IdSubgrupo,
                fecha_fin = fecha_corte == null ? DateTime.Now : Convert.ToDateTime(fecha_corte),
                mostrar_registros_0 = mostrar_stock_0
            };

            cargar_combos(model);
            INV_003_Rpt report = new INV_003_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdBodega.Value = model.IdBodega;
            report.p_IdCategoria.Value = model.IdCategoria;
            report.p_IdLinea.Value = model.IdLinea;
            report.p_IdGrupo.Value = model.IdGrupo;
            report.p_IdSubgrupo.Value = model.IdSubGrupo;
            report.p_fecha_corte.Value = model.fecha_fin;
            report.p_mostrar_stock_0.Value = model.mostrar_registros_0;

            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();

            if (IdProducto == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
        [HttpPost]
        public ActionResult INV_003(cl_filtros_Info model)
        {

            INV_003_Rpt report = new INV_003_Rpt();
            report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            report.p_IdSucursal.Value = model.IdSucursal;
            report.p_IdBodega.Value = model.IdBodega;
            report.p_IdCategoria.Value = model.IdCategoria;
            report.p_IdLinea.Value = model.IdLinea;
            report.p_IdGrupo.Value = model.IdGrupo;
            report.p_IdSubgrupo.Value = model.IdSubGrupo;
            report.p_fecha_corte.Value = model.fecha_fin;
            report.p_mostrar_stock_0.Value = model.mostrar_registros_0;
            cargar_combos(model);

            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();

            if (model.IdProducto == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }

        private void cargar_combos(cl_filtros_Info model)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var lst_bodega = bus_bodega.get_list(IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_bodega = lst_bodega;

            in_Producto_Bus bus_producto = new in_Producto_Bus();
            var lst_producto = bus_producto.get_list(IdEmpresa, false);
            ViewBag.lst_producto = lst_producto;

            in_categorias_Bus bus_categoria = new in_categorias_Bus();
            var lst_categoria = bus_categoria.get_list(IdEmpresa, false);
            ViewBag.lst_categoria = lst_categoria;

            in_linea_Bus bus_linea = new in_linea_Bus();
            var lst_linea = bus_linea.get_list(IdEmpresa, model.IdCategoria, false);
            ViewBag.lst_linea = lst_linea;

            in_grupo_Bus bus_grupo = new in_grupo_Bus();
            var lst_grupo = bus_grupo.get_list(IdEmpresa, model.IdCategoria, model.IdLinea, false);
            ViewBag.lst_grupo = lst_grupo;

            in_subgrupo_Bus bus_subgrupo = new in_subgrupo_Bus();
            var lst_subgrupo = bus_subgrupo.get_list(IdEmpresa, model.IdCategoria, model.IdLinea, model.IdGrupo, false);
            ViewBag.lst_subgrupo = lst_subgrupo;
        }

        public ActionResult INV_005(DateTime? fecha_ini, DateTime? fecha_fin, int IdEmpresa = 0, int IdSucursal= 0, int IdBodega = 0, int IdProducto= 0, string IdUsuario = "", bool no_mostrar_valores_en_0 = false, bool mostrar_detallado = false )
        {  cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = IdSucursal,
                IdBodega = IdBodega,
                IdProducto = IdProducto,
                no_mostrar_valores_en_0 = no_mostrar_valores_en_0,
                mostrar_detallado = mostrar_detallado,
                IdUsuario = IdUsuario,
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin)
            };
            
            cargar_combos(model);
            if (mostrar_detallado)
            {
                INV_005_detalle_Rpt model_detalle = new INV_005_detalle_Rpt();
                model_detalle.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_detalle.p_IdSucursal.Value = model.IdSucursal;
                model_detalle.p_IdBodega.Value = model.IdBodega;
                model_detalle.p_IdProducto.Value = model.IdProducto;
                model_detalle.p_IdUsuario.Value = model.IdUsuario;
                model_detalle.p_fecha_ini.Value = model.fecha_ini;
                model_detalle.p_fecha_fin.Value = model.fecha_fin;
                model_detalle.p_mostrar_detallado.Value = model.mostrar_detallado;
                model_detalle.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;

                model_detalle.usuario = Session["IdUsuario"].ToString();
                model_detalle.empresa = Session["nom_empresa"].ToString();
                if (IdProducto != 0)
                {
                    model_detalle.p_IdEmpresa.Visible = false;
                }
                else
                    model_detalle.RequestParameters = false;
                ViewBag.report = model_detalle;
            }
            else
            {
                INV_005_resumen_Rpt model_resumen = new INV_005_resumen_Rpt();
                model_resumen.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_resumen.p_IdSucursal.Value = model.IdSucursal;
                model_resumen.p_IdBodega.Value = model.IdBodega;
                model_resumen.p_IdProducto.Value = model.IdProducto;
                model_resumen.p_IdUsuario.Value = model.IdUsuario;
                model_resumen.p_fecha_ini.Value = model.fecha_ini;
                model_resumen.p_fecha_fin.Value = model.fecha_fin;
                model_resumen.p_mostrar_detallado.Value = model.mostrar_detallado;
                model_resumen.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;

                model_resumen.usuario = Session["IdUsuario"].ToString();
                model_resumen.empresa = Session["nom_empresa"].ToString();
                if (IdProducto != 0)
                {
                    model_resumen.p_IdEmpresa.Visible = false;
                }
                else
                    model_resumen.RequestParameters = false;
                ViewBag.report = model_resumen;
            }

            return View();
        }

        [HttpPost]
        public ActionResult INV_005(cl_filtros_Info model, bool mostrar_detallado = false)
        {
            if (mostrar_detallado)
            {
                INV_005_detalle_Rpt report = new INV_005_detalle_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdSucursal.Value = model.IdSucursal;
                report.p_IdBodega.Value = model.IdBodega;
                report.p_IdProducto.Value = model.IdProducto;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_ini.Value = model.fecha_ini;
                report.p_fecha_fin.Value = model.fecha_fin;
                report.p_mostrar_detallado.Value = model.mostrar_detallado;
                report.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();

                if (model.IdProducto == 0)
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            else
            {
                INV_005_resumen_Rpt report = new INV_005_resumen_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdSucursal.Value = model.IdSucursal;
                report.p_IdBodega.Value = model.IdBodega;
                report.p_IdProducto.Value = model.IdProducto;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_ini.Value = model.fecha_ini;
                report.p_fecha_fin.Value = model.fecha_fin;
                report.p_mostrar_detallado.Value = model.mostrar_detallado;
                report.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();

                if (model.IdProducto == 0)
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            return View(model);
        }

        public ActionResult INV_006(DateTime? fecha_ini, DateTime? fecha_fin, int IdEmpresa = 0, int IdSucursal = 0, int IdBodega = 0, int IdProducto = 0, string IdUsuario = "", bool no_mostrar_valores_en_0 = false, bool mostrar_detallado = false)
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdSucursal = IdSucursal,
                IdBodega = IdBodega,
                IdProducto = IdProducto,
                no_mostrar_valores_en_0 = no_mostrar_valores_en_0,
                mostrar_detallado = mostrar_detallado,
                IdUsuario = IdUsuario,
                fecha_ini = fecha_ini == null ? DateTime.Now : Convert.ToDateTime(fecha_ini),
                fecha_fin = fecha_fin == null ? DateTime.Now : Convert.ToDateTime(fecha_fin)
            };

            cargar_combos(model);
            if (mostrar_detallado)
            {
                INV_006_detalle_Rpt model_detalle = new INV_006_detalle_Rpt();
                model_detalle.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_detalle.p_IdSucursal.Value = model.IdSucursal;
                model_detalle.p_IdBodega.Value = model.IdBodega;
                model_detalle.p_IdProducto.Value = model.IdProducto;
                model_detalle.p_IdUsuario.Value = model.IdUsuario;
                model_detalle.p_fecha_ini.Value = model.fecha_ini;
                model_detalle.p_fecha_fin.Value = model.fecha_fin;
                model_detalle.p_mostrar_detallado.Value = model.mostrar_detallado;
                model_detalle.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;

                model_detalle.usuario = Session["IdUsuario"].ToString();
                model_detalle.empresa = Session["nom_empresa"].ToString();
                if (IdProducto != 0)
                {
                    model_detalle.p_IdEmpresa.Visible = false;
                }
                else
                    model_detalle.RequestParameters = false;
                ViewBag.report = model_detalle;
            }
            else
            {
                INV_006_resumen_Rpt model_resumen = new INV_006_resumen_Rpt();
                model_resumen.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                model_resumen.p_IdSucursal.Value = model.IdSucursal;
                model_resumen.p_IdBodega.Value = model.IdBodega;
                model_resumen.p_IdProducto.Value = model.IdProducto;
                model_resumen.p_IdUsuario.Value = model.IdUsuario;
                model_resumen.p_fecha_ini.Value = model.fecha_ini;
                model_resumen.p_fecha_fin.Value = model.fecha_fin;
                model_resumen.p_mostrar_detallado.Value = model.mostrar_detallado;
                model_resumen.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;

                model_resumen.usuario = Session["IdUsuario"].ToString();
                model_resumen.empresa = Session["nom_empresa"].ToString();
                if (IdProducto != 0)
                {
                    model_resumen.p_IdEmpresa.Visible = false;
                }
                else
                    model_resumen.RequestParameters = false;
                ViewBag.report = model_resumen;
            }

            return View();
        }

        public ActionResult INV_006(cl_filtros_Info model, bool mostrar_detallado = false)
        {
            if (mostrar_detallado)
            {
                INV_006_detalle_Rpt report = new INV_006_detalle_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdSucursal.Value = model.IdSucursal;
                report.p_IdBodega.Value = model.IdBodega;
                report.p_IdProducto.Value = model.IdProducto;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_ini.Value = model.fecha_ini;
                report.p_fecha_fin.Value = model.fecha_fin;
                report.p_mostrar_detallado.Value = model.mostrar_detallado;
                report.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();

                if (model.IdProducto == 0)
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            else
            {
                INV_006_resumen_Rpt report = new INV_006_resumen_Rpt();
                report.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
                report.p_IdSucursal.Value = model.IdSucursal;
                report.p_IdBodega.Value = model.IdBodega;
                report.p_IdProducto.Value = model.IdProducto;
                report.p_IdUsuario.Value = model.IdUsuario;
                report.p_fecha_ini.Value = model.fecha_ini;
                report.p_fecha_fin.Value = model.fecha_fin;
                report.p_mostrar_detallado.Value = model.mostrar_detallado;
                report.p_no_mostrar_valores_en_0.Value = model.no_mostrar_valores_en_0;
                cargar_combos(model);

                report.usuario = Session["IdUsuario"].ToString();
                report.empresa = Session["nom_empresa"].ToString();

                if (model.IdProducto == 0)
                    report.RequestParameters = false;
                ViewBag.Report = report;
            }
            return View(model);
        }
        #region json

        public JsonResult cargar_bodega(int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
            var resultado = bus_bodega.get_list(IdEmpresa, IdSucursal, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult cargar_lineas(string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_linea_Bus bus_linea = new in_linea_Bus();
            var resultado = bus_linea.get_list(IdEmpresa, IdCategoria, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult cargar_grupos(string IdCategoria = "", int IdLinea = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_grupo_Bus bus_grupo = new in_grupo_Bus();
            var resultado = bus_grupo.get_list(IdEmpresa, IdCategoria, IdLinea, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult cargar_subgrupos(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_subgrupo_Bus bus_subgrupo = new in_subgrupo_Bus();
            var resultado = bus_subgrupo.get_list(IdEmpresa, IdCategoria, IdLinea, IdGrupo, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    
        #endregion
    }
}