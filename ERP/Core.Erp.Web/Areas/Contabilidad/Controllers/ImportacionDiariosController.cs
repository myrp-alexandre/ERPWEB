using Core.Erp.Bus.Migraciones;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    public class ImportacionDiariosController : Controller
    {
        #region Variables
        ImportacionDiarios_Bus bus_ImporacionDiarios = new ImportacionDiarios_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
            };

            cargar_filtros();
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_filtros();
            return View(model);
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_ImportacionDiarios(string TipoRubro)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.tipo_documento = TipoRubro == "" || TipoRubro == null ? "" : TipoRubro;

            var model = bus_ImporacionDiarios.get_list(ViewBag.tipo_documento);
            return PartialView("_GridViewPartial_ImportacionDiarios", model);
        }

        #region Metodos
        private void cargar_filtros()
        {
            try
            {
                Dictionary<string, string> lst_tipo_documento = new Dictionary<string, string>();
                lst_tipo_documento.Add("FACTURAS", "FACTURAS");
                lst_tipo_documento.Add("COBROS", "COBROS");
                lst_tipo_documento.Add("NOTADEBITO", "NOTA DE DEBITO");
                lst_tipo_documento.Add("NOTACREDITO", "NOTA DE CREDITO");
                ViewBag.lst_tipo_movimiento = lst_tipo_documento;
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        #endregion
    }
}