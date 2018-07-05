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

        public ActionResult GridViewPartial_reportes_por_usuario(int IdEmpresa=0, string IdUsuario="")
        {
            List<tb_sis_reporte_x_seg_usuario_Info> model = new List<tb_sis_reporte_x_seg_usuario_Info>();
            model = bus_reporte_x_usuario.get_list(IdEmpresa, IdUsuario);
            return PartialView("_GridViewPartial_reportes_por_usuario", model);
        }
        public JsonResult guardar(int IdEmpresa = 0, string IdUsuario = "", string Ids = "")
        {
            string[] array = Ids.Split(',');

            List<tb_sis_reporte_x_seg_usuario_Info> lista = new List<tb_sis_reporte_x_seg_usuario_Info>();
            var output = array.GroupBy(q => q).ToList();
            foreach (var item in output)
            {
                tb_sis_reporte_x_seg_usuario_Info info = new tb_sis_reporte_x_seg_usuario_Info
                {
                    IdEmpresa = IdEmpresa,
                    CodReporte = Convert.ToString(item.Key),
                    IdUsuario = IdUsuario
                };
                lista.Add(info);
            }
            bus_reporte_x_usuario.eliminarDB(IdEmpresa, IdUsuario);
            var resultado = bus_reporte_x_usuario.guardarDB(lista, IdEmpresa, IdUsuario);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }
}