using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Bus.General;
using Core.Erp.Bus.ActivoFijo;
using Core.Erp.Info.ActivoFijo;
using Core.Erp.Info.Helps;
using Core.Erp.Web.Helps;
using DevExpress.Web;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]
    public class ActivoFijoController : Controller
    {
        #region Variables
        Af_Activo_fijo_Bus bus_activo = new Af_Activo_fijo_Bus();
        Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
        Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
        Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        #endregion

        #region Index

        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_activo_fijo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var model = bus_activo.get_list(IdEmpresa, true);
            return PartialView("_GridViewPartial_activo_fijo", model);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa, int IdActivoFijoTipo = 0)
        {
            var lst_tipo = bus_tipo.get_list(IdEmpresa, false);
            ViewBag.lst_tipo = lst_tipo;

            var lst_sucursal = bus_sucursal.get_list(IdEmpresa, false);
            ViewBag.lst_sucursal = lst_sucursal;

            var lst_categoria = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            ViewBag.lst_categoria = lst_categoria;

            var lst_color = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_COLOR), false);
            ViewBag.lst_color = lst_color;

            var lst_modelo = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MODELO), false);
            ViewBag.lst_modelo = lst_modelo;

            var lst_estado = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_ESTADO_AF), false);
            ViewBag.lst_estado = lst_estado;

            var lst_marca = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_MARCA), false);
            ViewBag.lst_marca = lst_marca;

            var lst_ubicacion = bus_catalogo.get_list(Convert.ToString(cl_enumeradores.eTipoCatalogoAF.TIP_UBICACION), false);
            ViewBag.lst_ubicacion = lst_ubicacion;
        }

        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info
            {
                IdEmpresa = IdEmpresa,
                Af_fecha_compra = DateTime.Now,
                Af_fecha_fin_depre = DateTime.Now,
                Af_fecha_ini_depre = DateTime.Now,
                Estado_Proceso = "TIP_ESTADO_AF_ACTIVO",
                Af_foto = new byte[0]
        };
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Info model)
        {

            model.Af_foto = Activo_imagen.Af_foto;
            if (!bus_activo.guardarDB(model))
            {
                if (model.Af_foto == null)
                    model.Af_foto = new byte[0];
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            Activo_imagen.Af_foto = null;
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            if (model.Af_foto == null)
                model.Af_foto = new byte[0];
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Info model)
        {
            model.Af_foto = Activo_imagen.Af_foto;
            if (!bus_activo.modificarDB(model))
            {
                if (model.Af_foto == null)
                    model.Af_foto = new byte[0];
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            Activo_imagen.Af_foto = null;
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            if (model.Af_foto == null)
                model.Af_foto = new byte[0];
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Info model)
        {
            model.Af_foto = Activo_imagen.Af_foto;

            if (!bus_activo.anularDB(model))
            {
                if (model.Af_foto == null)
                    model.Af_foto = new byte[0];
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            Activo_imagen.Af_foto = null;
            return RedirectToAction("Index");
        }
        #endregion

        #region Json
        public JsonResult cargar_categoria( int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var resultado = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);
            
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult get_info_tipo( int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_tipo_Bus bus_tipo  = new Af_Activo_fijo_tipo_Bus();
            var resultado = bus_tipo.get_info(IdEmpresa, IdActivoFijoTipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

            const string UploadDirectory = "~/Content/imagenes/";
        public UploadedFile UploadControlUpload()
        {
            UploadControlExtension.GetUploadedFiles("UploadControl", Activo_imagen.UploadValidationSettings, Activo_imagen.FileUploadComplete);

            byte[] model = Activo_imagen.Af_foto;
            UploadedFile file = new UploadedFile();
            return file;
        }

        public ActionResult get_imagen()
        {

            byte[] model = Activo_imagen.Af_foto;
            if (model == null)
                model = new byte[0];
            return PartialView("_Activo_imagen", model);
        }

    }
    public class Activo_imagen
    {
        public static byte[] Af_foto { get; set; }
        public static DevExpress.Web.UploadControlValidationSettings UploadValidationSettings = new DevExpress.Web.UploadControlValidationSettings()
        {
            AllowedFileExtensions = new string[] { ".jpg", ".jpeg" },
            MaxFileSize = 4000000
        };
        public static void FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {

            if (e.UploadedFile.IsValid)
            {
                Af_foto = e.UploadedFile.FileBytes;
            }
        }


    }
}