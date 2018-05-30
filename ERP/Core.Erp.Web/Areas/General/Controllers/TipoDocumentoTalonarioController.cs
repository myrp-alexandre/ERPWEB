using Core.Erp.Bus.General;
using Core.Erp.Info.General;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class TipoDocumentoTalonarioController : Controller
    {
        tb_sis_Documento_Tipo_Talonario_Bus bus_talonario = new tb_sis_Documento_Tipo_Talonario_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_tipodocumentotal()
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            List<tb_sis_Documento_Tipo_Talonario_Info> model = bus_talonario.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_tipodocumentotal", model);
        }
        private void cargar_combos()
        {
            tb_sis_Documento_Tipo_Bus bus_tipodoc = new tb_sis_Documento_Tipo_Bus();
            var lst_talonario = bus_tipodoc.get_list(false);
            ViewBag.lst_talonario = lst_talonario;
            
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;
        }

        public ActionResult Nuevo()
        {
            tb_sis_Documento_Tipo_Talonario_Info model = new tb_sis_Documento_Tipo_Talonario_Info();
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_sis_Documento_Tipo_Talonario_Info model)
        {
            model.IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            decimal documento_inicial = Convert.ToDecimal(model.NumDocumento);
            decimal documento_final = Convert.ToDecimal(model.Documentofinal);
            for (decimal i = documento_inicial; i < documento_final; i++)
            {
                tb_sis_Documento_Tipo_Talonario_Info info = new tb_sis_Documento_Tipo_Talonario_Info
                {
                    IdEmpresa = model.IdEmpresa,
                    CodDocumentoTipo = model.CodDocumentoTipo,
                    Establecimiento = model.Establecimiento,
                    PuntoEmision = model.PuntoEmision,
                    NumDocumento = i.ToString("000000000"),
                   es_Documento_Electronico = model.es_Documento_Electronico,
                   FechaCaducidad = model.FechaCaducidad,
                   IdSucursal = model.IdSucursal,
                   NumAutorizacion = model.NumAutorizacion,
                   Usado = model.Usado,                    
                };
                if (!bus_talonario.guardarDB(info))
                {
                    return View(model);
                }
            }           

            return RedirectToAction("Index");
        }

        public ActionResult Modificar(string CodDocumentoTipo = "", string Establecimiento = "", string PuntoEmision = "", string NumDocumento = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sis_Documento_Tipo_Talonario_Info model = bus_talonario.get_info(IdEmpresa, CodDocumentoTipo, Establecimiento, PuntoEmision, NumDocumento);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(tb_sis_Documento_Tipo_Talonario_Info model)
        {
            if (!bus_talonario.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");

        }

        public ActionResult Anular(string CodDocumentoTipo = "", string Establecimiento = "", string PuntoEmision = "", string NumDocumento = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            tb_sis_Documento_Tipo_Talonario_Info model = bus_talonario.get_info(IdEmpresa, CodDocumentoTipo, Establecimiento, PuntoEmision, NumDocumento);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(tb_sis_Documento_Tipo_Talonario_Info model)
        {
            if (!bus_talonario.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public JsonResult get_NumeroDocumentoInicial (string CodDocumentoTipo="", string Establecimiento="", string PuntoEmision = "")
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            var NumeroDocumento = bus_talonario.get_NumeroDocumentoInicial(IdEmpresa, CodDocumentoTipo, Establecimiento, PuntoEmision);

            return Json(NumeroDocumento, JsonRequestBehavior.AllowGet);
        }
    }
}