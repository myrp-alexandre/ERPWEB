using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
using DevExpress.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class PrestamosController : Controller
    {

        #region Variables
        ro_prestamo_Bus bus_prestamos = new ro_prestamo_Bus();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        ro_prestamo_detalle_Bus bus_detalle = new ro_prestamo_detalle_Bus();
        ro_prestamo_detalle_lst lst_prestamo = new ro_prestamo_detalle_lst();
        ro_rubro_tipo_Bus bus_rubro = new ro_rubro_tipo_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        ro_catalogo_Bus bus_catalogo = new ro_catalogo_Bus();
        int IdEmpresa = 0;
        ro_prestamo_Info info = new ro_prestamo_Info();
        #endregion
        public ActionResult Index()
        {
            return View();
        }


        [ValidateInput(false)]
        public ActionResult GridViewPartial_prestamos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<ro_prestamo_Info> model = bus_prestamos.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_prestamos", model);
        }
        private void cargar_combos()
        {
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.lst_empleado = bus_empleado.get_list_combo(IdEmpresa);
            ViewBag.lst_rubro = bus_rubro.get_list_rub_concepto(IdEmpresa);
        }

        public ActionResult Nuevo()
        {
            ro_prestamo_Info model = new ro_prestamo_Info
            {
                IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]),
                Fecha = DateTime.Now,
                Fecha_PriPago = DateTime.Now,
                IdEmpleado = 1,
                descuento_mensual = true
            };
            model.lst_detalle = new List<ro_prestamo_detalle_Info>();
            lst_prestamo.set_list(model.lst_detalle);
            cargar_combos();
            cargar_combos_detalle();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ro_prestamo_Info model)
        {
            if (!validar(model))
            {
                cargar_combos();
                return View(model);
            }
           
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.lst_detalle = lst_prestamo.get_list();
            if (!bus_prestamos.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(decimal IdEmpleado, decimal IdPrestamo)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_prestamo_Info model = bus_prestamos.get_info(IdEmpresa, IdEmpleado, IdPrestamo);
            lst_prestamo.set_list(model.lst_detalle);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(ro_prestamo_Info model)
        {
            model.lst_detalle = lst_prestamo.get_list();
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            decimal diferencia =Convert.ToDecimal( (model.MontoSol- model.lst_detalle.Sum(v => v.TotalCuota)));
            if (model.lst_detalle == null || model.lst_detalle.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle del prestamo";
                cargar_combos();
                return View(model);
            }

            if (diferencia!=0)
            {
                ViewBag.mensaje = "Monto del prestamo no coincide con la suma del detalle";
                cargar_combos();
                return View(model);
            }
            if (!validar(model))
            {
                cargar_combos();
                return View(model);
            }
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (!bus_prestamos.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");

        }

        public ActionResult Anular(decimal IdEmpleado, decimal IdPrestamo)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_prestamo_Info model = bus_prestamos.get_info(IdEmpresa, IdEmpleado, IdPrestamo);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_detalle = bus_detalle.get_list(IdEmpresa,  IdPrestamo);
            lst_prestamo.set_list(model.lst_detalle);
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ro_prestamo_Info model)
        {
            model.lst_detalle = lst_prestamo.get_list();

            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            model.Fecha_UltAnu = DateTime.Now;

            if (!bus_prestamos.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_prestamos_det()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ro_prestamo_Info model = new ro_prestamo_Info();
            
            model.lst_detalle = lst_prestamo.get_list();
            if (lst_prestamo == null)
                model.lst_detalle = new List<ro_prestamo_detalle_Info>();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_prestamos_det", model);
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            ViewBag.lst_tipo_nomina = bus_nomina_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_catalogo = bus_catalogo.get_list_x_tipo(16);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ro_prestamo_detalle_Info info_det)
        {
            if (ModelState.IsValid)
                lst_prestamo.AddRow(info_det);
            ro_prestamo_Info model = new ro_prestamo_Info();
            model.lst_detalle = lst_prestamo.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_prestamos_det", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_prestamo_detalle_Info info_det)
        {
            if (ModelState.IsValid)
                lst_prestamo.UpdateRow(info_det);
            ro_prestamo_Info model = new ro_prestamo_Info();
            model.lst_detalle = lst_prestamo.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_prestamos_det", model);
        }

        public ActionResult EditingDelete([ModelBinder(typeof(DevExpressEditorsBinder))] ro_prestamo_detalle_Info info_det)
        {
            lst_prestamo.DeleteRow(info_det.NumCuota);
            ro_prestamo_Info model = new ro_prestamo_Info();
            model.lst_detalle = lst_prestamo.get_list();
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_prestamos_det", model);
        }

        private bool validar(ro_prestamo_Info model)
        {
            bool bandera = true;
            if (model.descuento_quincena && model.Fecha_PriPago.Day > 15)
            {
                ViewBag.mensaje = "La fecha del primer pago debe estar entre el [01 al 15] de cada mes";
                bandera= false;
            }

            if (model.descuento_men_quin && model.Fecha_PriPago.Day != 15 && model.descuento_men_quin && model.Fecha_PriPago.Day != 30)
            {
                ViewBag.mensaje = "La fecha del primer pago debe ser [15 o 30] de cada mes";
                bandera = false;

            }
            if (model.MontoSol == 0 | model.MontoSol < 0)
            {
                ViewBag.mensaje = "El monto del prestamo debe ser mayor a cero";
                bandera = false;

            }
            if (model.NumCuotas == 0 | model.NumCuotas < 0)
            {
                ViewBag.mensaje = "El n'umerode cuota debe ser mayor a cero";
                bandera = false;

            }
            return bandera;
        }

        public ActionResult GenerarPrestamo(double MontoSol, DateTime Fecha_PriPago, int NumCuotas = 0, bool descuento_mensual =false,bool descuento_quincena =false, bool descuento_men_quin=false)
        {

            
            IdEmpresa = Convert.ToInt32(Session["IdEmpresa"].ToString());
            info.IdEmpresa = IdEmpresa;
            info.MontoSol = MontoSol;
            info.NumCuotas = NumCuotas;
            info.Fecha_PriPago = Fecha_PriPago;
            info.descuento_mensual = descuento_mensual;
            info.descuento_men_quin = descuento_men_quin;
            info.descuento_quincena = descuento_quincena;
            info = bus_prestamos.get_calculo_prestamo(info);
            lst_prestamo.set_list(info.lst_detalle);
            return Json("", JsonRequestBehavior.AllowGet);
        }

    }

    public class ro_prestamo_detalle_lst
    {
        public List<ro_prestamo_detalle_Info> get_list()
        {
            if (HttpContext.Current.Session["lst_detalle"] == null)
            {
                List<ro_prestamo_detalle_Info> list = new List<ro_prestamo_detalle_Info>();

                HttpContext.Current.Session["lst_detalle"] = list;
            }
            return (List<ro_prestamo_detalle_Info>)HttpContext.Current.Session["lst_detalle"];
        }

        public void set_list(List<ro_prestamo_detalle_Info> list)
        {
            HttpContext.Current.Session["lst_detalle"] = list;
        }

        public void AddRow(ro_prestamo_detalle_Info info_det)
        {
            List<ro_prestamo_detalle_Info> list = get_list();
            info_det.NumCuota = list.Count == 0 ? 1 : list.Max(q => q.NumCuota) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(ro_prestamo_detalle_Info info_det)
        {
            ro_prestamo_detalle_Info edited_info = get_list().Where(m => m.NumCuota == info_det.NumCuota).First();
            edited_info.IdNominaTipoLiqui = info_det.IdNominaTipoLiqui;
            edited_info.FechaPago = info_det.FechaPago;
            edited_info.TotalCuota = info_det.TotalCuota;
            edited_info.EstadoPago = info_det.EstadoPago;
        }

        public void DeleteRow(int NumCuota)
        {
            List<ro_prestamo_detalle_Info> list = get_list();
            list.Remove(list.Where(m => m.NumCuota == NumCuota).First());
        }
    }

}
