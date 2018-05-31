using Core.Erp.Web.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Helps;

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

            report.usuario = Session["IdUsuario"].ToString();
            report.empresa = Session["nom_empresa"].ToString();

            if (model.IdProducto == 0)
                report.RequestParameters = false;
            ViewBag.Report = report;
            return View(model);
        }
    }
}