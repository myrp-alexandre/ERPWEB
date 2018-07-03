using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.General;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class ReportesPorUsuarioController : Controller
    {
        static tb_sis_reporte_x_seg_usuario_Bus bus_reporte_x_usuario = new tb_sis_reporte_x_seg_usuario_Bus();

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
        

        [ValidateInput(false)]
        public ActionResult GridViewPartial_reportes_por_usuario(int IdEmpresa = 0, string IdUsuario = "")
        {
            var model = bus_reporte_x_usuario.get_list(IdEmpresa, IdUsuario);
            ViewBag.IdEmpresa = IdEmpresa;
            ViewBag.IdUsuario = IdUsuario;
            
            return PartialView("_GridViewPartial_reportes_por_usuario", model);
        }
    }
}