using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.Helps;


namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class ComprobanteContableController : Controller
    {
        ct_cbtecble_Bus bus_comprobante = new ct_cbtecble_Bus();
        ct_cbtecble_det_Bus bus_comprobante_detalle = new ct_cbtecble_det_Bus();
        ct_cbtecble_det_List list_ct_cbtecble_det = new ct_cbtecble_det_List();
        string mensaje = string.Empty;
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

        private bool validar(ct_cbtecble_Info i_validar, ref string msg)
        {
            if (i_validar.lst_ct_cbtecble_det.Count == 0)
            {
                mensaje = "Debe ingresar registros en el detalle";
                return false;
            }

            if(i_validar.lst_ct_cbtecble_det.Sum(q => q.dc_Valor) != 0)
            {
                mensaje = "La suma de los detalles debe ser 0";
                return false;
            }

            if (i_validar.lst_ct_cbtecble_det.Where(q=>q.dc_Valor == 0).Count() > 0)
            {
                mensaje = "Existen detalles con valor 0 en el debe o haber";
                return false;
            }

            return true;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprobante_contable(DateTime? fecha_ini, DateTime? fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<ct_cbtecble_Info> model = bus_comprobante.get_list(IdEmpresa, true, ViewBag.fecha_ini, ViewBag.fecha_fin);
            return PartialView("_GridViewPartial_comprobante_contable", model);
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
            var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
            ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;

        }

        public ActionResult Nuevo()
        {
            ct_cbtecble_Info model = new ct_cbtecble_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                cb_Fecha = DateTime.Now,
                IdTipoCbte = 1
            };
            model.lst_ct_cbtecble_det = new List<ct_cbtecble_det_Info>();
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);
            cargar_combos();
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ct_cbtecble_Info model)
        {
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            if (!validar(model,ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_comprobante.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdTipoCbte, decimal IdCbteCble)
        {   
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = bus_comprobante.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ct_cbtecble_Info model)
        {
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            if (!validar(model, ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuarioUltModi = Session["IdUsuario"].ToString();            
            if (!bus_comprobante.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        public ActionResult Anular(int IdTipoCbte, decimal IdCbteCble)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = bus_comprobante.get_info(IdEmpresa, IdTipoCbte, IdCbteCble);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            list_ct_cbtecble_det.set_list(model.lst_ct_cbtecble_det);
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_cbtecble_Info model)
        {
            model.IdUsuarioAnu = Session["IdUsuario"].ToString();
            if (!bus_comprobante.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_comprobante_detalle(int IdTipoCbte = 0, decimal IdCbteCble = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = bus_comprobante_detalle.get_list(IdEmpresa, IdTipoCbte, IdCbteCble);
            if (model.lst_ct_cbtecble_det.Count == 0)
                model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuentas = bus_cuenta.get_list(IdEmpresa, false , true);
            ViewBag.lst_cuentas = lst_cuentas;
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_ct_cbtecble_det.AddRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ct_cbtecble_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_ct_cbtecble_det.UpdateRow(info_det);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            list_ct_cbtecble_det.DeleteRow(secuencia);
            ct_cbtecble_Info model = new ct_cbtecble_Info();
            model.lst_ct_cbtecble_det = list_ct_cbtecble_det.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_comprobante_detalle", model);
        }
    }
    
public class ct_cbtecble_det_List
    {
        public List<ct_cbtecble_det_Info> get_list()
        {
            if (HttpContext.Current.Session["ct_cbtecble_det_Info"] == null)
            {
                List<ct_cbtecble_det_Info> list = new List<ct_cbtecble_det_Info>();

                HttpContext.Current.Session["ct_cbtecble_det_Info"] = list;
            }
            return (List<ct_cbtecble_det_Info>)HttpContext.Current.Session["ct_cbtecble_det_Info"];
        }

        public void set_list(List<ct_cbtecble_det_Info> list)
        {
            HttpContext.Current.Session["ct_cbtecble_det_Info"] = list;
        }

        public void AddRow(ct_cbtecble_det_Info info_det)
        {
            List<ct_cbtecble_det_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia) + 1;
            info_det.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * -1;
            list.Add(info_det);
        }

        public void UpdateRow(ct_cbtecble_det_Info info_det)
        {
            ct_cbtecble_det_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.dc_para_conciliar = info_det.dc_para_conciliar;
            edited_info.dc_Valor = info_det.dc_Valor_debe > 0 ? info_det.dc_Valor_debe : info_det.dc_Valor_haber * - 1;
            edited_info.dc_Valor_debe = info_det.dc_Valor_debe;
            edited_info.dc_Valor_haber = info_det.dc_Valor_haber;
        }

        public void DeleteRow(int secuencia)
        {
            List<ct_cbtecble_det_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}