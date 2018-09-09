using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using Core.Erp.Info.RRHH.RDEP;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class RdepController : Controller
    {
        Rdep_Info_lis Lis_Rdep_Info_lis = new Rdep_Info_lis();
        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_rdep()
        {
            Rdep_Info model = new Rdep_Info();
            return PartialView("_CmbEmpleado_rdep", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        #endregion
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index(Rdep_Info model)
        {
            return View();
        }
        public ActionResult GridViewPartial_rdep_det()
        {
            return View();
        }


    }


  public class  Rdep_Info_lis
  {
        string variable = "Rdep_Info";
        public List<ro_empleado_novedad_det_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] == null)
            {
                List<ro_empleado_novedad_det_Info> list = new List<ro_empleado_novedad_det_Info>();

                HttpContext.Current.Session[variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ro_empleado_novedad_det_Info>)HttpContext.Current.Session[variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ro_empleado_novedad_det_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[variable+IdTransaccionSession.ToString()] = list;
        }

    }
}