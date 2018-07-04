using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.Inventario;
using Core.Erp.Bus.Inventario;
using Core.Erp.Info.Helps;
using DevExpress.Web.Mvc;
using Core.Erp.Web.Helps;
namespace Core.Erp.Web.Areas.Inventario.Controllers
{
    public class DistribucionPorLoteController : Controller
    {
        in_Ing_Egr_Inven_distribucion_Bus bus_ing_inv = new in_Ing_Egr_Inven_distribucion_Bus();
        in_Ing_Egr_Inven_det_Bus bus_det_ing_inv = new in_Ing_Egr_Inven_det_Bus();
        in_Ing_Egr_Inven_distribucion_lst List_in_Ing_Egr_Inven_det = new in_Ing_Egr_Inven_distribucion_lst();
        in_parametro_Bus bus_in_param = new in_parametro_Bus();
        string mensaje = string.Empty;
        decimal IdProducto_padre = 0;
        List<in_Producto_Info> list_productos = new List<in_Producto_Info>();

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

        private bool validar(in_Ing_Egr_Inven_distribucion_Info i_validar, ref string msg)
        {
            if (i_validar.lst_distribuido.Count == 0)
            {
                mensaje = "Debe ingresar al menos un producto";
                return false;
            }
            return true;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_distribuion(DateTime? fecha_ini, DateTime? fecha_fin)
        {
            ViewBag.fecha_ini = fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : fecha_ini;
            ViewBag.fecha_fin = fecha_fin == null ? DateTime.Now.Date : fecha_fin;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Ing_Egr_Inven_distribucion_Info> model = bus_ing_inv.get_list(IdEmpresa);
            return PartialView("_GridViewPartial_distribuion", model);
        }

        public ActionResult GridViewPartial_distribuidos(int IdSucursal=0, int IdMovi_inven_tipo=0, decimal IdNumMovi=0)
        {
            List<in_Ing_Egr_Inven_distribucion_Info> model = new List<in_Ing_Egr_Inven_distribucion_Info>();
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (IdSucursal != 0 & IdMovi_inven_tipo != 0 & IdNumMovi != 0 & Session["list_distribuida"] == null)
            {
                model = bus_ing_inv.get_list_distribuido(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
                Session["list_distribuida"] = model;

            }
            else
            {
                model = Session["list_distribuida"] as List<in_Ing_Egr_Inven_distribucion_Info>;
            }
            return PartialView("_GridViewPartial_distribuidos", model);
        }
        public ActionResult GridViewPartial_por_distribuir(int IdSucursal = 0, int IdMovi_inven_tipo = 0, decimal IdNumMovi = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Ing_Egr_Inven_distribucion_Info> model = bus_ing_inv.get_list_x_distribuir(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            Session["lst_x_distribuir"] = model;
            return PartialView("_GridViewPartial_por_distribuir", model);
        }
        public ActionResult GridViewPartial_distribucion_det()
        {
            if (Session["IdProducto_padre"] != null)
                IdProducto_padre = (decimal)Session["IdProducto_padre"];
            cargar_combos_detalle(IdProducto_padre);
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<in_Ing_Egr_Inven_distribucion_Info> model = new List<in_Ing_Egr_Inven_distribucion_Info>();
            return PartialView("_GridViewPartial_distribucion_det", model);
        }

        
        private void cargar_combos()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_movi_inven_tipo_Bus bus_tipo = new in_movi_inven_tipo_Bus();
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            in_Motivo_Inven_Bus bus_motivo = new in_Motivo_Inven_Bus();
            var lst_motivo = bus_motivo.get_list(IdEmpresa, cl_enumeradores.eTipoIngEgr.ING.ToString(), false);
            ViewBag.lst_motivo = lst_motivo;

        }
        public ActionResult Nuevo(int IdSucursal = 0, int IdMovi_inven_tipo = 0, decimal IdNumMovi = 0)
        {
            Session["list_distribuida"] = null;
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_parametro_Info i_param = bus_in_param.get_info(IdEmpresa);
            if (i_param == null)
                return RedirectToAction("Index");
            in_Ing_Egr_Inven_distribucion_Info model = new in_Ing_Egr_Inven_distribucion_Info();
            model = bus_ing_inv.get_info(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi, "+");

            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(in_Ing_Egr_Inven_distribucion_Info model)
        {
            bus_ing_inv = new in_Ing_Egr_Inven_distribucion_Bus();
            model.lst_distribuido = List_in_Ing_Egr_Inven_det.get_list();
            if (!validar(model, ref mensaje))
            {
                cargar_combos();
                ViewBag.mensaje = mensaje;
                return View(model);
            }
            model.IdUsuario = Session["IdUsuario"].ToString();
            if (!bus_ing_inv.guardarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        
        private void cargar_combos_detalle(decimal IdProducto_padre=0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            in_Producto_Bus bus_producto = new in_Producto_Bus();
            var lst_producto = bus_producto.get_list_combo_hijo(IdEmpresa, IdProducto_padre);
            ViewBag.lst_producto = lst_producto;
            Session["list_productos"] = lst_producto;
            in_UnidadMedida_Bus bus_unidad = new in_UnidadMedida_Bus();
            var lst_unidad = bus_unidad.get_list(false);
            ViewBag.lst_unidad = lst_unidad;
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] in_Ing_Egr_Inven_distribucion_Info info_det)
        {
            DateTime? lote_fecha_fab;
            DateTime? lote_fecha_vcto;
            string lote_num_lote = "";
            string pr_descripcion = "";
            string unidad_medida = "";
            in_Ing_Egr_Inven_distribucion_Info model = new in_Ing_Egr_Inven_distribucion_Info();
            if (ModelState.IsValid)
            {
                if (Session["list_productos"] != null)
                {
                    var list = Session["list_productos"] as List<in_Producto_Info>;
                    var info_ = list.Where(v=>v.IdProducto==info_det.IdProducto).FirstOrDefault();
                    lote_fecha_fab = info_.lote_fecha_fab;
                    lote_fecha_vcto = info_.lote_fecha_vcto;
                    lote_num_lote = info_.lote_num_lote;
                    pr_descripcion = info_.pr_descripcion;
                    unidad_medida = info_.IdUnidadMedida;

                    info_det.lote_fecha_fab = lote_fecha_fab;
                    info_det.lote_fecha_vcto = lote_fecha_vcto;
                    info_det.lote_num_lote = lote_num_lote;
                    info_det.pr_descripcion = pr_descripcion;
                    info_det.IdUnidadMedida = unidad_medida;

                   

                }
                List_in_Ing_Egr_Inven_det.AddRow(info_det);
                model.lst_distribuido = List_in_Ing_Egr_Inven_det.get_list();

                // actualizar lista distribuidas
                List<in_Ing_Egr_Inven_distribucion_Info> lst_x_distribuir;
                lst_x_distribuir = Session["lst_x_distribuir"] as List<in_Ing_Egr_Inven_distribucion_Info>;
                foreach (var item in lst_x_distribuir)
                {
                    item.can_distribuida = model.lst_distribuido.Sum(v => v.dm_cantidad);
                }
                Session["lst_x_distribuir"]=lst_x_distribuir;
                if (Session["IdProducto_padre"] != null)
                    IdProducto_padre = (decimal)Session["IdProducto_padre"];
                cargar_combos_detalle(IdProducto_padre);
            }
            return PartialView("_GridViewPartial_distribucion_det", model.lst_distribuido);
        }
        
        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] in_Ing_Egr_Inven_distribucion_Info info_det)
        {
            DateTime? lote_fecha_fab;
            DateTime? lote_fecha_vcto;
            string lote_num_lote = "";
            string pr_descripcion = "";
            string unidad_medida = "";
            in_Ing_Egr_Inven_distribucion_Info model = new in_Ing_Egr_Inven_distribucion_Info();
            if (ModelState.IsValid)
            {
                if (Session["list_productos"] != null)
                {
                    var list = Session["list_productos"] as List<in_Producto_Info>;
                    var info_ = list.Where(v => v.IdProducto == info_det.IdProducto).FirstOrDefault();
                    lote_fecha_fab = info_.lote_fecha_fab;
                    lote_fecha_vcto = info_.lote_fecha_vcto;
                    lote_num_lote = info_.lote_num_lote;
                    pr_descripcion = info_.pr_descripcion;
                    unidad_medida = info_.IdUnidadMedida;

                    info_det.lote_fecha_fab = lote_fecha_fab;
                    info_det.lote_fecha_vcto = lote_fecha_vcto;
                    info_det.lote_num_lote = lote_num_lote;
                    info_det.pr_descripcion = pr_descripcion;
                    info_det.IdUnidadMedida = unidad_medida;



                }
                List_in_Ing_Egr_Inven_det.UpdateRow(info_det);
                model.lst_distribuido = List_in_Ing_Egr_Inven_det.get_list();

                // actualizar lista distribuidas
                List<in_Ing_Egr_Inven_distribucion_Info> lst_x_distribuir;
                lst_x_distribuir = Session["lst_x_distribuir"] as List<in_Ing_Egr_Inven_distribucion_Info>;
                foreach (var item in lst_x_distribuir)
                {
                    item.can_distribuida = model.lst_distribuido.Sum(v => v.dm_cantidad);
                }
                Session["lst_x_distribuir"] = lst_x_distribuir;
                if (Session["IdProducto_padre"] != null)
                    IdProducto_padre = (decimal)Session["IdProducto_padre"];
                cargar_combos_detalle(IdProducto_padre);
            }
            return PartialView("_GridViewPartial_distribucion_det", model.lst_distribuido);
        }

        public ActionResult EditingDelete(int secuencia_distribucion)
        {
            List_in_Ing_Egr_Inven_det.DeleteRow(secuencia_distribucion);
            in_Ing_Egr_Inven_distribucion_Info model = new in_Ing_Egr_Inven_distribucion_Info();
            model.lst_distribuido = List_in_Ing_Egr_Inven_det.get_list();

            // actualizar lista distribuidas
            List<in_Ing_Egr_Inven_distribucion_Info> lst_x_distribuir;
            lst_x_distribuir = Session["lst_x_distribuir"] as List<in_Ing_Egr_Inven_distribucion_Info>;
            foreach (var item in lst_x_distribuir)
            {
                item.can_distribuida = model.lst_distribuido.Sum(v => v.dm_cantidad);
            }
            Session["lst_x_distribuir"] = lst_x_distribuir;


            if (Session["IdProducto_padre"] != null)
                IdProducto_padre = (decimal)Session["IdProducto_padre"];
            cargar_combos_detalle(IdProducto_padre); return PartialView("_GridViewPartial_distribucion_det", model.lst_distribuido);
        }


        public JsonResult Mostrar(decimal IdProducto_padre=0)
        {
            Session["IdProducto_padre"] = IdProducto_padre;
            cargar_combos_detalle(IdProducto_padre);

            return Json("", JsonRequestBehavior.AllowGet);
        }
    }


    public class in_Ing_Egr_Inven_distribucion_lst
    {
        public List<in_Ing_Egr_Inven_distribucion_Info> get_list()
        {
            if (HttpContext.Current.Session["list_distribuida"] == null)
            {
                List<in_Ing_Egr_Inven_distribucion_Info> list = new List<in_Ing_Egr_Inven_distribucion_Info>();

                HttpContext.Current.Session["list_distribuida"] = list;
            }
            return (List<in_Ing_Egr_Inven_distribucion_Info>)HttpContext.Current.Session["list_distribuida"];
        }

        public void set_list(List<in_Ing_Egr_Inven_distribucion_Info> list)
        {
            HttpContext.Current.Session["list_distribuida"] = list;
        }

        public void AddRow(in_Ing_Egr_Inven_distribucion_Info info_det)
        {
            List<in_Ing_Egr_Inven_distribucion_Info> list = get_list();
            info_det.secuencia_distribucion = list.Count == 0 ? 1 : list.Max(q => q.secuencia_distribucion) + 1;
            info_det.IdProducto = info_det.IdProducto;
            info_det.IdUnidadMedida = info_det.IdUnidadMedida;
            info_det.mv_costo = info_det.mv_costo;
            info_det.dm_cantidad = info_det.dm_cantidad;

            list.Add(info_det);
        }
        
        public void UpdateRow(in_Ing_Egr_Inven_distribucion_Info info_det)
        {
            in_Ing_Egr_Inven_distribucion_Info edited_info = get_list().Where(m => m.secuencia_distribucion == info_det.secuencia_distribucion).First();
           
            edited_info.IdProducto = info_det.IdProducto;
            edited_info.IdUnidadMedida = info_det.IdUnidadMedida;
            edited_info.mv_costo = info_det.mv_costo;
            edited_info.dm_cantidad = info_det.dm_cantidad;

        }

        public void DeleteRow(int secuencia_distribucion)
        {
            List<in_Ing_Egr_Inven_distribucion_Info> list = get_list();
            list.Remove(list.Where(m => m.secuencia_distribucion == secuencia_distribucion).First());
        }
    }
}