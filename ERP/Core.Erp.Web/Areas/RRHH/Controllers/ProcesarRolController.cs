using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.RRHH;
using Core.Erp.Bus.RRHH;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.CuentasPorPagar;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.General;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class ProcesarRolController : Controller
    {
        #region variables
        List<ro_nomina_tipo_Info> lista_nomina = new List<ro_nomina_tipo_Info>();
        ro_nomina_tipo_Bus bus_nomina = new ro_nomina_tipo_Bus();
        ro_Nomina_Tipoliquiliqui_Bus bus_nomina_tipo = new ro_Nomina_Tipoliquiliqui_Bus();
        List<ro_Nomina_Tipoliqui_Info> lst_nomina_tipo = new List<ro_Nomina_Tipoliqui_Info>();
        ro_periodo_x_ro_Nomina_TipoLiqui_Bus bus_periodos_x_nomina = new ro_periodo_x_ro_Nomina_TipoLiqui_Bus();
        List<ro_periodo_x_ro_Nomina_TipoLiqui_Info> lst_periodos = new List<ro_periodo_x_ro_Nomina_TipoLiqui_Info>();
        ro_rol_detalle_Bus bus_detalle = new ro_rol_detalle_Bus();
        ro_rol_Bus bus_rol = new ro_rol_Bus();
        ct_plancta_Bus bus_cuentas = new ct_plancta_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();

        #endregion
        #region Metodos ComboBox bajo demanda xueldo

        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult CmbCuenta_sueldos()
        {
            ct_cbtecble_det_Info model = new ct_cbtecble_det_Info();
            return PartialView("_CmbCuenta_sueldos", model);
        }
        public List<ct_plancta_Info> get_list_bajo_demanda_sueldo(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda_sueldo(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion


        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal)
            };
            cargar_combo_consulta(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_combo_consulta(model.IdEmpresa);
            return View(model);
        }
        public ActionResult Index2()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ro_rol( int IdSucursal=0)
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                ViewBag.IdSucursal = IdSucursal;
                List< ro_rol_Info> model = bus_rol.get_list_nominas(IdEmpresa, IdSucursal);
                return PartialView("_GridViewPartial_ro_rol", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Nuevo( ro_rol_Info info)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    info.UsuarioIngresa = Session["IdUsuario"].ToString();
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rol.procesar(info))
                        return View(info);
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
                cargar_combos(0, 0);
                 ro_rol_Info info = new  ro_rol_Info
                 {
                     IdNomina_Tipo = 1,
                     IdSucursal=Convert.ToInt32( SessionFixed.IdSucursal),
                     IdEmpresa=Convert.ToInt32( SessionFixed.IdEmpresa)
                 };
                ViewBag.FechaCorte = DateTime.Now.Date;
                return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(ro_rol_Info info)
        {
            try
            {
                
                    info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rol.procesar(info))
                    {
                        cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
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
        public ActionResult Modificar( int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo=0, decimal IdRol=0)
        {
            try
            {
                ViewBag.IdRol = IdRol;
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                ro_rol_Info model = bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo, IdRol);
                ViewBag.FechaCorte = DateTime.Now;
                return View(model);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult CerrarPeriodo(ro_rol_Info info)
        {
            try
            {
                //cp_orden_pago_tipo_x_empresa_Bus bus_op_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
                //var info_tipo_op = bus_op_tipo.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoOrdenPago.ANTI_EMPLE.ToString());
                //if( (info_tipo_op.IdCtaCble==null | info_tipo_op.IdCtaCble=="") | (info_tipo_op.IdCtaCble_Credito == null | info_tipo_op.IdCtaCble_Credito == ""))
                //{
                //    ViewBag.mensaje = "Falta cuenta contable tipo de orden de pago";
                //    cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                //    return View(info);
                //}

                info.IdEmpresa = GetIdEmpresa();
                    if (!bus_rol.CerrarPeriodo(info))
                    {
                        cargar_combos(info.IdNomina_Tipo,info.IdNomina_TipoLiqui);
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
        public ActionResult CerrarPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, decimal IdRol=0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo, IdRol));

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult AbrirPeriodo(ro_rol_Info info)
        {
            try
            {

                info.IdEmpresa = GetIdEmpresa();
                if (!bus_rol.AbrirPeriodo(info))
                {
                    cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                    return View(info);
                }
                else
                    return RedirectToAction("Index2");


            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult AbrirPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, decimal IdRol=0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo, IdRol));

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult ContabilizarPeriodo(ro_rol_Info info)
        {
            try
            {
               info.lst_sueldo_x_pagar= Session["lst_sueldo_pagar"] as List<ct_cbtecble_det_Info>; 
               info.lst_provisiones= Session["lst_provisiones"] as List<ct_cbtecble_det_Info>;
                info.UsuarioCierre = Session["IdUsuario"].ToString();

                foreach (var item in info.lst_sueldo_x_pagar)
                {
                    item.IdCtaCble = item.IdCtaCble.Trim();
                    if (item.IdCtaCble == null || item.IdCtaCble == "")
                    {
                        ViewBag.mensaje = " Falta cueta contable de:" +item.dc_Observacion;
                        cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                        cargar_combo_detalle();
                        return View(info);
                    }
                }
                foreach (var item in info.lst_provisiones)
                {
                    item.IdCtaCble = item.IdCtaCble.Trim();

                    if (item.IdCtaCble == null || item.IdCtaCble == "")
                    {
                        ViewBag.mensaje = " Falta cueta contable de:" + item.dc_Observacion;
                        cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                        cargar_combo_detalle();
                        return View(info);
                    }
                }
                info.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                    if (!bus_rol.ContabilizarPeriodo(info))
                    {
                        cargar_combos(info.IdNomina_Tipo,info.IdNomina_TipoLiqui);
                        cargar_combo_detalle();
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
        public ActionResult ContabilizarPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, int IdRol=0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                cargar_combo_detalle();
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                ro_rol_Info model = new ro_rol_Info();
                model = bus_rol.get_info_contabilizar(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo, IdRol);
                Session["lst_sueldo_pagar"] = model.lst_sueldo_x_pagar;
                Session["lst_provisiones"] = model.lst_provisiones;

                model.Fechacontabilizacion=DateTime.Now;
                return View(model);

            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult ReversarcontabilidadPeriodo(ro_rol_Info info)
        {
            try
            {

                info.IdEmpresa = GetIdEmpresa();
                if (!bus_rol.Reversar_contabilidad_Periodo(info))
                {
                    cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                    return View(info);
                }
                else
                    return RedirectToAction("Index2");


            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult ReversarcontabilidadPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0, decimal IdRol=0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo,IdRol));

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
        private void cargar_combos(int IdNomina_Tipo, int IdNomina_Tipo_Liqui)
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                lista_nomina = bus_nomina.get_list(IdEmpresa, false);
                lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina_Tipo);
                lst_periodos = bus_periodos_x_nomina.get_list_utimo_periodo_aprocesar(IdEmpresa, IdNomina_Tipo, IdNomina_Tipo_Liqui);
                ViewBag.lst_nomina = lista_nomina;
                ViewBag.lst_nomina_tipo = lst_nomina_tipo;
                ViewBag.lst_periodos = lst_periodos;
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;

                

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void cargar_combo_consulta(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void cargar_combo_detalle()
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                ViewBag.lst_cuentas = bus_cuentas.get_list(IdEmpresa,false,true);

            }
            catch (Exception)
            {

                throw;
            }
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_sueldo_x_pagar()
        {
            cargar_combo_detalle();
            ro_rol_Info model = new ro_rol_Info();
            model.lst_sueldo_x_pagar = Session["lst_sueldo_pagar"] as List<ct_cbtecble_det_Info>;
            return PartialView("_GridViewPartial_sueldo_x_pagar", model);
        }

        public ActionResult GridViewPartial_provisiones()
        {
            cargar_combo_detalle();
            ro_rol_Info model = new ro_rol_Info();
            model.lst_provisiones = Session["lst_provisiones"] as List<ct_cbtecble_det_Info>;
            return PartialView("_GridViewPartial_provisiones", model);
        }

        public ActionResult GridViewPartial_empleados_sin_percibir_sueldo(decimal IdRol=0)
        {
            var model = bus_detalle.get_list_nomina_sin_sueldo_percibir(Convert.ToInt32(SessionFixed.IdEmpresa), IdRol);
            return PartialView("_GridViewPartial_empleados_sin_percibir_sueldo", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_nominas_cerradas()
        {
            try
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                List<ro_rol_Info> model = bus_rol.get_list_nominas_cerradas(IdEmpresa);
                return PartialView("_GridViewPartial_nominas_cerradas", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }


}