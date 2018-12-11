using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.Contabilidad;
using Core.Erp.Web.Helps;
using DevExpress.Web.Mvc;
using ExcelDataReader;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Contabilidad.Controllers
{
    [SessionTimeout]
    public class PlanDeCuentasController : Controller
    {
        ct_plancta_List ListaPlancta = new ct_plancta_List();

        #region Index
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult Index()
        {
            return View();
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_plancta()
        {
            int IdEmpresa = string.IsNullOrEmpty(SessionFixed.IdEmpresa) ? 0 : Convert.ToInt32(SessionFixed.IdEmpresa);
            List<ct_plancta_Info> model = bus_plancta.get_list(IdEmpresa, true, false);
            return PartialView("_GridViewPartial_plancta", model);
        }
        private void cargar_combos(int IdEmpresa)
        {
            var lst_cuentas = bus_plancta.get_list(IdEmpresa, false, false);
            ViewBag.lst_cuentas = lst_cuentas;

            Dictionary<string, string> lst_naturaleza = new Dictionary<string, string>();
            lst_naturaleza.Add("D","Deudora");
            lst_naturaleza.Add("C", "Acreedora");
            ViewBag.lst_naturaleza = lst_naturaleza;

            ct_grupocble_Bus bus_grupo_contable = new ct_grupocble_Bus();
            var lst_grupo_contabe = bus_grupo_contable.get_list(false);
            ViewBag.lst_grupo_contabe = lst_grupo_contabe;
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            ct_plancta_Info model = new ct_plancta_Info
            {
                IdEmpresa = IdEmpresa
            };
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(ct_plancta_Info model)
        {
            if (bus_plancta.validar_existe_id(model.IdEmpresa,model.IdCtaCble))
            {
                ViewBag.mensaje = "El código de la cuenta ya se encuentra registrado";
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            if (!bus_plancta.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Modificar(int IdEmpresa = 0, string IdCtaCble = "")
        {   
            ct_plancta_Info model = bus_plancta.get_info(IdEmpresa, IdCtaCble);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Modificar(ct_plancta_Info model)
        {
            if (!bus_plancta.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }
        public ActionResult Anular(int IdEmpresa = 0, string IdCtaCble = "")
        {
            ct_plancta_Info model = bus_plancta.get_info(IdEmpresa, IdCtaCble);
            if (model == null)
                return RedirectToAction("Index");
            cargar_combos(model.IdEmpresa);
            return View(model);
        }
        [HttpPost]
        public ActionResult Anular(ct_plancta_Info model)
        {
            if (!bus_plancta.anularDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion

        #region Importacion
        public ActionResult UploadControlUpload()
        {
            UploadControlExtension.GetUploadedFiles("UploadControlFile", UploadControlSettings.UploadValidationSettings, UploadControlSettings.FileUploadComplete);
            return null;
        }
        public ActionResult Importar(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            ct_plancta_Info model = new ct_plancta_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)
            };
            return View(model);
        }
        public ActionResult GridViewPartial_plancta_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaPlancta.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_plancta_importacion", model);
        }
        #endregion

        public JsonResult get_info_nuevo(int IdEmpresa = 0, string IdCtaCble_padre = "")
        {
            var resultado = bus_plancta.get_info_nuevo(IdEmpresa, IdCtaCble_padre);
            
            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
    }

    public class UploadControlSettings
    {
        public static DevExpress.Web.UploadControlValidationSettings UploadValidationSettings = new DevExpress.Web.UploadControlValidationSettings()
        {
            AllowedFileExtensions = new string[] { ".xlsx" },
            MaxFileSize = 40000000
        };
        public static void FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            int cont = 0;
            decimal IdTransaccionSession = string.IsNullOrEmpty(HttpContext.Current.Request.Params["TransaccionFixed"].ToString()) ? 0 : Convert.ToDecimal(HttpContext.Current.Request.Params["TransaccionFixed"]);
            int IdEmpresa = string.IsNullOrEmpty(HttpContext.Current.Request.Params["Empresa"].ToString()) ? 0 : Convert.ToInt32(HttpContext.Current.Request.Params["Empresa"]);

            ct_plancta_List ListaPlancta = new ct_plancta_List();
            List<ct_plancta_Info> Lista = new List<ct_plancta_Info>();

            Stream stream = new MemoryStream(e.UploadedFile.FileBytes);

            if (stream.Length > 0)
            {
                IExcelDataReader reader = null;
                reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        ct_plancta_Info info = new ct_plancta_Info
                        {
                            IdEmpresa = IdEmpresa,
                            IdCtaCble = reader.GetString(0),
                            pc_clave_corta = reader.GetString(1),
                            pc_Cuenta = reader.GetString(2),
                            IdCtaCblePadre = reader.GetValue(3) == null ? null : (string.IsNullOrEmpty(reader.GetString(3)) ? null : reader.GetString(3)),
                            pc_Naturaleza = reader.GetString(4),
                            IdNivelCta = Convert.ToInt32(reader.GetValue(5)),
                            pc_EsMovimiento_bool = reader.GetString(6) == "SI" ? true : false,
                            pc_EsMovimiento = reader.GetString(6) == "SI" ? "S" : "N",
                            IdGrupoCble = reader.GetString(7)
                        };
                        Lista.Add(info);
                    }
                    else
                        cont++;
                }
                ListaPlancta.set_list(Lista,IdTransaccionSession);
            }
        }
    }

    public class ct_plancta_List
    {
        string Variable = "ct_plancta_Info";
        public List<ct_plancta_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession] == null)
            {
                List<ct_plancta_Info> list = new List<ct_plancta_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession] = list;
            }
            return (List<ct_plancta_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession];
        }

        public void set_list(List<ct_plancta_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession] = list;
        }


        public void UpdateRow(ct_plancta_Info info_det, decimal IdTransaccionSession)
        {
            ct_plancta_Info edited_info = get_list(IdTransaccionSession).Where(m => m.IdCtaCble == info_det.IdCtaCble).First();
        }

        public void DeleteRow(string IdCtaCble, decimal IdTransaccionSession)
        {
            List<ct_plancta_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.IdCtaCble == IdCtaCble).First());
        }
    }
}