using Core.Erp.Bus.General;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.General;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class ReportesPorUsuarioController : Controller
    {
        tb_sis_reporte_x_seg_usuario_List List_det = new tb_sis_reporte_x_seg_usuario_List();

        tb_sis_reporte_x_seg_usuario_Bus bus_reporte_x_usuario = new tb_sis_reporte_x_seg_usuario_Bus();
        public ActionResult Index()
        {
            tb_sis_reporte_x_seg_usuario_Info model = new tb_sis_reporte_x_seg_usuario_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(tb_sis_reporte_x_seg_usuario_Info model)
        {
            cargar_combos();
            List_det.set_list(bus_reporte_x_usuario.get_list(model.IdEmpresa, model.IdUsuario));
            return View(model);
        }
        private void cargar_combos()
        {
            tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
            var lst_empresa = bus_empresa.get_list(false);
            ViewBag.lst_empresa = lst_empresa;

            seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
            var lst_usuario = bus_usuario.get_list(false);
            ViewBag.lst_usuario = lst_usuario;
        }
        public ActionResult GridViewPartial_ReportesPorAsignar()
        {
            var model = List_det.get_list().Where(q => q.seleccionado == false).ToList();
            return PartialView("_GridViewPartial_ReportesPorAsignar", model);
        }

        public ActionResult GridViewPartial_ReportesAsignados()
        {
            var model = List_det.get_list().Where(q => q.seleccionado == true).ToList();
            return PartialView("_GridViewPartial_ReportesAsignados", model);
        }
        public void EditingUpdate(string CodReporte = "")
        {
            List_det.UpdateRow(CodReporte);
        }
        public JsonResult guardar(int IdEmpresa = 0, string IdUsuario = "")
        {
            bus_reporte_x_usuario.eliminarDB(IdEmpresa, IdUsuario);
            var resultado = bus_reporte_x_usuario.guardarDB(List_det.get_list().Where(q => q.seleccionado == true).ToList(), IdEmpresa, IdUsuario);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }

    public class tb_sis_reporte_x_seg_usuario_List
    {
        public List<tb_sis_reporte_x_seg_usuario_Info> get_list()
        {
            if (HttpContext.Current.Session["tb_sis_reporte_x_seg_usuario_Info"] == null)
            {
                List<tb_sis_reporte_x_seg_usuario_Info> list = new List<tb_sis_reporte_x_seg_usuario_Info>();

                HttpContext.Current.Session["tb_sis_reporte_x_seg_usuario_Info"] = list;
            }
            return (List<tb_sis_reporte_x_seg_usuario_Info>)HttpContext.Current.Session["tb_sis_reporte_x_seg_usuario_Info"];
        }

        public void set_list(List<tb_sis_reporte_x_seg_usuario_Info> list)
        {
            HttpContext.Current.Session["tb_sis_reporte_x_seg_usuario_Info"] = list;
        }

        public void UpdateRow(string CodReporte)
        {
            tb_sis_reporte_x_seg_usuario_Info edited_info = get_list().Where(m => m.CodReporte == CodReporte).FirstOrDefault();
            if (edited_info != null)
                edited_info.seleccionado = !edited_info.seleccionado;
        }
    }
}