using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using DevExpress.Web;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class ContratoController : Controller
    {
        List<ro_empleado_Info> lis_empleado = new List<ro_empleado_Info>();
        List<ro_catalogo_Info> lst_tipo_contrato =new List<ro_catalogo_Info>();
        List<ro_catalogo_Info> lst_esta_contrato = new List<ro_catalogo_Info>();
        ro_catalogo_Bus bus_catalogo = new ro_catalogo_Bus();
        ro_contrato_Bus bus_contrato = new ro_contrato_Bus();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();

        int IdEmpresa = 0;

        tb_persona_Bus bus_persona = new tb_persona_Bus();
        #region Metodos ComboBox bajo demanda


        public tb_persona_Bus Bus_persona
        {
            get
            {
                return bus_persona;
            }

            set
            {
                bus_persona = value;
            }
        }

        public ActionResult CmbEmpleado_contrato()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_contrato", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return Bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return Bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion


        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_contrato()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                List<ro_contrato_Info> model = bus_contrato.get_list(IdEmpresa, true);
                return PartialView("_GridViewPartial_contrato", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo(ro_contrato_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_contrato.guardarDB(info))
                        {
                        cargar_combo();
                        return View(info);
                        }
                    else
                        return RedirectToAction("Index");
                }
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Nuevo()
        {
            try
            {
                ro_contrato_Info info = new ro_contrato_Info();
                info.IdNomina = 1;
                info.FechaInicio = DateTime.Now.Date;
                info.FechaFin = DateTime.Now.Date;
                cargar_combo();
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_contrato_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (!bus_contrato.modificarDB(info))
                    {
                        cargar_combo();
                        return View(info);
                    }
                    else
                        return RedirectToAction("Index");
                }
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }

        public ActionResult Modificar(int IdContrato = 0, decimal IdEmpleado=0)
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                cargar_combo();
                return View(bus_contrato.get_info(IdEmpresa,IdEmpleado, IdContrato));

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]

        public ActionResult Anular(ro_contrato_Info info)
        {
            try
            {
               
                    if (!bus_contrato.anularDB(info))
                    {
                        cargar_combo();
                        return View(info);
                    }
                    else
                        return RedirectToAction("Index");
              
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Anular(int IdContrato = 0, decimal IdEmpleado=0)
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                cargar_combo();
                return View(bus_contrato.get_info(IdEmpresa,IdEmpleado, IdContrato));

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void cargar_combo()
        {
            try
            { ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
                IdEmpresa = GetIdEmpresa();
                lis_empleado = bus_empleado.get_list_combo(IdEmpresa);
                lst_tipo_contrato = bus_catalogo.get_list_x_tipo(2);
                lst_esta_contrato = bus_catalogo.get_list_x_tipo(33);

                ViewBag.lst_empleado = lis_empleado;
                ViewBag.lst_tipo_contrato = lst_tipo_contrato;
                ViewBag.lst_estado_contrato = lst_esta_contrato;
                ViewBag.lst_nomina = bus_nomina.get_list(IdEmpresa, false);
            }
            catch (Exception)
            {

                throw;
            }
        }

        private int GetIdEmpresa()
        {
            try
            {
                if (Session["IdEmpresa"] != null)
                    return Convert.ToInt32(Session["IdEmpresa"]);
                else
                    return 0;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public JsonResult get_info_contato_a_liquidar(Decimal IdEmpleado)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);

            var resultado = bus_contrato.get_info_contato_a_liquidar(IdEmpresa, IdEmpleado);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }
}