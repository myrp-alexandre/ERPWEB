using Core.Erp.Bus.Facturacion;
using Core.Erp.Bus.General;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using System;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Facturacion.Controllers
{
    public class CambioProductoController : Controller
    {
        #region Variables
        tb_sucursal_Bus bus_sucursal;
        fa_CambioProducto_Bus bus_CambioProducto;
        tb_bodega_Bus bus_bodega;
        #endregion

        #region Constructor
        public CambioProductoController()
        {
            bus_sucursal = new tb_sucursal_Bus();
            bus_CambioProducto = new fa_CambioProducto_Bus();
            bus_bodega = new tb_bodega_Bus();
        }
        #endregion

        #region Index
        public ActionResult Index()
        {
            cl_filtros_Info model = new cl_filtros_Info
            {
                IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal)
            };
            CargarCombos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(cl_filtros_Info model)
        {
            CargarCombos(model.IdEmpresa);
            return View(model);
        }

        private void CargarCombos(int IdEmpresa)
        {
            try
            {
                var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
                ViewBag.lst_sucursal = lst_sucursal;
            }
            catch (Exception)
            {
                throw;
            }
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_CambioProducto(DateTime? Fecha_ini, DateTime? Fecha_fin, int IdSucursal = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.Fecha_ini = Fecha_ini == null ? DateTime.Now.Date.AddMonths(-1) : Convert.ToDateTime(Fecha_ini);
            ViewBag.Fecha_fin = Fecha_fin == null ? DateTime.Now.Date : Convert.ToDateTime(Fecha_fin);
            ViewBag.IdSucursal = IdSucursal;
            var model = bus_CambioProducto.GetList(IdEmpresa, IdSucursal, ViewBag.Fecha_ini, ViewBag.Fecha_fin);
            return PartialView("_GridViewPartial_CambioProducto", model);
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            fa_CambioProducto_Info model = new fa_CambioProducto_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession),
                IdSucursal = string.IsNullOrEmpty(SessionFixed.IdSucursal) ? 0 : Convert.ToInt32(SessionFixed.IdSucursal),
                IdUsuario = SessionFixed.IdUsuario
            };
            CargarCombosAccion(model.IdEmpresa, model.IdSucursal);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(fa_CambioProducto_Info model)
        {   
            if(!bus_CambioProducto.GuardarDB(model))
            {
                CargarCombosAccion(model.IdEmpresa,model.IdSucursal);
                return View(model);
            }

            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, int IdSucursal = 0, int IdBodega = 0, decimal IdCambio = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            fa_CambioProducto_Info model = bus_CambioProducto.GetInfo(IdEmpresa, IdSucursal, IdBodega, IdCambio);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.IdUsuario = SessionFixed.IdUsuario;
            CargarCombosAccion(model.IdEmpresa, model.IdSucursal);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(fa_CambioProducto_Info model)
        {
            if (!bus_CambioProducto.ModificarDB(model))
            {
                CargarCombosAccion(model.IdEmpresa, model.IdSucursal);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdSucursal = 0, int IdBodega = 0, decimal IdCambio = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            fa_CambioProducto_Info model = bus_CambioProducto.GetInfo(IdEmpresa, IdSucursal, IdBodega, IdCambio);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.IdUsuario = SessionFixed.IdUsuario;
            CargarCombosAccion(model.IdEmpresa, model.IdSucursal);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(fa_CambioProducto_Info model)
        {
            if (!bus_CambioProducto.AnularDB(model))
            {
                CargarCombosAccion(model.IdEmpresa, model.IdSucursal);
                return View(model);
            }

            return RedirectToAction("Index");
        }
        #endregion

        #region Metodos
        private void CargarCombosAccion(int IdEmpresa, int IdSucursal)
        {
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_bodega = bus_bodega.get_list(IdEmpresa, IdSucursal, false);
            ViewBag.lst_bodega = lst_bodega;
        }
        #endregion

        #region Json
        public JsonResult CargarBodega(int IdEmpresa= 0, int IdSucursal = 0)
        {
            var resultado = bus_bodega.get_list(IdEmpresa, IdSucursal, false);
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}