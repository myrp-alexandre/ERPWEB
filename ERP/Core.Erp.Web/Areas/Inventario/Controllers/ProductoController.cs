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

namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class ProductoController : Controller
    {
        #region variables
        const string UploadDirectory = "~/Content/UploadControl/UploadFolder/";
        in_Producto_Bus bus_producto = new in_Producto_Bus();
        in_Producto_Composicion_List list_producto_composicion = new in_Producto_Composicion_List();
        in_Producto_Composicion_Bus bus_producto_composicion = new in_Producto_Composicion_Bus();
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

        public List<in_Producto_Info> get_lst_productos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Producto_Info> model = bus_producto.get_list(IdEmpresa, true);
            return model;
        }
        #endregion
        #region Acciones
        public ActionResult Nuevo()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Producto_Info model = new in_Producto_Info { IdEmpresa = IdEmpresa };
            model.lst_producto_composicion = new List<in_Producto_Composicion_Info>();
            list_producto_composicion.set_list(model.lst_producto_composicion);
            cargar_combos(model);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(in_Producto_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_producto.guardarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Producto_Info model = bus_producto.get_info(IdEmpresa, IdProducto);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            model.lst_producto_composicion = bus_producto_composicion.get_list(model.IdEmpresa, model.IdProducto);
            list_producto_composicion.set_list(model.lst_producto_composicion);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(in_Producto_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            if (!bus_producto.modificarDB(model))
            {
                cargar_combos(model);
                return View(model);
            }

            model.lst_producto_composicion = list_producto_composicion.get_list();
            model.lst_producto_composicion.ForEach(q => { q.IdEmpresa = model.IdEmpresa; q.IdProductoPadre = model.IdProducto; });
            bus_producto_composicion.eliminarDB(model.IdEmpresa, model.IdProducto);
            if (!bus_producto_composicion.guardarDB(model.lst_producto_composicion))
            {
                cargar_combos(model);
                return View(model);
            }

            return RedirectToAction("Index");
        }
        public ActionResult Anular(decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Producto_Info model = bus_producto.get_info(IdEmpresa, IdProducto);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model);
            model.lst_producto_composicion = bus_producto_composicion.get_list(model.IdEmpresa, model.IdProducto);
            list_producto_composicion.set_list(model.lst_producto_composicion);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(in_Producto_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            if (!bus_producto.anularDB(model))
            {
                cargar_combos(model);
                return View(model);
            }
            return RedirectToAction("Index");
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
            if (Session["IdProducto_padre"] != null)
            {
               IdProducto_padre = Convert.ToDecimal(Session["IdProducto_padre"]);
            }
            bus_producto.guardar_loteDB(IdEmpresa, IdProducto_padre,Convert.ToDateTime( fecha_fab),Convert.ToDateTime( fecha_ven), lote);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region cargar combo

        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_UnidadMedida_Bus bus_unidad_medida = new in_UnidadMedida_Bus();
            var lst_unidad_medida = bus_unidad_medida.get_list(false);
            ViewBag.lst_unidad_medida = lst_unidad_medida;

          
        }
        private void cargar_combos(in_Producto_Info model)
        {
            in_ProductoTipo_Bus bus_producto_tipo = new in_ProductoTipo_Bus();
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
        #endregion
        #region funciones del detalle

        [ValidateInput(false)]
        public ActionResult GridViewPartial_producto_composicion(decimal IdProducto = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Producto_Info model = new in_Producto_Info();
            model.lst_producto_composicion = bus_producto_composicion.get_list(IdEmpresa, IdProducto);
            if (model.lst_producto_composicion.Count == 0)
                model.lst_producto_composicion = list_producto_composicion.get_list();
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
                list_producto_composicion.AddRow(info_det);
            }
            model.lst_producto_composicion = list_producto_composicion.get_list();
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
                list_producto_composicion.UpdateRow(info_det);
            }
            model.lst_producto_composicion = list_producto_composicion.get_list();
            return PartialView("_GridViewPartial_producto_composicion", model);
        }

        public ActionResult EditingDelete(int secuencia)
        {
            list_producto_composicion.DeleteRow(secuencia);
            in_Producto_Info model = new in_Producto_Info();
            model.lst_producto_composicion = list_producto_composicion.get_list();
            cargar_combos();
            return PartialView("_GridViewPartial_producto_composicion", model);
        }
        #endregion

    }
    public class in_Producto_Composicion_List
    {
        public List<in_Producto_Composicion_Info> get_list()
        {
            if (HttpContext.Current.Session["in_Producto_Composicion_Info"] == null)
            {
                List<in_Producto_Composicion_Info> list = new List<in_Producto_Composicion_Info>();

                HttpContext.Current.Session["in_Producto_Composicion_Info"] = list;
            }
            return (List<in_Producto_Composicion_Info>)HttpContext.Current.Session["in_Producto_Composicion_Info"];
        }

        public void set_list(List<in_Producto_Composicion_Info> list)
        {
            HttpContext.Current.Session["in_Producto_Composicion_Info"] = list;
        }

        public void AddRow(in_Producto_Composicion_Info info_det)
        {
            List<in_Producto_Composicion_Info> list = get_list();
            info_det.secuencia = list.Count == 0 ? 1 : list.Max(q => q.secuencia)+1;
            list.Add(info_det);
        }

        public void UpdateRow(in_Producto_Composicion_Info info_det)
        {
            in_Producto_Composicion_Info edited_info = get_list().Where(m => m.secuencia == info_det.secuencia).First();
            edited_info.IdProductoHijo = info_det.IdProductoHijo;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.Cantidad = info_det.Cantidad;
        }

        public void DeleteRow(int secuencia)
        {
            List<in_Producto_Composicion_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia == secuencia).First());
        }
    }
}