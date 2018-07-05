using DevExpress.Web.Mvc;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorCobrar;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaRetencionesController : Controller
    {
        cxc_cobro_Bus bus_cobro = new cxc_cobro_Bus();
        cxc_cobro_det_Bus bus_det = new cxc_cobro_det_Bus();
        cxc_cobro_tipo_Bus bus_cobro_tipo = new cxc_cobro_tipo_Bus();
        cxc_cobro_det_ret_List List_det = new cxc_cobro_det_ret_List();
        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combos();
            return View(model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret( DateTime fecha_ini , DateTime fecha_fin, int IdSucursal = 0)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<cxc_cobro_Info> model = new List<cxc_cobro_Info>();
            model = bus_cobro.get_list_para_retencion(IdEmpresa, IdSucursal, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_cobranza_ret", model);
        }
        #endregion

        #region Aplicar retención
        public ActionResult AplicarRetencion(int IdSucursal = 0, int IdBodega = 0, decimal IdCbteVta = 0, string CodTipoDocumento = "")
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cxc_cobro_Info model = bus_cobro.get_info_para_retencion(IdEmpresa, IdSucursal, IdBodega, IdCbteVta, CodTipoDocumento);
            if (model == null)            
                return RedirectToAction("Index");            
            model.lst_det = bus_det.get_list(IdEmpresa, IdSucursal, IdBodega, IdCbteVta, CodTipoDocumento);
            if (model.lst_det.Count == 0)
            {                
                model.cr_fechaCobro = DateTime.Now.Date;
            }
            else
            {
                model.IdCobro = model.lst_det[0].IdCobro;
                model.cr_fecha = model.lst_det[0].cr_fecha;
                model.cr_NumDocumento = model.lst_det[0].cr_NumDocumento;
            }
            List_det.set_list(model.lst_det);
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret_det()
        {
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                lst_det = List_det.get_list()
            };
            return PartialView("_GridViewPartial_cobranza_ret_det", model);
        }
        #endregion
    }


    public class cxc_cobro_det_ret_List
    {
        public List<cxc_cobro_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cxc_cobro_det_ret"] == null)
            {
                List<cxc_cobro_det_Info> list = new List<cxc_cobro_det_Info>();

                HttpContext.Current.Session["cxc_cobro_det_ret"] = list;
            }
            return (List<cxc_cobro_det_Info>)HttpContext.Current.Session["cxc_cobro_det_ret"];
        }

        public void set_list(List<cxc_cobro_det_Info> list)
        {
            HttpContext.Current.Session["cxc_cobro_det_ret"] = list;
        }

        public void AddRow(cxc_cobro_det_Info info_det)
        {
            List<cxc_cobro_det_Info> list = get_list();
            if (list.Where(q => q.secuencia == info_det.secuencia).FirstOrDefault() == null)
                list.Add(info_det);
        }

        public void UpdateRow(cxc_cobro_det_Info info_det)
        {
            cxc_cobro_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.dc_ValorPago = info_det.dc_ValorPago;
        }

        public void DeleteRow(string secuencia)
        {
            List<cxc_cobro_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}