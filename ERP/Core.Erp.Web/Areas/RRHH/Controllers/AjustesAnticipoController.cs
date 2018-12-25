using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class AjustesAnticipoController : Controller
    {
        // GET: RRHH/AjustesAnticipo

        #region clases
        ro_rol_detalle_Info_list ro_rol_detalle_Info_list = new ro_rol_detalle_Info_list();
        #endregion
        public ActionResult Index()
        {
            return View();
        }
        
        #region funciones del detalle

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ro_rol_detalle_Info info_det)
        {
            if (ModelState.IsValid)
                ro_rol_detalle_Info_list.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            List<ro_rol_detalle_Info> model = new List<ro_rol_detalle_Info>();
            model = ro_rol_detalle_Info_list.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_ajuste_anticipo", model);
        }

       
        #endregion
    }

    public class ro_rol_detalle_Info_list
    {
        string variable = "ro_rol_detalle_Info";
        public List<ro_rol_detalle_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] == null)
            {
                List<ro_rol_detalle_Info> list = new List<ro_rol_detalle_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ro_rol_detalle_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ro_rol_detalle_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
        }

        public void UpdateRow(ro_rol_detalle_Info info_det, decimal IdTransaccionSession)
        {
            ro_rol_detalle_Info edited_info = get_list(IdTransaccionSession).Where(m => m.IdEmpleado == info_det.IdEmpleado).First();
            edited_info.Valor = info_det.Valor;


        }

    }
}