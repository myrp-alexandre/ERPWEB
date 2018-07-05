using DevExpress.Web.Mvc;
using Core.Erp.Info.CuentasPorCobrar;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.CuentasPorCobrar;

namespace Core.Erp.Web.Areas.CuentasPorCobrar.Controllers
{
    public class CobranzaRetencionesController : Controller
    {
        cxc_cobro_Bus bus_cobro = new cxc_cobro_Bus();
        cxc_cobro_det_Bus bus_det = new cxc_cobro_det_Bus();
        cxc_cobro_tipo_Bus bus_cobro_tipo = new cxc_cobro_tipo_Bus();
        #region Index
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret", model);
        }
        #endregion

        #region Aplicar retención
        public ActionResult AplicarRetencion(int IdSucursal = 0, int IdBodega = 0, decimal IdCbteVta = 0, string CodTipoDocumento = "")
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cxc_cobro_Info model = new cxc_cobro_Info
            {
                
            };
            
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret_fte()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret_fte", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cobranza_ret_iva()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_cobranza_ret_iva", model);
        }
        #endregion
    }


    public class cxc_cobro_det_ret_fte_List
    {
        public List<cxc_cobro_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cxc_cobro_det_ret_fte"] == null)
            {
                List<cxc_cobro_det_Info> list = new List<cxc_cobro_det_Info>();

                HttpContext.Current.Session["cxc_cobro_det_ret_fte"] = list;
            }
            return (List<cxc_cobro_det_Info>)HttpContext.Current.Session["cxc_cobro_det_ret_fte"];
        }

        public void set_list(List<cxc_cobro_det_Info> list)
        {
            HttpContext.Current.Session["cxc_cobro_det_ret_fte"] = list;
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

    public class cxc_cobro_det_ret_iva_List
    {
        public List<cxc_cobro_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cxc_cobro_det_ret_iva"] == null)
            {
                List<cxc_cobro_det_Info> list = new List<cxc_cobro_det_Info>();

                HttpContext.Current.Session["cxc_cobro_det_ret_iva"] = list;
            }
            return (List<cxc_cobro_det_Info>)HttpContext.Current.Session["cxc_cobro_det_ret_iva"];
        }

        public void set_list(List<cxc_cobro_det_Info> list)
        {
            HttpContext.Current.Session["cxc_cobro_det_ret_iva"] = list;
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