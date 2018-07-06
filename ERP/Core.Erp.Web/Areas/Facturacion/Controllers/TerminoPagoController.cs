using Core.Erp.Bus.Facturacion;
using Core.Erp.Info.Facturacion;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class TerminoPagoController : Controller
    {
        fa_TerminoPago_Bus bus_terminopago = new fa_TerminoPago_Bus();
        fa_TerminoPago_Distribucion_Bus bus_termino_dist = new fa_TerminoPago_Distribucion_Bus();
        fa_TerminoPago_Distribucion_list List_fa_TerminoPago_Distribucion = new fa_TerminoPago_Distribucion_list();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_terminopago()
        {
            List<fa_TerminoPago_Info> model = bus_terminopago.get_list(true);
            return PartialView("_GridViewPartial_terminopago", model);
        }

        public ActionResult Nuevo()
        {
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();

            model.Lst_fa_TerminoPago_Distribucion = new List<fa_TerminoPago_Distribucion_Info>();
            List_fa_TerminoPago_Distribucion.set_list(model.Lst_fa_TerminoPago_Distribucion);
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(fa_TerminoPago_Info model)
        {
            model.Lst_fa_TerminoPago_Distribucion = List_fa_TerminoPago_Distribucion.get_list();

            if (bus_terminopago.validar_existe_IdTerminoPago(model.IdTerminoPago))
            {
                ViewBag.mensaje = "El código ya se encuentra registrado";
                return View(model);
            }
            if (!bus_terminopago.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string IdTerminoPago = "")
        {
            fa_TerminoPago_Info model = bus_terminopago.get_info(IdTerminoPago);
            if (model == null)
                return RedirectToAction("Index");
            model.Lst_fa_TerminoPago_Distribucion = bus_termino_dist.get_list(IdTerminoPago);
            List_fa_TerminoPago_Distribucion.set_list(model.Lst_fa_TerminoPago_Distribucion);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_TerminoPago_Info model)
        {
            model.Lst_fa_TerminoPago_Distribucion = new List<fa_TerminoPago_Distribucion_Info>();

            if (!bus_terminopago.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(string IdTerminoPago = "")
        {
            fa_TerminoPago_Info model = bus_terminopago.get_info(IdTerminoPago);
            if (model == null)
            {
                return RedirectToAction("Index");

            }
            return View(model);
        }


        [HttpPost]
        public ActionResult Anular(fa_TerminoPago_Info model)
        {
            if (!bus_terminopago.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_pago_dist(string IdTerminoPago= "")
        {
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();
            model.Lst_fa_TerminoPago_Distribucion = bus_termino_dist.get_list( IdTerminoPago);
            if (model.Lst_fa_TerminoPago_Distribucion.Count == 0)
                model.Lst_fa_TerminoPago_Distribucion = List_fa_TerminoPago_Distribucion.get_list();
            return PartialView("_GridViewPartial_pago_dist", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] fa_TerminoPago_Distribucion_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_TerminoPago_Distribucion.AddRow(info_det);
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();
            model.Lst_fa_TerminoPago_Distribucion = List_fa_TerminoPago_Distribucion.get_list();
            return PartialView("_GridViewPartial_pago_dist", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] fa_TerminoPago_Distribucion_Info info_det)
        {
            if (ModelState.IsValid)
                List_fa_TerminoPago_Distribucion.UpdateRow(info_det);
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();
            model.Lst_fa_TerminoPago_Distribucion = List_fa_TerminoPago_Distribucion.get_list();
            return PartialView("_GridViewPartial_pago_dist", model);
        }

        public ActionResult EditingDelete(int IdSucursal)
        {
            List_fa_TerminoPago_Distribucion.DeleteRow(IdSucursal);
            fa_TerminoPago_Info model = new fa_TerminoPago_Info();
            return PartialView("_GridViewPartial_pago_dist", model);
        }
    }
       public class fa_TerminoPago_Distribucion_list
    {
        public List<fa_TerminoPago_Distribucion_Info> get_list()
        {
            if (HttpContext.Current.Session["fa_TerminoPago_Distribucion_Info"] == null)
            {
                List<fa_TerminoPago_Distribucion_Info> list = new List<fa_TerminoPago_Distribucion_Info>();

                HttpContext.Current.Session["fa_TerminoPago_Distribucion_Info"] = list;
            }
            return (List<fa_TerminoPago_Distribucion_Info>)HttpContext.Current.Session["fa_TerminoPago_Distribucion_Info"];
        }

        public void set_list(List<fa_TerminoPago_Distribucion_Info> list)
        {
            HttpContext.Current.Session["fa_TerminoPago_Distribucion_Info"] = list;
        }
        public void AddRow(fa_TerminoPago_Distribucion_Info info_det)
        {
            List<fa_TerminoPago_Distribucion_Info> list = get_list();
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdTerminoPago = info_det.IdTerminoPago;

            list.Add(info_det);
        }

        public void UpdateRow(fa_TerminoPago_Distribucion_Info info_det)
        {
            fa_TerminoPago_Distribucion_Info edited_info = get_list().Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdTerminoPago = info_det.IdTerminoPago;

        }

        public void DeleteRow(int Secuencia)
        {
            List<fa_TerminoPago_Distribucion_Info> list = get_list();
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}