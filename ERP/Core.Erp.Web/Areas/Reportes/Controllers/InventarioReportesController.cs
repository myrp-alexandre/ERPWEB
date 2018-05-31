using Core.Erp.Web.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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

            INV_003_Rpt model = new INV_003_Rpt();
            model.p_IdEmpresa.Value = Convert.ToInt32(Session["IdEmpresa"]);
            model.p_IdSucursal.Value = IdSucursal;
            model.p_IdBodega.Value = IdBodega;
            model.p_IdCategoria.Value = IdCategoria;
            model.p_IdLinea.Value = IdLinea;
            model.p_IdGrupo.Value = IdGrupo;
            model.p_IdSubgrupo.Value = IdSubgrupo;
            model.p_fecha_corte.Value = fecha_corte == null ? DateTime.Now : fecha_corte;
            model.p_mostrar_stock_0.Value = mostrar_stock_0;


            model.usuario = Session["IdUsuario"].ToString();
            model.empresa = Session["nom_empresa"].ToString();
            if (IdProducto == 0)
                model.RequestParameters = false;
            return View(model);
        }

    }
}