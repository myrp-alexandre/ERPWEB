using Core.Erp.Bus.General;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.SeguridadAcceso;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.SeguridadAcceso.Controllers
{
    public class ReportesPorUsuarioController : Controller
    {
        static tb_sis_reporte_x_seg_usuario_Bus bus_menu_x_empresa_x_usuario = new tb_sis_reporte_x_seg_usuario_Bus();
        public ActionResult Index()
        {
            seg_Menu_x_Empresa_x_Usuario_Info model = new seg_Menu_x_Empresa_x_Usuario_Info();
            cargar_combos();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(seg_Menu_x_Empresa_x_Usuario_Info model)
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


    }
}