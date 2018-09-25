using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    [SessionTimeout]
    public class ClienteController : Controller
    {
        #region Variables
        fa_cliente_Bus bus_cliente = new fa_cliente_Bus();
        fa_cliente_contactos_Bus bus_cliente_contacto = new fa_cliente_contactos_Bus();
        fa_cliente_contactos_List List_fa_cliente_contactos = new fa_cliente_contactos_List();
        fa_cliente_x_fa_Vendedor_x_sucursal_list List_fa_cliente_x_fa_Vendedor_x_sucursal = new fa_cliente_x_fa_Vendedor_x_sucursal_list();
        fa_cliente_x_fa_Vendedor_x_sucursal_Bus bus_fa_vendedor = new fa_cliente_x_fa_Vendedor_x_sucursal_Bus();
        tb_parroquia_Bus bus_parroquia = new tb_parroquia_Bus();
        string mensaje = string.Empty;
        #endregion
        #region Index
        public ActionResult Index()
        {
            return View();
        }
        private bool validar(fa_cliente_Info i_validar, ref string msg)
        {
            if (i_validar.lst_fa_cliente_contactos.Count == 0)
            {
                mensaje = "Debe ingresar al menos un contacto";
                return false;
            }

            return true;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_cliente()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_cliente.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_cliente", model);
        }

        #endregion
        #region Metodos
        private void cargar_combos(fa_cliente_Info info)
        {
            fa_formaPago_Bus bus_formapago = new fa_formaPago_Bus();
            var lst_formapago = bus_formapago.get_list();
            ViewBag.lst_formapago = lst_formapago;

            fa_cliente_tipo_Bus bus_clientetipo = new fa_cliente_tipo_Bus();
            var lst_clientetipo = bus_clientetipo.get_list(info.IdEmpresa, false);
            ViewBag.lst_clientetipo = lst_clientetipo;

            Dictionary<int, string> lst_nivel_precio = new Dictionary<int, string>();
            lst_nivel_precio.Add(1, "Nivel 1");
            lst_nivel_precio.Add(2, "Nivel 2");
            lst_nivel_precio.Add(3, "Nivel 3");
            lst_nivel_precio.Add(4, "Nivel 4");
            lst_nivel_precio.Add(5, "Nivel 5");
            ViewBag.lst_nivel_precio = lst_nivel_precio;

            fa_TerminoPago_Bus bus_termino_pago = new fa_TerminoPago_Bus();
            var lst_termino_pago = bus_termino_pago.get_list(false);
            ViewBag.lst_termino_pago = lst_termino_pago;

            ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
            var lst_ctacble = bus_plancta.get_list(info.IdEmpresa, false, true);
            ViewBag.lst_cuentas = lst_ctacble;

            tb_Catalogo_Bus bus_catalogo = new tb_Catalogo_Bus();
            var lst_tipo_doc = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPODOC), false);
            ViewBag.lst_tipo_doc = lst_tipo_doc;
            var lst_tipo_naturaleza = bus_catalogo.get_list(Convert.ToInt32(cl_enumeradores.eTipoCatalogoGeneral.TIPONATPER), false);
            ViewBag.lst_tipo_naturaleza = lst_tipo_naturaleza;
        }

        #endregion
        #region Acciones

        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            fa_cliente_Info model = new fa_cliente_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession),
                Idtipo_cliente = 1,
                info_persona = new Info.General.tb_persona_Info
                {
                    pe_Naturaleza = "NATU",
                    IdTipoDocumento = "CED"
                },
                lst_fa_cliente_contactos = new List<fa_cliente_contactos_Info>(),
                Lst_fa_cliente_x_fa_Vendedor_x_sucursal = new List<fa_cliente_x_fa_Vendedor_x_sucursal_Info>()
            };
            List_fa_cliente_contactos.set_list(model.lst_fa_cliente_contactos, model.IdTransaccionSession);
            List_fa_cliente_x_fa_Vendedor_x_sucursal.set_list(model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal, model.IdTransaccionSession);
            cargar_combos(model);
            cargar_combos_det();
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(fa_cliente_Info model)
        {
            model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(model.IdTransaccionSession);
            model.lst_fa_cliente_contactos = List_fa_cliente_contactos.get_list(model.IdTransaccionSession);
            if (!validar(model, ref mensaje))
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_cliente.guardarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, decimal IdCliente = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            fa_cliente_Info model = bus_cliente.get_info(IdEmpresa, IdCliente);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal = bus_fa_vendedor.get_list(IdEmpresa, IdCliente);
            List_fa_cliente_x_fa_Vendedor_x_sucursal.set_list(model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal, model.IdTransaccionSession);
            model.lst_fa_cliente_contactos = bus_cliente_contacto.get_list(IdEmpresa, IdCliente);
            List_fa_cliente_contactos.set_list(model.lst_fa_cliente_contactos, model.IdTransaccionSession);
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(fa_cliente_Info model)
        {
            model.IdUsuarioUltMod = SessionFixed.IdUsuario.ToString();
            model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(model.IdTransaccionSession);
            model.lst_fa_cliente_contactos = List_fa_cliente_contactos.get_list(model.IdTransaccionSession);
            if (!validar(model, ref mensaje))
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.lst_fa_cliente_contactos.ForEach(q => { q.IdEmpresa = model.IdEmpresa; q.IdCliente = model.IdCliente; });
            if (!bus_cliente_contacto.guardarDB(model.lst_fa_cliente_contactos))
            {
                cargar_combos(model);
                return View(model);
            }

            if (!bus_cliente.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0 , decimal IdCliente = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            fa_cliente_Info model = bus_cliente.get_info(IdEmpresa, IdCliente);
            if (model == null)
                return RedirectToAction("Index");
            model.lst_fa_cliente_contactos = bus_cliente_contacto.get_list(IdEmpresa, IdCliente);
            List_fa_cliente_contactos.set_list(model.lst_fa_cliente_contactos, model.IdTransaccionSession);
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal = bus_fa_vendedor.get_list(IdEmpresa, IdCliente);
            List_fa_cliente_x_fa_Vendedor_x_sucursal.set_list(model.Lst_fa_cliente_x_fa_Vendedor_x_sucursal, model.IdTransaccionSession);
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(fa_cliente_Info model)
        {
            model.IdUsuarioUltAnu = SessionFixed.IdUsuario.ToString();
            if (!bus_cliente.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion
        #region Json
        public ActionResult get_parroquias(string IdCiudad = "")
        {
            
            return GridViewExtension.GetComboBoxCallbackResult(p =>
            {
                p.TextField = "nom_parroquia";
                p.ValueField = "IdParroquia";
                p.ValueType = typeof(string);
                p.BindList(bus_parroquia.get_list(IdCiudad, false));
            });
        }

        public JsonResult get_info_termino_pago(string IdTerminoPago = "")
        {
            fa_TerminoPago_Bus bus_termino_pago = new fa_TerminoPago_Bus();
            var resultado = bus_termino_pago.get_info(IdTerminoPago);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_tipo_cliente(int IdEmpresa = 0 , int IdCliente_tipo = 0)
        {
            fa_cliente_tipo_Bus bus_cliente_tipo = new fa_cliente_tipo_Bus();
            var resultado = bus_cliente_tipo.get_info(IdEmpresa, IdCliente_tipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_info_x_num_cedula(int IdEmpresa = 0 , string pe_cedulaRuc = "")
        {
            var resultado = bus_cliente.get_info_x_num_cedula(IdEmpresa, pe_cedulaRuc);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region detalle
        private void cargar_combos_det()
        {
            tb_ciudad_Bus bus_ciudad = new tb_ciudad_Bus();
            var lst_ciudad = bus_ciudad.get_list("", false);
            ViewBag.lst_ciudad = lst_ciudad;

            tb_parroquia_Bus bus_parroquia = new tb_parroquia_Bus();
            var lst_parroquia = bus_parroquia.get_list("", false);
            ViewBag.lst_parroquia = lst_parroquia;

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            fa_Vendedor_Bus bus_vendedor = new fa_Vendedor_Bus();
            var lst_vendedor = bus_vendedor.get_list(IdEmpresa, false);
            ViewBag.lst_vendedor = lst_vendedor;
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_cliente_contacto()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = List_fa_cliente_contactos.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_cliente_contacto", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_cliente_contactos_Info info_det)
        {
            if (ModelState.IsValid)
            {
                var parroquia = bus_parroquia.get_info(info_det.IdParroquia);
                info_det.nom_parroquia = parroquia == null ? "" : parroquia.nom_parroquia;
                List_fa_cliente_contactos.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            }
            var model  = List_fa_cliente_contactos.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_cliente_contacto", model);
        }

        [ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_cliente_contactos_Info info_det)
        {
            if (ModelState.IsValid)
            {
                var parroquia = bus_parroquia.get_info(info_det.IdParroquia);
                info_det.nom_parroquia = parroquia == null ? "" : parroquia.nom_parroquia;
                List_fa_cliente_contactos.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            }
            var model = List_fa_cliente_contactos.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_cliente_contacto", model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_fa_vendedor()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_fa_vendedor", model);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult Editing_AddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_cliente_x_fa_Vendedor_x_sucursal_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_cliente_x_fa_Vendedor_x_sucursal.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model  = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_fa_vendedor", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Editing_Update([ModelBinder(typeof(DevExpressEditorsBinder))] fa_cliente_x_fa_Vendedor_x_sucursal_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_cliente_x_fa_Vendedor_x_sucursal.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_fa_vendedor", model);
        }

        public ActionResult Editing_Delete(decimal IdCliente)
        {
            List_fa_cliente_x_fa_Vendedor_x_sucursal.DeleteRow(IdCliente, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = List_fa_cliente_x_fa_Vendedor_x_sucursal.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_det();
            return PartialView("_GridViewPartial_fa_vendedor", model);
        }
        #endregion

    }

    #region List

    public class fa_cliente_contactos_List
    {
        string variable = "fa_cliente_contactos_Info";

        public List<fa_cliente_contactos_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] == null)
            {
                List<fa_cliente_contactos_Info> list = new List<fa_cliente_contactos_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<fa_cliente_contactos_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<fa_cliente_contactos_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
        }
        public void AddRow(fa_cliente_contactos_Info info_det, decimal IdTransaccionSession)
        {
            List<fa_cliente_contactos_Info> list = get_list(IdTransaccionSession);
            info_det.IdContacto = list.Count == 0 ? 1 : list.Max(q => q.IdContacto) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(fa_cliente_contactos_Info info_det, decimal IdTransaccionSession)
        {
            fa_cliente_contactos_Info edited_info = get_list(IdTransaccionSession).Where(m => m.IdContacto == info_det.IdContacto).First();
            edited_info.IdCiudad = info_det.IdCiudad;
            edited_info.IdParroquia = info_det.IdParroquia;
            edited_info.Celular = info_det.Celular;
            edited_info.Correo = info_det.Correo;
            edited_info.Telefono = info_det.Telefono;
            edited_info.Direccion = info_det.Direccion;
            edited_info.Nombres = info_det.Nombres;
            edited_info.nom_parroquia = info_det.nom_parroquia;
        }

    }
    public class fa_cliente_x_fa_Vendedor_x_sucursal_list
    {
        string variable = "fa_cliente_x_fa_Vendedor_x_sucursal_Info";
        public List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] == null)
            {
                List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> list = new List<fa_cliente_x_fa_Vendedor_x_sucursal_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<fa_cliente_x_fa_Vendedor_x_sucursal_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
        }
        public void AddRow(fa_cliente_x_fa_Vendedor_x_sucursal_Info info_det, decimal IdTransaccionSession)
        {
            List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> list = get_list(IdTransaccionSession);
            info_det.IdCliente = list.Count == 0 ? 1 : list.Max(q => q.IdCliente) + 1;
            info_det.IdEmpresa = info_det.IdEmpresa;
            info_det.IdSucursal = info_det.IdSucursal;
            info_det.IdVendedor = info_det.IdVendedor;

            list.Add(info_det);
        }

        public void UpdateRow(fa_cliente_x_fa_Vendedor_x_sucursal_Info info_det, decimal IdTransaccionSession)
        {
            fa_cliente_x_fa_Vendedor_x_sucursal_Info edited_info = get_list(IdTransaccionSession).Where(m => m.IdCliente == info_det.IdCliente).First();
            info_det.IdEmpresa = info_det.IdEmpresa;
            info_det.IdSucursal = info_det.IdSucursal;
            edited_info.IdVendedor = info_det.IdVendedor;

        }

        public void DeleteRow(decimal IdCliente, decimal IdTransaccionSession)
        {
            List<fa_cliente_x_fa_Vendedor_x_sucursal_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.IdCliente == IdCliente).First());
        }
    }
    #endregion
}