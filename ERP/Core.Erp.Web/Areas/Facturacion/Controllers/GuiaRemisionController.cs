using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DevExpress.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class GuiaRemisionController : Controller
    {
        #region variables
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        fa_guia_remision_Bus bus_guia = new fa_guia_remision_Bus();
        fa_guia_remision_det_Bus bus_detalle = new fa_guia_remision_det_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        fa_PuntoVta_Bus bus_punto_venta = new fa_PuntoVta_Bus();
        tb_transportista_Bus bus_transportista = new tb_transportista_Bus();
        tb_sis_Documento_Tipo_Talonario_Bus bus_talonario = new tb_sis_Documento_Tipo_Talonario_Bus();
        fa_factura_Bus bus_factura = new fa_factura_Bus();
        fa_guia_remision_det_Info_lst detalle_info = new fa_guia_remision_det_Info_lst();
        fa_cliente_contactos_Bus bus_contacto = new fa_cliente_contactos_Bus();

        #endregion

        #region Metodos ComboBox bajo demanda cliente
        public ActionResult CmbCliente_Guia()
        {
            fa_guia_remision_Info model = new fa_guia_remision_Info();
            return PartialView("_CmbCliente_Guia", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.CLIENTE.ToString());
        }
        #endregion

        #region vistas

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


        public ActionResult GridViewPartial_guias_remision(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            if (IdSucursal == 0)
                IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            ViewBag.IdSucursal = IdSucursal;

            List<fa_guia_remision_Info> model = new List<fa_guia_remision_Info>();
            model = bus_guia.get_list(IdEmpresa, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_guias_remision", model);
        }
        public ActionResult GridViewPartial_guias_remision_det()
        {
            List<fa_guia_remision_det_Info> model = new List<fa_guia_remision_det_Info>();
            model = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            if (model == null)
                model = new List<fa_guia_remision_det_Info>();
            return PartialView("_GridViewPartial_guias_remision_det", model);
        }

        public ActionResult GridViewPartial_FacturasSinGuia()
        {
            List<fa_factura_Info> model = new List<fa_factura_Info>();
            model = Session["fa_factura_Info"] as List<fa_factura_Info>;
            if (model == null)
                model = new List<fa_factura_Info>();
            return PartialView("_GridViewPartial_FacturasSinGuia", model);
        }

        public ActionResult GridViewPartial_Facturas_x_guia()
        {
            List<fa_guia_remision_det_x_factura_Info> model = new List<fa_guia_remision_det_x_factura_Info>();
            model = Session["fa_guia_remision_det_x_factura_Info"] as List<fa_guia_remision_det_x_factura_Info>;
            if (model == null)
                model = new List<fa_guia_remision_det_x_factura_Info>();
            return PartialView("_GridViewPartial_Facturas_x_guia", model);
        }

        



        #endregion

        #region acciones
        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            int IdSucursal = Convert.ToInt32(SessionFixed.IdSucursal);
            fa_guia_remision_Info model = new fa_guia_remision_Info
            {
                gi_fecha = DateTime.Now,
                gi_FechaFinTraslado=DateTime.Now,
                gi_FechaInicioTraslado=DateTime.Now,
                IdEmpresa=IdEmpresa,
                IdSucursal=IdSucursal
            };
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(fa_guia_remision_Info model)
        {
            model.lst_detalle = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.CodGuiaRemision= (model.CodGuiaRemision == null) ? "" : model.CodGuiaRemision;
            model.CodDocumentoTipo = "GUIA";
            string mensaje = bus_guia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (!bus_guia.guardarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdGuiaRemision=0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_guia_remision_Info model = bus_guia.get_info(IdEmpresa, IdGuiaRemision);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdGuiaRemision);
            Session["fa_guia_remision_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(fa_guia_remision_Info model)
        {
            model.lst_detalle = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.CodGuiaRemision = (model.CodGuiaRemision == null) ? "" : model.CodGuiaRemision;
            model.CodDocumentoTipo = "GUIA";
            string mensaje = bus_guia.validar(model);
            if (mensaje != "")
            {
                cargar_combos(model);
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            if (!bus_guia.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdGuiaRemision=0)
        {

            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            fa_guia_remision_Info model = bus_guia.get_info(IdEmpresa, IdGuiaRemision);
            var lst_detalle = bus_detalle.get_list(IdEmpresa, IdGuiaRemision);
            Session["fa_guia_remision_det_Info"] = lst_detalle;
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_guia_remision_Info model)
        {
            if (!bus_guia.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            Session["fa_guia_remision_det_Info"] = null;
            return RedirectToAction("Index");
        }
        #endregion

        #region Json
      
        public JsonResult CargarPuntosDeVenta(int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_punto_venta.get_list(IdEmpresa, IdSucursal, false);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
         public JsonResult GetUltimoDocumento(int IdSucursal = 0, int IdPuntoVta = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            tb_sis_Documento_Tipo_Talonario_Info resultado;
            var punto_venta = bus_punto_venta.get_info(IdEmpresa, IdSucursal, IdPuntoVta);
            if (punto_venta != null)
            {
                tb_bodega_Bus bus_bodega = new tb_bodega_Bus();
                var bodega = bus_bodega.get_info(IdEmpresa, IdSucursal, Convert.ToInt32(punto_venta.IdBodega));
                var sucursal = bus_sucursal.get_info(IdEmpresa, IdSucursal);
                resultado = bus_talonario.get_info_ultimo_no_usado(IdEmpresa, sucursal.Su_CodigoEstablecimiento, bodega.cod_punto_emision, "GUIA");
            }
            else
                resultado = new tb_sis_Documento_Tipo_Talonario_Info();
            if (resultado == null)
                resultado = new tb_sis_Documento_Tipo_Talonario_Info();
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Cargar_facturas(decimal IdCliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_facturas_sin_guias = bus_factura.get_list_fac_sin_guia(IdEmpresa, IdCliente);
            Session["fa_factura_Info"] = lst_facturas_sin_guias;
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult seleccionar_aprobacion(string Ids, int IdSucursal=0, int IdPuntoVta=0)
        {
            if (Ids != null)
            {
                int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
                fa_guia_remision_det_Bus detalle_guia = new fa_guia_remision_det_Bus();
                string[] array = Ids.Split(',');
                var output = array.GroupBy(q => q).ToList();
                List<fa_guia_remision_det_Info> list_facturas_seleccionadas = new List<fa_guia_remision_det_Info>();
                list_facturas_seleccionadas = Session["fa_guia_remision_det_Info"] as List<fa_guia_remision_det_Info>;
                if (list_facturas_seleccionadas == null)
                    list_facturas_seleccionadas = new List<fa_guia_remision_det_Info>();
                foreach (var item in output)
                {
                    if (item.Key != "")
                    {
                        if (list_facturas_seleccionadas.Where(q => q.IdCbteVta == Convert.ToDecimal(Ids)).Count() == 0)
                        {
                            var lst_tmp = bus_detalle.get_list_x_factura(IdEmpresa, IdSucursal, IdPuntoVta, Convert.ToDecimal(item.Key));
                            list_facturas_seleccionadas.AddRange(lst_tmp);
                        }
                    }
                }
                Session["fa_guia_remision_det_Info"] = list_facturas_seleccionadas;
            }
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult get_direcciones(decimal IdCliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);          
            var resultado = bus_contacto.get_list(IdEmpresa, IdCliente).FirstOrDefault();
            resultado.Direccion_emp = SessionFixed.em_direccion.ToString();
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Get_placa(int Idtransportista = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_transportista.get_info(IdEmpresa, Idtransportista);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        public JsonResult cargar_contactos(decimal IdCliente = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var resultado = bus_contacto.get_list(IdEmpresa, IdCliente);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion


        #region funciones del detalle

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_guia_remision_det_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.Secuencia != 0 && info_det.gi_cantidad!=0)
                {
                    detalle_info.UpdateRow(info_det);
                }

         
            var model = detalle_info.get_list();
            return PartialView("_GridViewPartial_guias_remision_det", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            detalle_info.DeleteRow(Secuencia);
            var model = detalle_info.get_list();
            return PartialView("_GridViewPartial_guias_remision_det", model);
        }
        #endregion
        private void cargar_combos(fa_guia_remision_Info model)
        {
            var lst_sucursal = bus_sucursal.get_list(model.IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_punto_venta = bus_punto_venta.get_list(model.IdEmpresa, model.IdSucursal, false);
            ViewBag.lst_punto_venta = lst_punto_venta;

            var lst_transportista = bus_transportista.get_list(model.IdEmpresa, false);
            ViewBag.lst_transportista = lst_transportista;

            var lst_contacto = bus_contacto.get_list(model.IdEmpresa, model.IdCliente);
            ViewBag.lst_contacto = lst_contacto;

        }
       
    }



    public class fa_guia_remision_det_Info_lst
    {
        public List<fa_guia_remision_det_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_guia_remision_det_Info"] == null)
            {
                List<fa_guia_remision_det_Info> list = new List<fa_guia_remision_det_Info>();

                HttpContext.Current.Session["fa_guia_remision_det_Info"] = list;
            }
            return (List<fa_guia_remision_det_Info>)HttpContext.Current.Session["fa_guia_remision_det_Info"];
        }

        public void set_list(List<fa_guia_remision_det_Info> list)
        {
            HttpContext.Current.Session["fa_guia_remision_det_Info"] = list;
        }

     
        public void UpdateRow(fa_guia_remision_det_Info info_det)
        {
            fa_guia_remision_det_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.gi_cantidad = info_det.gi_cantidad;

        }

        public void DeleteRow(int Secuencia)
        {
            List<fa_guia_remision_det_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}