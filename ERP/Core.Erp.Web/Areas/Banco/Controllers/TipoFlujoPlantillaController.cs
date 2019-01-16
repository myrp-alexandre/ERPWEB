using Core.Erp.Bus.Banco;
using Core.Erp.Info.Banco;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Banco.Controllers
{
    public class TipoFlujoPlantillaController : Controller
    {
        #region Variables
        ba_TipoFlujo_Plantilla_Bus bus_TipoFlujo_Plantilla = new ba_TipoFlujo_Plantilla_Bus();
        //ba_TipoFlujo_PlantillaDet_Bus bus_TipoFlujo_PlantillaDet = new ba_TipoFlujo_PlantillaDet_Bus();
        ba_TipoFlujo_PlantillaDet_List Lista_TipoFlujo_PlantillaDet = new ba_TipoFlujo_PlantillaDet_List();
        string mensaje = string.Empty;
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_TipoFlujoPlantilla()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<ba_TipoFlujo_Plantilla_Info> model = bus_TipoFlujo_Plantilla.GetList(IdEmpresa, true);

            return PartialView("_GridViewPartial_TipoFlujoPlantilla", model);
        }
        #endregion
    }

    public class ba_TipoFlujo_PlantillaDet_List
    {
        string Variable = "ba_TipoFlujo_PlantillaDet_Info";
        public List<ba_TipoFlujo_PlantillaDet_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<ba_TipoFlujo_PlantillaDet_Info> list = new List<ba_TipoFlujo_PlantillaDet_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<ba_TipoFlujo_PlantillaDet_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<ba_TipoFlujo_PlantillaDet_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(ba_TipoFlujo_PlantillaDet_Info info_det, decimal IdTransaccionSession)
        {
            List<ba_TipoFlujo_PlantillaDet_Info> list = get_list(IdTransaccionSession);
            if (list.Where(q => q.IdTipoFlujo == info_det.IdTipoFlujo).Count() == 0)
            {
                info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
                info_det.IdTipoFlujo = info_det.IdTipoFlujo;                

                list.Add(info_det);
            }
        }

        public void UpdateRow(ba_TipoFlujo_PlantillaDet_Info info_det, decimal IdTransaccionSession)
        {
            ba_TipoFlujo_PlantillaDet_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdTipoFlujo = info_det.IdTipoFlujo;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<ba_TipoFlujo_PlantillaDet_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}