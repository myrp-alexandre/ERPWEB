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
using Core.Erp.Web.Areas.Contabilidad.Controllers;
using Core.Erp.Info.General;
using DevExpress.Web;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Caja.Controllers
{
    public class ConciliacionCajaController : Controller
    {
        #region Variables
        cp_conciliacion_Caja_Bus bus_conciliacion = new cp_conciliacion_Caja_Bus();
        cp_conciliacion_Caja_det_Bus bus_det = new cp_conciliacion_Caja_det_Bus();
        cp_conciliacion_Caja_det_Ing_Caja_Bus bus_ing = new cp_conciliacion_Caja_det_Ing_Caja_Bus();
        cp_conciliacion_Caja_det_x_ValeCaja_Bus bus_vales = new cp_conciliacion_Caja_det_x_ValeCaja_Bus();

        cp_conciliacion_Caja_det_List list_det = new cp_conciliacion_Caja_det_List();
        cp_conciliacion_Caja_det_x_ValeCaja_List list_vale = new cp_conciliacion_Caja_det_x_ValeCaja_List();
        cp_conciliacion_Caja_det_Ing_Caja_List list_ing = new cp_conciliacion_Caja_det_Ing_Caja_List();
        ct_cbtecble_det_List list_ct = new ct_cbtecble_det_List();  
        
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        caj_Caja_Bus bus_caja = new caj_Caja_Bus();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        string mensaje = string.Empty;
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbPersona_ConciliacionCaja()
        {
            SessionFixed.TipoPersona = Request.Params["IdTipoPersona"] != null ? Request.Params["IdTipoPersona"].ToString() : "PERSONA";
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            return PartialView("_CmbPersona_ConciliacionCaja", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), SessionFixed.TipoPersona);
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), SessionFixed.TipoPersona);
        }
        #endregion

        #region Acciones
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
        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info
            {
                IdEmpresa = IdEmpresa,
                Fecha = DateTime.Now.Date,
                IdPeriodo = Convert.ToInt32(DateTime.Now.Date.ToString("yyyyMM")),
                Fecha_ini = DateTime.Now,
                Fecha_fin = DateTime.Now,
                FechaOP = DateTime.Now,
                IdEstadoCierre = cl_enumeradores.eEstadoCierreCaja.EST_CIE_ABI.ToString(),
                lst_det_fact = new List<cp_conciliacion_Caja_det_Info>(),
                lst_det_ing = new List<cp_conciliacion_Caja_det_Ing_Caja_Info>(),
                lst_det_vale = new List<cp_conciliacion_Caja_det_x_ValeCaja_Info>(),
                lst_det_ct = new List<ct_cbtecble_det_Info>()
            };

            list_det.set_list(model.lst_det_fact);
            list_vale.set_list(model.lst_det_vale);
            list_ing.set_list(model.lst_det_ing);
            list_ct.set_list(model.lst_det_ct);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(cp_conciliacion_Caja_Info model)
        {
            
            if (!validar(model,ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos();
                return View(model);
            }
            model.lst_det_fact = list_det.get_list();
            model.lst_det_ing = list_ing.get_list();
            model.lst_det_vale = list_vale.get_list();

            if (!bus_conciliacion.guardarDB(model))
            {
                ViewBag.mensaje = "No se ha podido guardar el registro";
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Modificar()
        {
            return View();
        }
        #endregion

        #region Metodos
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_periodo = bus_periodo.get_list(IdEmpresa, false);
            ViewBag.lst_periodo = lst_periodo;

            var lst_caja = bus_caja.get_list(IdEmpresa, false);
            ViewBag.lst_caja = lst_caja;

            Dictionary<string, string> lst = new Dictionary<string, string>();
            lst.Add(cl_enumeradores.eEstadoCierreCaja.EST_CIE_ABI.ToString(), "ABIERTA");
            lst.Add(cl_enumeradores.eEstadoCierreCaja.EST_CIE_CER.ToString(), "CERRADA");
            ViewBag.lst_estado = lst;

            Dictionary<string, string> lst_tipo_personas = new Dictionary<string, string>();
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PERSONA.ToString(), "Persona");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.PROVEE.ToString(), "Proveedor");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.EMPLEA.ToString(), "Empleado");
            lst_tipo_personas.Add(cl_enumeradores.eTipoPersona.CLIENTE.ToString(), "Cliente");
            ViewBag.lst_tipo_personas = lst_tipo_personas;
        }

        private bool validar(cp_conciliacion_Caja_Info i_validar, ref string msg)
        {
            i_validar.lst_det_ct = list_ct.get_list();

            if (i_validar.IdEstadoCierre == cl_enumeradores.eEstadoCierreCaja.EST_CIE_CER.ToString())
            {
                if (i_validar.lst_det_ct.Count == 0)
                {
                    msg = "Debe ingresar registros en el detalle del diario";
                    return false;
                }
                if (i_validar.lst_det_ct.Sum(q => q.dc_Valor) != 0)
                {
                    msg = "La suma del detalle del diario debe ser 0";
                    return false;
                }

                if (i_validar.lst_det_ct.Where(q => q.dc_Valor == 0).Count() > 0)
                {
                    msg = "Existen detalles con valor 0 en el debe o haber";
                    return false;
                }
                var persona = bus_persona.get_info(i_validar.IdEmpresa, i_validar.IdTipoPersona, i_validar.IdEntidad);
                if (persona == null)
                {
                    msg = "La persona seleccionada no corresponde al tipo asignado";
                    return false;
                }
                i_validar.IdPersona = persona.IdPersona;
                i_validar.lst_det_fact = list_det.get_list();

                
            }

            return true;
        }
        #endregion

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_caja(DateTime fecha_ini, DateTime fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini;
            ViewBag.fecha_fin = fecha_fin;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_conciliacion.get_list(IdEmpresa, fecha_ini, fecha_fin);
            return PartialView("_GridViewPartial_conciliacion_caja", model);
        }

        #region Vales
        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_vales(decimal IdConciliacion_caja = 0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
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

        #region Facturas
        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_facturas_x_cruzar()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_det.get_list_x_pagar(IdEmpresa);
            return PartialView("_GridViewPartial_conciliacion_facturas_x_cruzar", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_facturas(decimal IdConciliacion_caja = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_fact = bus_det.get_list(IdEmpresa, IdConciliacion_caja);
            if (model.lst_det_fact.Count == 0)
                model.lst_det_fact = list_det.get_list();
            return PartialView("_GridViewPartial_conciliacion_facturas", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNewFactura(string IDs = "")
        {
            if (IDs != "")
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                var lst_x_cruzar = bus_det.get_list_x_pagar(IdEmpresa);
                string[] array = IDs.Split(',');
                foreach (var item in array)
                {
                    var info_det = lst_x_cruzar.Where(q => q.IdCbteCble_Ogiro == Convert.ToInt32(item)).FirstOrDefault();
                    if(info_det != null)
                        list_det.AddRow(info_det);
                }
            }
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_fact = list_det.get_list();
            return PartialView("_GridViewPartial_conciliacion_facturas", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdateFactura([ModelBinder(typeof(DevExpressEditorsBinder))] cp_conciliacion_Caja_det_Info info_det)
        {
            if (ModelState.IsValid)
                list_det.UpdateRow(info_det);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_fact = list_det.get_list();
            return PartialView("_GridViewPartial_conciliacion_facturas", model);
        }

        public ActionResult EditingDeleteFactura(int secuencia)
        {
            list_det.DeleteRow(secuencia);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_fact = list_det.get_list();
            return PartialView("_GridViewPartial_conciliacion_facturas", model);
        }
        #endregion

        #region Json
        public JsonResult GetSaldoAnterior(DateTime? FechaCorte, string IdCtaCble = "")
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            double resultado = 0;
            if(FechaCorte != null)
                resultado = bus_plancta.get_saldo_anterior(IdEmpresa, IdCtaCble, Convert.ToDateTime(FechaCorte));

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetIdCtaCbleCaja(int IdCaja = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            string resultado = string.Empty;
            if (IdCaja != 0)
                resultado = bus_caja.get_IdCtaCble(IdEmpresa, IdCaja);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPeriodo(int IdPeriodo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var resultado = bus_periodo.get_info(IdEmpresa, IdPeriodo);
            if (resultado == null)
                resultado = new ct_periodo_Info();
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Calcular(double SaldoContableAnterior = 0)
        {
            var lst_ing = list_ing.get_list();
            var lst_vale = list_vale.get_list();
            var lst_fact = list_det.get_list();

            var ingresos = lst_ing.Sum(q => q.Saldo);
            var egresos = Convert.ToDouble(lst_fact.Count == 0 ? 0 : lst_fact.Sum(q => q.Valor_a_aplicar)) + Convert.ToDouble(lst_vale.Count == 0 ? 0 : lst_vale.Sum(q => q.valor));
            var resultado = new cp_conciliacion_valores
            {
                Ingresos = Math.Round(ingresos, 2, MidpointRounding.AwayFromZero),
                Dif_ingresos = Math.Round(Math.Abs(SaldoContableAnterior) - ingresos, 2, MidpointRounding.AwayFromZero),
                Fondo = Math.Round(ingresos, 2, MidpointRounding.AwayFromZero),
                Total_fact_vales = Math.Round(egresos, 2, MidpointRounding.AwayFromZero),
                Diferencia = Math.Round(ingresos - egresos, 2, MidpointRounding.AwayFromZero)
            };
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public void armar_diario(string IdCtaCble = "")
        {
            var lst_vale = list_vale.get_list();
            var lst_fact = list_det.get_list();
            var valor = Convert.ToDouble(lst_fact.Count == 0 ? 0 : lst_fact.Sum(q => q.Valor_a_aplicar)) + Convert.ToDouble(lst_vale.Count == 0 ? 0 : lst_vale.Sum(q => q.valor));

            List<ct_cbtecble_det_Info> lst_det = new List<ct_cbtecble_det_Info>
            {
               //Debe
                new ct_cbtecble_det_Info
                {
                    IdCtaCble = IdCtaCble,
                    dc_Valor = Math.Abs(valor),
                    dc_Valor_debe = Math.Abs(valor),
                    secuencia = 1

                },
                //Haber
                new ct_cbtecble_det_Info
                {
                    IdCtaCble = IdCtaCble,
                    dc_Valor = Math.Abs(valor)*-1,
                    dc_Valor_haber = Math.Abs(valor),
                    secuencia = 2
                }
            };
            list_ct.set_list(lst_det);
        }
        #endregion

        #region Ingresos
        [ValidateInput(false)]
        public ActionResult GridViewPartial_conciliacion_ingresos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cp_conciliacion_Caja_Info model = new cp_conciliacion_Caja_Info();
            model.lst_det_ing = list_ing.get_list();
            return PartialView("_GridViewPartial_conciliacion_ingresos", model);
        }
        public void GetIngresos(DateTime? FechaFin, int IdCaja = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst = bus_ing.get_list_ingresos_x_conciliar(IdEmpresa, FechaFin == null ? DateTime.Now.Date : Convert.ToDateTime(FechaFin), IdCaja);
            list_ing.set_list(lst);
        }
        #endregion        
    }

    public class cp_conciliacion_valores
    {
        public double Ingresos { get; set; }
        public double Dif_ingresos { get; set; }
        public double Fondo { get; set; }
        public double Total_fact_vales { get; set; }
        public double Diferencia { get; set; }
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
            if (list.Where(q=>q.IdEmpresa_OGiro == info_det.IdEmpresa_OGiro && q.IdTipoCbte_Ogiro == info_det.IdTipoCbte_Ogiro && q.IdCbteCble_Ogiro == info_det.IdCbteCble_Ogiro).Count() == 0)
                list.Add(info_det);
        }

        public void UpdateRow(cp_conciliacion_Caja_det_Info info_det)
        {
            cp_conciliacion_Caja_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.Valor_a_aplicar = info_det.Valor_a_aplicar;
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