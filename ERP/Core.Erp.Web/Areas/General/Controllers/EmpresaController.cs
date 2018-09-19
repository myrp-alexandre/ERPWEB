using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Erp.Info.General;
using Core.Erp.Bus.General;
using DevExpress.Web;
using Core.Erp.Web.Helps;

namespace Core.Erp.Web.Areas.General.Controllers
{
    [SessionTimeout]

    public class EmpresaController : Controller
    {
        #region Index
        tb_empresa_Bus bus_empresa = new tb_empresa_Bus();
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_empresa()
        {
            List<tb_empresa_Info> model = bus_empresa.get_list(true);
            return PartialView("_GridViewPartial_empresa", model);
        }

        #endregion
        #region Acciones

        public ActionResult Nuevo()
        {
            tb_empresa_Info model = new tb_empresa_Info
            {
                em_fechaInicioContable = DateTime.Now.Date,
                em_logo = new byte[0]
        };
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(tb_empresa_Info model)
        {
            model.em_logo = empresa_imagen.pr_imagen;
            if (Session["imagen"]!=null)
            model.em_logo = Session["imagen"] as byte[];
            if (!bus_empresa.guardarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0)
        {
            tb_empresa_Info model = bus_empresa.get_info(IdEmpresa);
            if (model.em_logo == null)
                model.em_logo = new byte[0];
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(tb_empresa_Info model)
        {
            model.em_logo = empresa_imagen.pr_imagen;
            if (!bus_empresa.modificarDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0)
        {
            tb_empresa_Info model = bus_empresa.get_info(IdEmpresa);
            if (model.em_logo == null)
                model.em_logo = new byte[0];
            if (model == null)
                return RedirectToAction("Index");
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(tb_empresa_Info model)
        {
            if (!bus_empresa.anularDB(model))
            {
                return View(model);
            }
            return RedirectToAction("Index");
        }
        #endregion

        const string UploadDirectory = "~/Content/imagenes/";

        public UploadedFile UploadControlUpload()
        {
            UploadControlExtension.GetUploadedFiles("UploadControl", empresa_imagen.UploadValidationSettings, empresa_imagen.FileUploadComplete);

            byte[] model = empresa_imagen.pr_imagen;
            UploadedFile file = new UploadedFile();
            return file;
        }

        public ActionResult get_imagen()
        {

            byte[] model = empresa_imagen.pr_imagen;
            if (model == null)
                model = new byte[0];
            return PartialView("_Empresa_imagen", model);
        }

        public class empresa_imagen
        {
            public static byte[] pr_imagen { get; set; }
            public static DevExpress.Web.UploadControlValidationSettings UploadValidationSettings = new DevExpress.Web.UploadControlValidationSettings()
            {
                AllowedFileExtensions = new string[] { ".jpg", ".jpeg" },
                MaxFileSize = 4000000
            };
            public static void FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
            {

                if (e.UploadedFile.IsValid)
                {
                    pr_imagen = e.UploadedFile.FileBytes;
                }
            }
        }
    }
  
}


