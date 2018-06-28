using DevExpress.Web.Mvc;
using Core.Erp.Bus.Caja;
using Core.Erp.Info.Caja;
using Core.Erp.Info.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Bus.General;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class ConciliacionCajaController : Controller
    {
        cp_conciliacion_Caja_Bus bus_conciliacion = new cp_conciliacion_Caja_Bus();
        cp_conciliacion_Caja_det_Bus bus_det = new cp_conciliacion_Caja_det_Bus();
        cp_conciliacion_Caja_det_Ing_Caja_Bus bus_ing = new cp_conciliacion_Caja_det_Ing_Caja_Bus();
        cp_conciliacion_Caja_det_x_ValeCaja_Bus bus_vales = new cp_conciliacion_Caja_det_x_ValeCaja_Bus();

        cp_conciliacion_Caja_det_List list_det = new cp_conciliacion_Caja_det_List();
        cp_conciliacion_Caja_det_x_ValeCaja_List list_vale = new cp_conciliacion_Caja_det_x_ValeCaja_List();
        cp_conciliacion_Caja_det_Ing_Caja_List list_ing = new cp_conciliacion_Caja_det_Ing_Caja_List();

        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info();
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {            
            return View(model);
        }

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var lst_periodo = bus_periodo.get_list(IdEmpresa, false);
            ViewBag.lst_periodo = lst_periodo;

            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;
        }

        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha = DateTime.Now.Date,
                IdPeriodo = Convert.ToInt32(DateTime.Now.Date.ToString("yyyyMM")),
                IdEstadoCierre = cl_enumeradores.eEstadoCierreCaja.EST_CIE_ABI.ToString(),
                lst_det_fact = new List<cp_conciliacion_Caja_det_Info>(),
                lst_det_ing = new List<cp_conciliacion_Caja_det_Ing_Caja_Info>(),
                lst_det_vale = new List<cp_conciliacion_Caja_det_x_ValeCaja_Info>()
            };

            list_det.set_list(model.lst_det_fact);
            list_vale.set_list(model.lst_det_vale);
            list_ing.set_list(model.lst_det_ing);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_conciliacion_Caja_Info model)
        {
            if (!bus_conciliacion.guardarDB(model))
            {
                ViewBag.mensaje = "No se ha podido guardar el registro";
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Modificar()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_caja(DateTime fecha_ini, DateTime fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini;
            ViewBag.fecha_fin = fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var model = bus_conciliacion.get_list(IdEmpresa, fecha_ini, fecha_fin);
            return PartialView("_GridViewPartial_conciliacion_caja", model);
        }

        #region Vales
        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_vales(decimal IdConciliacion_caja = 0)
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_vale = bus_vales.get_list(IdEmpresa, IdConciliacion_caja);
            if (model.lst_det_vale.Count == 0)
                model.lst_det_vale = list_vale.get_list();
            return PartialView("_GridViewPartial_conciliacion_vales", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewVale([ModelBinder(typeof(DevExpressEditorsBinder))] cp_conciliacion_Caja_det_x_ValeCaja_Info info_det)
        {
            if (ModelState.IsValid)
                list_vale.AddRow(info_det);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_vale = list_vale.get_list();
            return PartialView("_GridViewPartial_conciliacion_vales", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateVale([ModelBinder(typeof(DevExpressEditorsBinder))] cp_conciliacion_Caja_det_x_ValeCaja_Info info_det)
        {
            if (ModelState.IsValid)
                list_vale.UpdateRow(info_det);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_vale = list_vale.get_list();
            return PartialView("_GridViewPartial_conciliacion_vales", model);
        }

        public ActionResult EditingDeleteVale(int secuencia)
        {
            list_vale.DeleteRow(secuencia);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_vale = list_vale.get_list();
            return PartialView("_GridViewPartial_conciliacion_vales", model);
        }
        #endregion

        public ActionResult ComboBoxPartial_persona(decimal IdPersona = 0)
       {
            var model = bus_persona.get_info(IdPersona);
            if (model == null) model = new Info.General.tb_persona_Info();
            return PartialView("_ComboBoxPartial_persona", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_facturas_x_cruzar()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var model = bus_det.get_list_x_pagar(IdEmpresa);
            return PartialView("_GridViewPartial_conciliacion_facturas_x_cruzar", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_facturas()
        {
            var model = new object[0];
            return PartialView("_GridViewPartial_conciliacion_facturas", model);
        }
    }

    public class cp_conciliacion_Caja_det_List
    {
        public List<cp_conciliacion_Caja_det_Info> get_list()
        {
            if (HttpContext.Current.Session["cp_conciliacion_Caja_det_Info"] == null)
            {
                List<cp_conciliacion_Caja_det_Info> list = new List<cp_conciliacion_Caja_det_Info>();

                HttpContext.Current.Session["cp_conciliacion_Caja_det_Info"] = list;
            }
            return (List<cp_conciliacion_Caja_det_Info>)HttpContext.Current.Session["cp_conciliacion_Caja_det_Info"];
        }

        public void set_list(List<cp_conciliacion_Caja_det_Info> list)
        {
            HttpContext.Current.Session["cp_conciliacion_Caja_det_Info"] = list;
        }

        public void AddRow(cp_conciliacion_Caja_det_Info info_det)
        {
            List<cp_conciliacion_Caja_det_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;            
            list.Add(info_det);
        }

        public void UpdateRow(cp_conciliacion_Caja_det_Info info_det)
        {
            cp_conciliacion_Caja_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();            
        }

        public void DeleteRow(int Secuencia)
        {
            List<cp_conciliacion_Caja_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

    public class cp_conciliacion_Caja_det_Ing_Caja_List
    {
        public List<cp_conciliacion_Caja_det_Ing_Caja_Info> get_list()
        {
            if (HttpContext.Current.Session["cp_conciliacion_Caja_det_Ing_Caja_Info"] == null)
            {
                List<cp_conciliacion_Caja_det_Ing_Caja_Info> list = new List<cp_conciliacion_Caja_det_Ing_Caja_Info>();

                HttpContext.Current.Session["cp_conciliacion_Caja_det_Ing_Caja_Info"] = list;
            }
            return (List<cp_conciliacion_Caja_det_Ing_Caja_Info>)HttpContext.Current.Session["cp_conciliacion_Caja_det_Ing_Caja_Info"];
        }

        public void set_list(List<cp_conciliacion_Caja_det_Ing_Caja_Info> list)
        {
            HttpContext.Current.Session["cp_conciliacion_Caja_det_Ing_Caja_Info"] = list;
        }

        public void AddRow(cp_conciliacion_Caja_det_Ing_Caja_Info info_det)
        {
            List<cp_conciliacion_Caja_det_Ing_Caja_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(cp_conciliacion_Caja_det_Ing_Caja_Info info_det)
        {
            cp_conciliacion_Caja_det_Ing_Caja_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
        }

        public void DeleteRow(int secuencia)
        {
            List<cp_conciliacion_Caja_det_Ing_Caja_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }

    public class cp_conciliacion_Caja_det_x_ValeCaja_List
    {
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public List<cp_conciliacion_Caja_det_x_ValeCaja_Info> get_list()
        {
            if (HttpContext.Current.Session["cp_conciliacion_Caja_det_x_ValeCaja_Info"] == null)
            {
                List<cp_conciliacion_Caja_det_x_ValeCaja_Info> list = new List<cp_conciliacion_Caja_det_x_ValeCaja_Info>();

                HttpContext.Current.Session["cp_conciliacion_Caja_det_x_ValeCaja_Info"] = list;
            }
            return (List<cp_conciliacion_Caja_det_x_ValeCaja_Info>)HttpContext.Current.Session["cp_conciliacion_Caja_det_x_ValeCaja_Info"];
        }

        public void set_list(List<cp_conciliacion_Caja_det_x_ValeCaja_Info> list)
        {
            HttpContext.Current.Session["cp_conciliacion_Caja_det_x_ValeCaja_Info"] = list;
        }

        public void AddRow(cp_conciliacion_Caja_det_x_ValeCaja_Info info_det)
        {
            List<cp_conciliacion_Caja_det_x_ValeCaja_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            var per = bus_persona.get_info(info_det.IdPersona);
            if (per != null)
                info_det.pe_nombreCompleto = per.pe_nombreCompleto;
            list.Add(info_det);
        }

        public void UpdateRow(cp_conciliacion_Caja_det_x_ValeCaja_Info info_det)
        {
            cp_conciliacion_Caja_det_x_ValeCaja_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.valor = info_det.valor;
            edited_info.IdPersona = info_det.IdPersona;
            if (edited_info.IdPersona != info_det.IdPersona)
            {
                var per = bus_persona.get_info(info_det.IdPersona);
                if (per != null)
                    edited_info.pe_nombreCompleto = per.pe_nombreCompleto;
            }            
            edited_info.Observacion = info_det.Observacion;
            edited_info.idTipoMovi = info_det.idTipoMovi;
            edited_info.fecha = info_det.fecha;
        }

        public void DeleteRow(int Secuencia)
        {
            List<cp_conciliacion_Caja_det_x_ValeCaja_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}