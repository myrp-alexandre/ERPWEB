using Core.Erp.Bus.Banco;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Banco;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    [SessionTimeout]
    public class ConciliacionBancoController : Controller
    {
        #region Variables
        ba_Conciliacion_Bus bus_conciliacion = new ba_Conciliacion_Bus();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        ba_Banco_Cuenta_Bus bus_banco_cuenta = new ba_Banco_Cuenta_Bus();
        ba_Conciliacion_det_IngEgr_Bus bus_det = new ba_Conciliacion_det_IngEgr_Bus();
        ba_Conciliacion_det_IngEgr_List List_det = new ba_Conciliacion_det_IngEgr_List();
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        string mensaje = string.Empty;
        #endregion

        #region Index
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
        public ActionResult GridViewPartial_ConciliacionBanco(DateTime? Fecha_ini, DateTime? Fecha_fin)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini).Date;
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin).Date;
            var model = bus_conciliacion.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_ConciliacionBanco", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa)
        {
            var lst_periodo = bus_periodo.get_list(IdEmpresa, false);
            ViewBag.lst_periodo = lst_periodo;

            var lst_banco_cuenta = bus_banco_cuenta.get_list(IdEmpresa, false);
            ViewBag.lst_banco_cuenta = lst_banco_cuenta;

            Dictionary<string, string> lst_estado = new Dictionary<string, string>();
            lst_estado.Add(cl_enumeradores.eEstadoCierreBanco.PRE_CONCIL.ToString(), "PRE-CONCILIADO");
            lst_estado.Add(cl_enumeradores.eEstadoCierreBanco.CONCILIADO.ToString(), "CONCILIADO");
            ViewBag.lst_estado = lst_estado;
        }
        private bool validar(ba_Conciliacion_Info i_validar, ref string msg)
        {
            i_validar.co_totalIng = Math.Round(List_det.get_list().Where(q => q.tipo_IngEgr == "+" && q.seleccionado == true).Sum(q => q.dc_Valor), 2, MidpointRounding.AwayFromZero);
            i_validar.co_totalEgr = Math.Round(List_det.get_list().Where(q => q.tipo_IngEgr == "-" && q.seleccionado == true).Sum(q => q.dc_Valor), 2, MidpointRounding.AwayFromZero);
            i_validar.co_SaldoConciliado = Math.Round(i_validar.co_SaldoBanco_anterior + i_validar.co_totalIng + i_validar.co_totalEgr, 2, MidpointRounding.AwayFromZero);
            i_validar.co_Diferencia = Math.Round(i_validar.co_SaldoConciliado - i_validar.co_SaldoBanco_EstCta, 2, MidpointRounding.AwayFromZero);

            if (i_validar.IdEstado_Concil_Cat == cl_enumeradores.eEstadoCierreBanco.CONCILIADO.ToString() && i_validar.co_Diferencia != 0)
            {
                msg = "No se puede asignar el estado de conciliado si la diferencia es diferente a 0";
                return false;
            }

            if (i_validar.IdEstado_Concil_Cat == cl_enumeradores.eEstadoCierreBanco.PRE_CONCIL.ToString())
                i_validar.lst_det = List_det.get_list().Where(q => q.seleccionado == true).ToList();
            else
                i_validar.lst_det = List_det.get_list();

            if (i_validar.IdConciliacion == 0)
            {
                if(bus_conciliacion.ExisteConciliacion(i_validar.IdEmpresa, i_validar.IdPeriodo, i_validar.IdBanco))
                {
                    msg = "Ya existe una conciliación para el banco en el periodo seleccionado";
                    return false;
                }
            }

            return true;
        }
        #endregion

        #region Nuevo
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            ba_Conciliacion_Info model = new ba_Conciliacion_Info
            {
                IdEmpresa = IdEmpresa,
                co_Fecha = DateTime.Now.Date,
                IdPeriodo = Convert.ToInt32(DateTime.Now.Date.AddMonths(-1).ToString("yyyyMM")),
                lst_det = new List<ba_Conciliacion_det_IngEgr_Info>(),
                IdBanco = 1
            };
            var bco = bus_banco_cuenta.get_info(model.IdEmpresa, model.IdBanco);
            var periodo = bus_periodo.get_info(model.IdEmpresa, model.IdPeriodo);
            if (bco != null && periodo != null)
                model.lst_det = bus_det.get_list_x_conciliar(model.IdEmpresa, model.IdBanco, bco.IdCtaCble, periodo.pe_FechaFin);            
            List_det.set_list(model.lst_det);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ba_Conciliacion_Info model)
        {            
            if (!validar(model,ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_conciliacion.guardarDB(model))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }
        #endregion

        #region Json
        public JsonResult GetSaldoContableAnt(int IdBanco = 0, int IdPeriodo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            double resultado = 0;
            var bco = bus_banco_cuenta.get_info(IdEmpresa, IdBanco);
            var periodo = bus_periodo.get_info(IdEmpresa, IdPeriodo);
            if (bco != null && periodo != null)
                resultado = bus_plancta.get_saldo_anterior(IdEmpresa, bco.IdCtaCble, periodo.pe_FechaIni);

            return Json(Math.Round(resultado, 2, MidpointRounding.AwayFromZero), JsonRequestBehavior.AllowGet);
        }
        public void CargarMovimientos(int IdBanco = 0, int IdPeriodo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var bco = bus_banco_cuenta.get_info(IdEmpresa, IdBanco);
            var periodo = bus_periodo.get_info(IdEmpresa, IdPeriodo);
            List<ba_Conciliacion_det_IngEgr_Info> lst_det = new List<ba_Conciliacion_det_IngEgr_Info>();
            if (bco != null && periodo != null)
                lst_det = bus_det.get_list_x_conciliar(IdEmpresa, IdBanco, bco.IdCtaCble, periodo.pe_FechaFin);
            List_det.set_list(lst_det);
        }

        public void EditingUpdate(string IdPk = "")
        {
            List_det.UpdateRow(IdPk);
        }
        #endregion

        public ActionResult GridViewPartial_ConciliacionBanco_x_cruzar()
        {
            var model = List_det.get_list().Where(q=>q.seleccionado == false).ToList();
            return PartialView("_GridViewPartial_ConciliacionBanco_x_cruzar", model);
        }

        public ActionResult GridViewPartial_ConciliacionBanco_det()
        {
            var model = List_det.get_list().Where(q => q.seleccionado == true).ToList();
            return PartialView("_GridViewPartial_ConciliacionBanco_det", model);
        }
        #region Modificar
        public ActionResult Modificar(int IdEmpresa = 0, decimal IdConciliacion = 0)
        {
            ba_Conciliacion_Info model = bus_conciliacion.get_info(IdEmpresa,IdConciliacion);
            if(model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdConciliacion);
            var bco = bus_banco_cuenta.get_info(IdEmpresa, model.IdBanco);
            var periodo = bus_periodo.get_info(IdEmpresa, model.IdPeriodo);
            model.lst_det.AddRange(bus_det.get_list_x_conciliar(IdEmpresa, model.IdBanco, bco.IdCtaCble, periodo.pe_FechaFin.Date));
            List_det.set_list(model.lst_det);
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ba_Conciliacion_Info model)
        {
            if (!validar(model, ref mensaje))
            {
                ViewBag.mensaje = mensaje;
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_conciliacion.modificarDB(model))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }
        #endregion

        public ActionResult Anular(int IdEmpresa = 0, decimal IdConciliacion = 0)
        {
            ba_Conciliacion_Info model = bus_conciliacion.get_info(IdEmpresa, IdConciliacion);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_det = bus_det.get_list(IdEmpresa, IdConciliacion);
            var bco = bus_banco_cuenta.get_info(IdEmpresa, model.IdBanco);
            var periodo = bus_periodo.get_info(IdEmpresa, model.IdPeriodo);
            model.lst_det.AddRange(bus_det.get_list_x_conciliar(IdEmpresa, model.IdBanco, bco.IdCtaCble, periodo.pe_FechaFin.Date));
            List_det.set_list(model.lst_det);
            cargar_combos(IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ba_Conciliacion_Info model)
        {
            if (!bus_conciliacion.anularDB(model))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public JsonResult Calcular(double co_SaldoContable_MesAnt = 0, double co_SaldoBanco_anterior = 0, double co_SaldoBanco_EstCta = 0 )
        {
            ba_Conciliacion_valores_Info resultado = new ba_Conciliacion_valores_Info
            {
                co_totalIng = Math.Round(List_det.get_list().Where(q => q.tipo_IngEgr == "+" && q.seleccionado == true).Sum(q => q.dc_Valor),2,MidpointRounding.AwayFromZero),
                co_totalEgr = Math.Round(List_det.get_list().Where(q => q.tipo_IngEgr == "-" && q.seleccionado == true).Sum(q => q.dc_Valor),2,MidpointRounding.AwayFromZero)
            };
            resultado.co_SaldoConciliado = Math.Round(co_SaldoBanco_anterior + resultado.co_totalIng + resultado.co_totalEgr,2,MidpointRounding.AwayFromZero);
            resultado.co_Diferencia = Math.Round(resultado.co_SaldoConciliado - co_SaldoBanco_EstCta,2,MidpointRounding.AwayFromZero);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }

    public class ba_Conciliacion_valores_Info
    {
        public double co_totalIng { get; set; }
        public double co_totalEgr { get; set; }
        public double co_SaldoContable_MesAct { get; set; }
        public double co_SaldoBanco_anterior { get; set; }
        public double co_SaldoConciliado { get; set; }
        public double co_Diferencia { get; set; }
    }

    public class ba_Conciliacion_det_IngEgr_List
    {
        public List<ba_Conciliacion_det_IngEgr_Info> get_list()
        {
            if (HttpContext.Current.Session["ba_Conciliacion_det_IngEgr_Info"] == null)
            {
                List<ba_Conciliacion_det_IngEgr_Info> list = new List<ba_Conciliacion_det_IngEgr_Info>();

                HttpContext.Current.Session["ba_Conciliacion_det_IngEgr_Info"] = list;
            }
            return (List<ba_Conciliacion_det_IngEgr_Info>)HttpContext.Current.Session["ba_Conciliacion_det_IngEgr_Info"];
        }

        public void set_list(List<ba_Conciliacion_det_IngEgr_Info> list)
        {
            HttpContext.Current.Session["ba_Conciliacion_det_IngEgr_Info"] = list;
        }

        public void UpdateRow(string IdPk)
        {
            ba_Conciliacion_det_IngEgr_Info edited_info = get_list().Where(m => m.IdPK == IdPk).FirstOrDefault();
            if(edited_info != null)
                edited_info.seleccionado = !edited_info.seleccionado;
        }
    }
}