using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Contabilidad;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class TipoNotaController : Controller
    {
        fa_TipoNota_Bus bus_tiponota = new fa_TipoNota_Bus();
        fa_TipoNota_x_Empresa_x_Sucursal_List List_fa_TipoNota_x_Empresa_x_Sucursal = new fa_TipoNota_x_Empresa_x_Sucursal_List();
        fa_TipoNota_x_Empresa_x_Sucursal_Bus bus_fa_tipo = new fa_TipoNota_x_Empresa_x_Sucursal_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tiponota()
        {
            List<fa_TipoNota_Info> model = bus_tiponota.get_list(true);
            return PartialView("_GridViewPartial_tiponota", model);
        }

        private void cargar_combos()
        {
            Dictionary<string, string> lst_tipos = new Dictionary<string, string>();
            lst_tipos.Add("C", "Credito");
            lst_tipos.Add("D", "Debito");
            ViewBag.lst_tipos = lst_tipos;
        }
        public ActionResult Nuevo()
        {
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            cargar_combos();
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = new List<fa_TipoNota_x_Empresa_x_Sucursal_Info>();
            List_fa_TipoNota_x_Empresa_x_Sucursal.set_list(model.Lst_fa_TipoNota_x_Empresa_x_Sucursal);
            cargar_combos_det();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(fa_TipoNota_Info model)
        {
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            if (!bus_tiponota.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int  IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_TipoNota_Info model = bus_tiponota.get_info(IdTipoNota);
            if (model == null)
                return RedirectToAction("Index");
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = bus_fa_tipo.get_list(IdEmpresa, IdTipoNota);
            List_fa_TipoNota_x_Empresa_x_Sucursal.set_list(model.Lst_fa_TipoNota_x_Empresa_x_Sucursal);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_TipoNota_Info model)
        {
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            if (!bus_tiponota.modificarDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_TipoNota_Info model = bus_tiponota.get_info(IdTipoNota);
            if (model == null)
                return RedirectToAction("Index");
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = bus_fa_tipo.get_list(IdEmpresa, IdTipoNota);
            List_fa_TipoNota_x_Empresa_x_Sucursal.set_list(model.Lst_fa_TipoNota_x_Empresa_x_Sucursal);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_TipoNota_Info model)
        {
            if (!bus_tiponota.anularDB(model))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        #region detalle
        private void cargar_combos_det()
        {

            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            ct_plancta_Bus bus_cuenta = new ct_plancta_Bus();
            var lst_cuenta = bus_cuenta.get_list(IdEmpresa, false, true);
            ViewBag.lst_cuenta = lst_cuenta;
        }
        public ActionResult GridViewPartial_tipo_nota_sucursal(int IdTipoNota = 0)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = bus_fa_tipo.get_list(IdEmpresa, IdTipoNota);
            if (model.Lst_fa_TipoNota_x_Empresa_x_Sucursal.Count == 0)
                model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            cargar_combos_det();
            return PartialView("_GridViewPartial_tipo_nota_sucursal", model);
        }


        [HttpPost, ValidateInput(false)]
        public ActionResult Editing_AddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_TipoNota_x_Empresa_x_Sucursal_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_TipoNota_x_Empresa_x_Sucursal.AddRow(info_det);
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            cargar_combos_det();
            return PartialView("_GridViewPartial_tipo_nota_sucursal", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Editing_Update([ModelBinder(typeof(DevExpressEditorsBinder))] fa_TipoNota_x_Empresa_x_Sucursal_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_TipoNota_x_Empresa_x_Sucursal.UpdateRow(info_det);
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            cargar_combos_det();
            return PartialView("_GridViewPartial_tipo_nota_sucursal", model);
        }

        public ActionResult Editing_Delete(int IdSucursal)
        {
            List_fa_TipoNota_x_Empresa_x_Sucursal.DeleteRow(IdSucursal);
            fa_TipoNota_Info model = new fa_TipoNota_Info();
            model.Lst_fa_TipoNota_x_Empresa_x_Sucursal = List_fa_TipoNota_x_Empresa_x_Sucursal.get_list();
            cargar_combos_det();
            return PartialView("_GridViewPartial_tipo_nota_sucursal", model);
        }

        #endregion
    }

    #region List
    public class fa_TipoNota_x_Empresa_x_Sucursal_List
    {
        public List<fa_TipoNota_x_Empresa_x_Sucursal_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_TipoNota_x_Empresa_x_Sucursal_Info"] == null)
            {
                List<fa_TipoNota_x_Empresa_x_Sucursal_Info> list = new List<fa_TipoNota_x_Empresa_x_Sucursal_Info>();

                HttpContext.Current.Session["fa_TipoNota_x_Empresa_x_Sucursal_Info"] = list;
            }
            return (List<fa_TipoNota_x_Empresa_x_Sucursal_Info>)HttpContext.Current.Session["fa_TipoNota_x_Empresa_x_Sucursal_Info"];
        }

        public void set_list(List<fa_TipoNota_x_Empresa_x_Sucursal_Info> list)
        {
            HttpContext.Current.Session["fa_TipoNota_x_Empresa_x_Sucursal_Info"] = list;
        }
        public void AddRow(fa_TipoNota_x_Empresa_x_Sucursal_Info info_det)
        {
            List<fa_TipoNota_x_Empresa_x_Sucursal_Info> list = get_list();
            info_det.IdSucursal = list.Count == 0 ? 1 : list.Max(q => q.IdTipoNota) + 1;
            info_det.IdEmpresa = info_det.IdEmpresa;
            info_det.IdSucursal = info_det.IdSucursal;
            info_det.IdCtaCble = info_det.IdCtaCble;

            list.Add(info_det);
        }

        public void UpdateRow(fa_TipoNota_x_Empresa_x_Sucursal_Info info_det)
        {
            fa_TipoNota_x_Empresa_x_Sucursal_Info edited_info = get_list().Where(m => m.IdTipoNota == info_det.IdTipoNota).First();
            info_det.IdEmpresa = info_det.IdEmpresa;
            info_det.IdSucursal = info_det.IdSucursal;
            edited_info.IdCtaCble = info_det.IdCtaCble;

        }

        public void DeleteRow(int IdTipoNota)
        {
            List<fa_TipoNota_x_Empresa_x_Sucursal_Info> list = get_list();
            list.Remove(list.Where(m => m.IdTipoNota == IdTipoNota).First());
        }
    }
    #endregion

}