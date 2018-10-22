using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using DevExpress.Web;
using System.Web.UI;
using Core.Erp.Web.Helps;
using Core.Erp.Info.Helps;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.General;
namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    [SessionTimeout]
    public class ProductoController : Controller
    {
        #region variables
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        in_Producto_Composicion_List list_producto_composicion = new in_Producto_Composicion_List();
        in_Producto_Composicion_Bus bus_producto_composicion = new in_Producto_Composicion_Bus();
        in_ProductoTipo_Bus bus_producto_tipo = new in_ProductoTipo_Bus();
        in_producto_x_tb_bodega_Info_List Lis_in_producto_x_tb_bodega_Info_List = new in_producto_x_tb_bodega_Info_List();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
        in_producto_x_tb_bodega_Bus bus_producto_x_bodega = new in_producto_x_tb_bodega_Bus();
        seg_usuario_Bus bus_usuarios = new seg_usuario_Bus();
        tbl_TransaccionesAutorizadas_Bus bus_transacciones_aut = new tbl_TransaccionesAutorizadas_Bus();
        private string mensaje;
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbProducto_composicion()
        {
            in_Producto_Info model = new in_Producto_Info();
            return PartialView("_CmbProducto_composicion", model);
        }
        public ActionResult CmbProducto_padre()
        {
            in_Producto_Info model = new in_Producto_Info();
            return PartialView("_CmbProducto_padre", model);
        }
        public List<in_Producto_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa),cl_enumeradores.eTipoBusquedaProducto.SOLOHIJOS,cl_enumeradores.eModulo.INV,0);
        }
        public List<in_Producto_Info> get_list_bajo_demandaComposicion(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_producto.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoBusquedaProducto.TODOS_MENOS_PADRES, cl_enumeradores.eModulo.INV, 0);
        }
        public in_Producto_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_producto.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion

        #region vistas

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_producto()
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Producto_Info> model = bus_producto.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_producto", model);
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_producto_por_bodega()
        {
            cargar_combos_detalle();
            in_Producto_Info model = new in_Producto_Info();
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            return PartialView("_GridViewPartial_producto_por_bodega", model);
        }
        
        public List<in_Producto_Info> get_lst_productos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Producto_Info> model = bus_producto.get_list(IdEmpresa, true);
            return model;
        }


        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            try
            {
                #region Validar Session
                if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                    return RedirectToAction("Login", new { Area = "", Controller = "Account" });
                SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
                SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
                #endregion
                in_Producto_Info model = new in_Producto_Info
                {
                    IdEmpresa = IdEmpresa,
                    IdCod_Impuesto_Iva = "IVA12",
                    IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual),
                    lst_producto_composicion = new List<in_Producto_Composicion_Info>()
                };
                model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
                var lst_producto_x_bodega = bus_producto_x_bodega.get_list(Convert.ToInt32(SessionFixed.IdEmpresa));
                model.pr_imagen = new byte[0];
                list_producto_composicion.set_list(model.lst_producto_composicion, model.IdTransaccionSession);
                Lis_in_producto_x_tb_bodega_Info_List.set_list(bus_producto_x_bodega.get_list(Convert.ToInt32(SessionFixed.IdEmpresa)), model.IdTransaccionSession);
                cargar_combos(model);
                return View(model);
            }
            catch (Exception)
            {
                throw;
               
            }
        }
        [HttpPost]
        public ActionResult Nuevo(in_Producto_Info model)
        {
            try
            {
                bus_producto = new in_Producto_Bus();
                model.IdUsuario = SessionFixed.IdUsuario.ToString();
                model.pr_imagen = Producto_imagen.pr_imagen;
                model.lst_producto_composicion = list_producto_composicion.get_list(model.IdTransaccionSession);
                model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToInt32(model.IdTransaccionSession));
                if (model.lst_producto_x_bodega == null)
                    model.lst_producto_x_bodega = new List<in_producto_x_tb_bodega_Info>();
                if (!validar(model, ref mensaje))
                {
                    if (model.pr_imagen == null)
                        model.pr_imagen = new byte[0];
                    cargar_combos(model);
                    ViewBag.mensaje = mensaje;
                    return View(model);
                }
                if (!bus_producto.guardarDB(model))
                {
                    if (model.pr_imagen == null)
                        model.pr_imagen = new byte[0];
                    cargar_combos(model);
                    return View(model);
                }
                Producto_imagen.pr_imagen = null;
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                if (model.pr_imagen == null)
                    model.pr_imagen = new byte[0];
                tb_sis_log_error_InfoList.DescripcionError = ex.InnerException.ToString();
                if (tb_sis_log_error_InfoList.DescripcionError == null)
                    tb_sis_log_error_InfoList.DescripcionError = ex.Message.ToString();
                ViewBag.error = ex.Message.ToString();
                cargar_combos(model);
                return View(model);
            }
        }
        public ActionResult Modificar(int IdEmpresa = 0 , decimal IdProducto = 0)
        {
            try
            {
                #region Validar Session
                if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                    return RedirectToAction("Login", new { Area = "", Controller = "Account" });
                SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
                SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
                #endregion
                in_Producto_Info model = bus_producto.get_info(IdEmpresa, IdProducto);
                if (model == null)
                    return RedirectToAction("Index");
                cargar_combos(model);
                model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
                model.lst_producto_composicion = bus_producto_composicion.get_list(model.IdEmpresa, model.IdProducto);
                model.lst_producto_x_bodega = bus_producto_x_bodega.get_list(IdEmpresa, model.IdProducto);
                Lis_in_producto_x_tb_bodega_Info_List.set_list(model.lst_producto_x_bodega, model.IdTransaccionSession);
                list_producto_composicion.set_list(model.lst_producto_composicion, model.IdTransaccionSession);
                return View(model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Modificar(in_Producto_Info model)

        {
            try
            {
                bus_producto = new in_Producto_Bus();
                model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToInt32(model.IdTransaccionSession));
                if (model.lst_producto_x_bodega == null)
                    model.lst_producto_x_bodega = new List<in_producto_x_tb_bodega_Info>();
                model.IdUsuarioUltMod = SessionFixed.IdUsuario.ToString();
                model.pr_imagen = Producto_imagen.pr_imagen;
                if (!validar(model, ref mensaje))
                {
                    if (model.pr_imagen == null)
                        model.pr_imagen = new byte[0];
                    cargar_combos(model);
                    ViewBag.mensaje = mensaje;
                    return View(model);
                }
                if (!bus_producto.modificarDB(model))
                {
                    if (model.pr_imagen == null)
                        model.pr_imagen = new byte[0];
                    cargar_combos(model);
                    return View(model);
                }

                model.lst_producto_composicion = list_producto_composicion.get_list(model.IdTransaccionSession);
                model.lst_producto_composicion.ForEach(q => { q.IdEmpresa = model.IdEmpresa; q.IdProductoPadre = model.IdProducto; });
                bus_producto_composicion.eliminarDB(model.IdEmpresa, model.IdProducto);
                if (!bus_producto_composicion.guardarDB(model.lst_producto_composicion))
                {
                    cargar_combos(model);
                    return View(model);
                }
                Producto_imagen.pr_imagen = null;
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                if (model.pr_imagen == null)
                    model.pr_imagen = new byte[0];
                tb_sis_log_error_InfoList.DescripcionError = ex.InnerException.ToString();
                if (tb_sis_log_error_InfoList.DescripcionError == null)
                    tb_sis_log_error_InfoList.DescripcionError = ex.Message.ToString();
                ViewBag.error = ex.Message.ToString();
                cargar_combos(model);
                return View(model);
            }
        }
        public ActionResult Anular(int IdEmpresa = 0 , decimal IdProducto = 0)
        {
            try
            {
                #region Validar Session
                if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                    return RedirectToAction("Login", new { Area = "", Controller = "Account" });
                SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
                SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
                #endregion
                in_Producto_Info model = bus_producto.get_info(IdEmpresa, IdProducto);
                if (model == null)
                    return RedirectToAction("Index");
                cargar_combos(model);
                model.lst_producto_composicion = bus_producto_composicion.get_list(model.IdEmpresa, model.IdProducto);
                list_producto_composicion.set_list(model.lst_producto_composicion, model.IdTransaccionSession);
                return View(model);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [HttpPost]
        public ActionResult Anular(in_Producto_Info model)
        {
            try
            {
                model.IdUsuarioUltAnu = SessionFixed.IdUsuario.ToString();
                if (!bus_producto.validar_anulacion(model.IdEmpresa, model.IdProducto, ref mensaje))
                {
                    cargar_combos(model);
                    ViewBag.mensaje = mensaje;
                    return View(model);
                }
                if (!bus_producto.anularDB(model))
                {
                    cargar_combos(model);
                    return View(model);
                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                if (model.pr_imagen == null)
                    model.pr_imagen = new byte[0];
                tb_sis_log_error_InfoList.DescripcionError = ex.InnerException.ToString();
                if (tb_sis_log_error_InfoList.DescripcionError == null)
                    tb_sis_log_error_InfoList.DescripcionError = ex.Message.ToString();
                ViewBag.error = ex.Message.ToString();
                cargar_combos(model);
                return View(model);
            }
        }
        #endregion

        #region Json
        public JsonResult cargar_lineas(string IdCategoria = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_linea_Bus bus_linea = new in_linea_Bus();
            var resultado = bus_linea.get_list(IdEmpresa, IdCategoria, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult cargar_grupos(string IdCategoria = "", int IdLinea = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_grupo_Bus bus_grupo = new in_grupo_Bus();
            var resultado = bus_grupo.get_list(IdEmpresa, IdCategoria, IdLinea, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult cargar_subgrupos(string IdCategoria = "", int IdLinea = 0, int IdGrupo = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_subgrupo_Bus bus_subgrupo = new in_subgrupo_Bus();
            var resultado = bus_subgrupo.get_list(IdEmpresa, IdCategoria, IdLinea,IdGrupo, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult get_info_padre(decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_producto.get_info(IdEmpresa, IdProducto);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Guardar_lote(DateTime?  fecha_fab, DateTime? fecha_ven, string lote="")
        {
            decimal IdProducto_padre = 0;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (SessionFixed.IdProducto_padre_dist!=null)
            {
               IdProducto_padre = Convert.ToDecimal(SessionFixed.IdProducto_padre_dist);
            }
            bus_producto.guardar_loteDB(IdEmpresa, IdProducto_padre, fecha_fab == null ? DateTime.MinValue : Convert.ToDateTime(fecha_fab), Convert.ToDateTime( fecha_ven), lote);
            return Json("", JsonRequestBehavior.AllowGet);
        }


        public JsonResult MostrarPrecios(string IdUsuarioAut = "", string contrasena_admin = "", decimal IdProducto=0)
        {
            string EstadoDesbloqueo = "NOAUTORIZADO"; 
             var info_usuarios = bus_usuarios.get_info(IdUsuarioAut);
            if (info_usuarios != null)
            {
                if (info_usuarios.es_super_admin)
                {
                    if (contrasena_admin.ToLower() == info_usuarios.contrasena_admin.ToLower())
                    {
                        tbl_TransaccionesAutorizadas_info info_trasnsaccion_aut = new tbl_TransaccionesAutorizadas_info
                        {
                            IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                            IdUsuarioAut = IdUsuarioAut,
                            IdUsuarioLog = SessionFixed.IdUsuario,
                            Observacion = "Desbloqueo de pestaña de precio para el producto con ID #" + IdProducto.ToString(),
                        };
                        bus_transacciones_aut.guardarDB(info_trasnsaccion_aut);
                        EstadoDesbloqueo = "AUTORIZADO";
                    }
                }
                else
                    EstadoDesbloqueo = "NOAUTORIZADO";

            }

            return Json(EstadoDesbloqueo, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region cargar combo
        private bool validar(in_Producto_Info i_validar, ref string msg)
        {
            var tipo = bus_producto_tipo.get_info(i_validar.IdEmpresa, i_validar.IdProductoTipo);
            if(tipo == null)
            {
                msg = "Seleccion el tipo de producto";
                return false;
            }
            if (tipo.tp_es_lote && string.IsNullOrEmpty(i_validar.lote_num_lote) )
            {
                msg = "Ingrese el código del lote";
                return false;
            }
            if (tipo.tp_es_lote && i_validar.lote_fecha_vcto == null)
            {
                msg = "Ingrese la fecha de vencimiento del lote";
                return false;
            }

            return true;
        }
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
            var lst_unidad_medida = bus_unidad_medida.get_list(false);
            ViewBag.lst_unidad_medida = lst_unidad_medida;
            var lst_susucrsal = bus_sucursal.get_list(IdEmpresa, false);
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);


        }
        private void cargar_combos(in_Producto_Info model)
        {
            
            var lst_producto_tipo = bus_producto_tipo.get_list(model.IdEmpresa, false);
            ViewBag.lst_producto_tipo = lst_producto_tipo;

            Dictionary<string, string> lst_signos = new Dictionary<string, string>();
            lst_signos.Add("-", "-");
            lst_signos.Add("+", "+");
            ViewBag.lst_signos = lst_signos;

            in_categorias_Bus bus_categoria = new in_categorias_Bus();
            var lst_categoria = bus_categoria.get_list(model.IdEmpresa, false);
            ViewBag.lst_categoria = lst_categoria;

            in_presentacion_Bus bus_presentacion = new in_presentacion_Bus();
            var lst_presentacion = bus_presentacion.get_list(model.IdEmpresa, false);
            ViewBag.lst_presentacion = lst_presentacion;

            in_Marca_Bus bus_marca = new in_Marca_Bus();
            var lst_marca = bus_marca.get_list(model.IdEmpresa, false);
            ViewBag.lst_marca = lst_marca;

            in_linea_Bus bus_linea = new in_linea_Bus();
            var lst_linea = bus_linea.get_list(model.IdEmpresa, model.IdCategoria, false);
            ViewBag.lst_linea = lst_linea;

            in_grupo_Bus bus_grupo = new in_grupo_Bus();
            var lst_grupo = bus_grupo.get_list(model.IdEmpresa, model.IdCategoria, model.IdLinea, false);
            ViewBag.lst_grupo = lst_grupo;

            in_subgrupo_Bus bus_subgrupo = new in_subgrupo_Bus();
            var lst_subgrupo = bus_subgrupo.get_list(model.IdEmpresa, model.IdCategoria, model.IdLinea, model.IdGrupo, false);
            ViewBag.lst_subgrupo = lst_subgrupo;

            in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
            var lst_unidad_medida = bus_unidad_medida.get_list(false);
            ViewBag.lst_unidad_medida = lst_unidad_medida;

            var lst_producto_padre = bus_producto.get_list_padres(model.IdEmpresa, false);
            ViewBag.lst_producto_padre = lst_producto_padre;

            tb_sis_Impuesto_Bus bus_impuesto = new tb_sis_Impuesto_Bus();
            var lst_impuesto = bus_impuesto.get_list("IVA", false);
            ViewBag.lst_impuesto = lst_impuesto;
        }

        private void cargar_combos_detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
           
            var lst_susucrsal = bus_sucursal.get_list(IdEmpresa, false);
            var lst_bodega = bus_bodega.get_list(IdEmpresa, false);
            ViewBag.lst_susucrsal = lst_susucrsal;
            ViewBag.lst_bodega = lst_bodega;

        }
        #endregion

        #region funciones del detalle composicion

        [ValidateInput(false)]
        public ActionResult GridViewPartial_producto_composicion(decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            in_Producto_Info model = new in_Producto_Info();
            model.lst_producto_composicion = bus_producto_composicion.get_list(IdEmpresa, IdProducto);
            if (model.lst_producto_composicion.Count == 0)
                model.lst_producto_composicion = list_producto_composicion.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            model.lst_producto_composicion = list_producto_composicion.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos();
            return PartialView("_GridViewPartial_producto_composicion", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] in_Producto_Composicion_Info info_det)
        {
            in_Producto_Info model = new in_Producto_Info();
            if (ModelState.IsValid)
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                in_Producto_Info info_p = new in_Producto_Info();
                if (info_det != null)
                    if (info_det.IdProductoHijo != 0)
                        info_p = bus_producto.get_info(IdEmpresa, info_det.IdProductoHijo);
                if (info_p != null)
                {
                    info_det.pr_descripcion = info_p.pr_descripcion;
                    info_det.IdUnidadMedida = info_p.IdUnidadMedida;
                }
                list_producto_composicion.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            }
            model.lst_producto_composicion = list_producto_composicion.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_producto_composicion", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] in_Producto_Composicion_Info info_det)
        {
            in_Producto_Info model = new in_Producto_Info();
            if (ModelState.IsValid)
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                in_Producto_Info info_p = new in_Producto_Info();
                if (info_det != null)
                    if (info_det.IdProductoHijo != 0)
                        info_p = bus_producto.get_info(IdEmpresa, info_det.IdProductoHijo);
                if (info_p != null)
                {
                    info_det.pr_descripcion = info_p.pr_descripcion;
                    info_det.IdUnidadMedida = info_p.IdUnidadMedida;
                }
                list_producto_composicion.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            }
            model.lst_producto_composicion = list_producto_composicion.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_producto_composicion", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            list_producto_composicion.DeleteRow(secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            in_Producto_Info model = new in_Producto_Info();
            model.lst_producto_composicion = list_producto_composicion.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos();
            return PartialView("_GridViewPartial_producto_composicion", model);
        }
        #endregion


        #region funciones del detalle producto por bodega

     
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew_pro_x_bod([ModelBinder(typeof(DevExpressEditorsBinder))] in_producto_x_tb_bodega_Info info_det )
        {
            in_Producto_Info model = new in_Producto_Info();
            if (ModelState.IsValid)
            {
                in_producto_x_tb_bodega_Info info_pro_x_bode = new in_producto_x_tb_bodega_Info();
                info_pro_x_bode.IdSucursal = info_det.IdSucursal;
                info_pro_x_bode.IdBodega = info_det.IdBodega;
                var lista = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
                if(lista.Where(v=>v.IdSucursal==info_det.IdSucursal && v.IdBodega==info_det.IdBodega).Count()==0)                  
                Lis_in_producto_x_tb_bodega_Info_List.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            }
            cargar_combos_detalle();
            model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_producto_por_bodega", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate_pro_x_bod([ModelBinder(typeof(DevExpressEditorsBinder))] in_producto_x_tb_bodega_Info info_det)
        {
            in_Producto_Info model = new in_Producto_Info();
            if (ModelState.IsValid)
            {
               
                Lis_in_producto_x_tb_bodega_Info_List.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            }
            model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_producto_por_bodega", model);
        }

        public ActionResult EditingDelete_pro_x_bod(int Secuencia=0)
        {
            in_Producto_Info model = new in_Producto_Info();
            cargar_combos_detalle();
            Lis_in_producto_x_tb_bodega_Info_List.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            model.lst_producto_x_bodega = Lis_in_producto_x_tb_bodega_Info_List.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_detalle();
            return PartialView("_GridViewPartial_producto_por_bodega", model);
        }
        #endregion

        const string UploadDirectory = "~/Content/imagenes/";

        public UploadedFile UploadControlUpload()
        {
            UploadControlExtension.GetUploadedFiles("UploadControl", Producto_imagen.UploadValidationSettings, Producto_imagen.FileUploadComplete);
            
            byte[] model = Producto_imagen.pr_imagen;
            UploadedFile file=new UploadedFile();
            return file;
        }

        public ActionResult get_imagen()
        {

            byte[] model = Producto_imagen.pr_imagen;
            if (model == null)
                model = new byte[0];
            return PartialView("_Producto_imagen",model);
        }

    }
    public class Producto_imagen
    {
        public static byte[] pr_imagen { get; set; }
        public static DevExpress.Web.UploadControlValidationSettings UploadValidationSettings = new DevExpress.Web.UploadControlValidationSettings()
        {
            AllowedFileExtensions = new string[] { ".jpg", ".jpeg" },
            MaxFileSize = 4000000
        };
        public static void FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {

            if (e.UploadedFile.IsValid)
            {
                pr_imagen = e.UploadedFile.FileBytes;
            }
        }
     }
    
    public class in_Producto_Composicion_List
    {
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        string Variable = "in_Producto_Composicion_Info";

        public List<in_Producto_Composicion_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<in_Producto_Composicion_Info> list = new List<in_Producto_Composicion_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<in_Producto_Composicion_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<in_Producto_Composicion_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(in_Producto_Composicion_Info info_det, decimal IdTransaccionSession)
        {
            List<in_Producto_Composicion_Info> list = get_list(IdTransaccionSession);
            
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia)+1;
            info_det.pr_descripcion = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProductoHijo).pr_descripcion_combo;
            list.Add(info_det);
        }

        public void UpdateRow(in_Producto_Composicion_Info info_det, decimal IdTransaccionSession)
        {
            in_Producto_Composicion_Info edited_info = get_list(IdTransaccionSession).Where(m => m.secuencia == info_det.secuencia).First();
            if (edited_info.IdProductoHijo != info_det.IdProductoHijo)
            {
                edited_info.pr_descripcion = bus_producto.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdProductoHijo).pr_descripcion_combo;
            }
            edited_info.IdProductoHijo = info_det.IdProductoHijo;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.Cantidad = info_det.Cantidad;
        }

        public void DeleteRow(int secuencia, decimal IdTransaccionSession)
        {
            List<in_Producto_Composicion_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }

    public class in_Producto_List
    {
        string Variable = "in_producto_x_tb_bodega_Info";
        public List<in_Producto_Info> get_list()
        {
            if (HttpContext.Current.Session["in_Producto_Info"] == null)
            {
                List<in_Producto_Info> list = new List<in_Producto_Info>();

                HttpContext.Current.Session["in_Producto_Info"] = list;
            }
            return (List<in_Producto_Info>)HttpContext.Current.Session["in_Producto_Info"];
        }

        public void set_list(List<in_Producto_Info> list)
        {
            HttpContext.Current.Session["in_Producto_Info"] = list;
        }

        public void AddRow(in_Producto_Info info_det)
        {
            List<in_Producto_Info> list = get_list();
            if (list.Where(q=>q.IdProducto == info_det.IdProducto).Count() == 0)
               list.Add(info_det);
        }

        public void DeleteRow(decimal IdProducto)
        {
            List<in_Producto_Info> list = get_list();
            list.Remove(list.Where(m => m.IdProducto == IdProducto).First());
        }
    }

    public class in_producto_x_tb_bodega_Info_List
    {
        string Variable = "in_producto_x_tb_bodega_Info";
        public List<in_producto_x_tb_bodega_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<in_producto_x_tb_bodega_Info> list = new List<in_producto_x_tb_bodega_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<in_producto_x_tb_bodega_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<in_producto_x_tb_bodega_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(in_producto_x_tb_bodega_Info info_det, decimal IdTransaccionSession)
        {
            List<in_producto_x_tb_bodega_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            list.Add(info_det);
        }

        public void UpdateRow(in_producto_x_tb_bodega_Info info_det, decimal IdTransaccionSession)
        {
            in_producto_x_tb_bodega_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdBodega = info_det.IdBodega;
            edited_info.IdSucursal = info_det.IdSucursal;
            edited_info.Stock_minimo = info_det.Stock_minimo;

        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<in_producto_x_tb_bodega_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

}