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
        ro_rol_Bus bus_rol = new ro_rol_Bus();
        ct_plancta_Bus bus_cuentas = new ct_plancta_Bus();
        int IdEmpresa = 0;
        #endregion


        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Index2()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ro_rol()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                List< ro_rol_Info> model = bus_rol.get_list_nominas(IdEmpresa);
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
                     IdNomina_Tipo = 1
                 };
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
                if (ModelState.IsValid)
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
                else
                    return View(info);

            }
            catch (Exception)
            {

                throw;
            }
        }
        public ActionResult Modificar( int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo=0)
        {
            try
            { 
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                IdEmpresa = GetIdEmpresa();
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo));

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
                cp_orden_pago_tipo_x_empresa_Bus bus_op_tipo = new cp_orden_pago_tipo_x_empresa_Bus();
                var info_tipo_op = bus_op_tipo.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoOrdenPago.ANTI_EMPLE.ToString());
                if( (info_tipo_op.IdCtaCble==null | info_tipo_op.IdCtaCble=="") | (info_tipo_op.IdCtaCble_Credito == null | info_tipo_op.IdCtaCble_Credito == ""))
                {
                    ViewBag.mensaje = "Falta cuenta contable tipo de orden de pago";
                    cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                    return View(info);
                }

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
        public ActionResult CerrarPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                IdEmpresa = GetIdEmpresa();
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo));

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
        public ActionResult AbrirPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                IdEmpresa = GetIdEmpresa();
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo));

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
                    if (item.IdCtaCble == null)
                    {
                        ViewBag.mensaje = " Falta cueta contable de:" +item.dc_Observacion;
                        cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                        cargar_combo_detalle();
                        return View(info);
                    }
                }
                foreach (var item in info.lst_provisiones)
                {
                    if (item.IdCtaCble == null)
                    {
                        ViewBag.mensaje = " Falta cueta contable de:" + item.dc_Observacion;
                        cargar_combos(info.IdNomina_Tipo, info.IdNomina_TipoLiqui);
                        cargar_combo_detalle();
                        return View(info);
                    }
                }
                info.IdEmpresa = GetIdEmpresa();
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
        public ActionResult ContabilizarPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                cargar_combo_detalle();
                IdEmpresa = GetIdEmpresa();
                ro_rol_Info model = new ro_rol_Info();
                model = bus_rol.get_info_contabilizar(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo);
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
        public ActionResult ReversarcontabilidadPeriodo(int IdNomina_Tipo = 0, int IdNomina_TipoLiqui = 0, int IdPeriodo = 0)
        {
            try
            {
                cargar_combos(IdNomina_Tipo, IdNomina_TipoLiqui);
                IdEmpresa = GetIdEmpresa();
                return View(bus_rol.get_info(IdEmpresa, IdNomina_Tipo, IdNomina_TipoLiqui, IdPeriodo));

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
                IdEmpresa = GetIdEmpresa();
                lista_nomina = bus_nomina.get_list(IdEmpresa, false);
                lst_nomina_tipo = bus_nomina_tipo.get_list(IdEmpresa, IdNomina_Tipo);
                lst_periodos = bus_periodos_x_nomina.get_list(IdEmpresa, IdNomina_Tipo, IdNomina_Tipo_Liqui);
                ViewBag.lst_nomina = lista_nomina;
                ViewBag.lst_nomina_tipo = lst_nomina_tipo;
                ViewBag.lst_periodos = lst_periodos;

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
                IdEmpresa = GetIdEmpresa();                
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

        [ValidateInput(false)]
        public ActionResult GridViewPartial_nomonas_cerradas()
        {
            try
            {
                IdEmpresa = GetIdEmpresa();
                List<ro_rol_Info> model = bus_rol.get_list_nominas(IdEmpresa);
                return PartialView("_GridViewPartial_nominas_cerradas", model);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}