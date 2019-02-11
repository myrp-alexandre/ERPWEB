using Core.Erp.Bus.Contabilidad;
using Core.Erp.Bus.General;
using Core.Erp.Bus.Migraciones;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Migraciones;
using Core.Erp.Web.Helps;
using DevExpress.Web;
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
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        ImportacionDiarios_Bus bus_ImporacionDiarios = new ImportacionDiarios_Bus();
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
            };

            cargar_filtros(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            cargar_filtros(model.IdEmpresa);
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
        private void cargar_filtros(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;

                ct_cbtecble_tipo_Bus bus_tipo_comprobante = new ct_cbtecble_tipo_Bus();
                var lst_tipo_comprobante = bus_tipo_comprobante.get_list(IdEmpresa, false);
                ViewBag.lst_tipo_comprobante = lst_tipo_comprobante;

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

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbCuenta_comprobante_contable()
        {
            ImportacionDiarios_Info model = new ImportacionDiarios_Info();
            return PartialView("_CmbCuenta", model);
        }
        public List<ct_plancta_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_plancta.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), false);
        }
        public ct_plancta_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_plancta.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }
        #endregion
    }
}