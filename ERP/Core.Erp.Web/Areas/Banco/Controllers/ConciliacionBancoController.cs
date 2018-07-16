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
    public class ConciliacionBancoController : Controller
    {
        #region Variables
        ba_Conciliacion_Bus bus_conciliacion = new ba_Conciliacion_Bus();
        ct_periodo_Bus bus_periodo = new ct_periodo_Bus();
        ba_Banco_Cuenta_Bus bus_banco_cuenta = new ba_Banco_Cuenta_Bus();
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
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_periodo = bus_periodo.get_list(IdEmpresa, false);
            ViewBag.lst_periodo = lst_periodo;

            var lst_banco_cuenta = bus_banco_cuenta.get_list(IdEmpresa, false);
            ViewBag.lst_banco_cuenta = lst_banco_cuenta;

            Dictionary<string, string> lst_estado = new Dictionary<string, string>();
            lst_estado.Add(cl_enumeradores.eEstadoCierreBanco.PRE_CONCIL.ToString(), "PRE-CONCILIADO");
            lst_estado.Add(cl_enumeradores.eEstadoCierreBanco.CONCILIADO.ToString(), "CONCILIADO");
            ViewBag.lst_estado = lst_estado;
        }
        #endregion

        public ActionResult Nuevo()
        {
            ba_Conciliacion_Info model = new ba_Conciliacion_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                co_Fecha = DateTime.Now.Date,
                IdPeriodo = Convert.ToInt32(DateTime.Now.Date.AddMonths(-1).ToString("yyyyMM"))
            };
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ba_Conciliacion_Info model)
        {
            if (!bus_conciliacion.guardarDB(model))
            {
                ViewBag.mensaje = "No se pudo guardar el registro";
                cargar_combos();
                return View(model);
            }

            return RedirectToAction("Index");
        }
        public ActionResult Modificar()
        {
            return View();
        }
        public ActionResult Anular()
        {
            return View();
        }
    }
}