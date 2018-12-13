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
using Core.Erp.Info.Contabilidad;
using Core.Erp.Bus.Contabilidad;
using Core.Erp.Info.General;
using System.IO;
using ExcelDataReader;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Areas.RRHH.Controllers;

namespace Core.Erp.Web.Areas.ActivoFijo.Controllers
{
    [SessionTimeout]
    public class ActivoFijoController : Controller
    {
        #region Variables
        Af_Activo_fijo_Bus bus_activo = new Af_Activo_fijo_Bus();
        Af_Activo_fijo_CtaCble_Bus bus_cta_cble = new Af_Activo_fijo_CtaCble_Bus();
        Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
        Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
        Af_Catalogo_Bus bus_catalogo = new Af_Catalogo_Bus();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        Af_Activo_fijo_CtaCble_List List_det = new Af_Activo_fijo_CtaCble_List();
        Af_Departamento_Bus bus_dep = new Af_Departamento_Bus();

        Af_Activo_fijo_tipo_List ListaTipo = new Af_Activo_fijo_tipo_List();
        Af_Activo_fijo_Categoria_List ListaCategoria = new Af_Activo_fijo_Categoria_List();
        Af_Departamento_List ListaDepartamento = new Af_Departamento_List();
        Af_Catalogo_List ListaCatalogo = new Af_Catalogo_List();
        Af_Activo_fijo_List ListaActivoFijo = new Af_Activo_fijo_List();

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
        #region Metodos ComboBox bajo demanda
        ct_plancta_Bus bus_plancta = new ct_plancta_Bus();
        public ActionResult CmbCuenta_AF()
        {
            string model = "";
            return PartialView("_CmbCuenta_AF", model);
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
        #region Metodos ComboBox bajo demanda
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public ActionResult CmbEmpleado_Enc_AF()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_Enc_AF", model);
        }
        public ActionResult CmbEmpleado_Cus_AF()
        {
            decimal model = new decimal();
            return PartialView("_CmbEmpleado_Cus_AF", model);
        }
        public List<tb_persona_Info> get_list_bajo_demanda_emp(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_persona.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }
        public tb_persona_Info get_info_bajo_demanda_emp(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_persona.get_info_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa), cl_enumeradores.eTipoPersona.EMPLEA.ToString());
        }



        public ActionResult CmbActivo_fijo()
        {
            string model = "";
            return PartialView("_CmbActivo_fijo", model);
        }

        public List<Af_Activo_fijo_Info> get_list_bajo_demanda_af(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_activo.get_list_bajo_demanda(args, Convert.ToInt32(SessionFixed.IdEmpresa));
        }

        public Af_Activo_fijo_Info get_info_bajo_demanda_af(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_activo.get_info_bajo_demanda(Convert.ToInt32(SessionFixed.IdEmpresa), args);
        }
        #endregion

        #region Metodos
        private void cargar_combos(int IdEmpresa, int IdActivoFijoTipo = 0)
        {
            var lst_departamento = bus_dep.GetList(IdEmpresa, false);
            ViewBag.lst_departamento = lst_departamento;

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
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info
            {
                IdEmpresa = IdEmpresa,
                Af_fecha_compra = DateTime.Now,
                Af_fecha_fin_depre = DateTime.Now,
                Af_fecha_ini_depre = DateTime.Now,
                Estado_Proceso = "TIP_ESTADO_AF_ACTIVO",
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession)
            };
            model.LstDet = new List<Af_Activo_fijo_CtaCble_Info>();
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(Af_Activo_fijo_Info model)
        {
            model.IdUsuario = Session["IdUsuario"].ToString();
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.guardarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Modificar(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_cta_cble.GetList(IdEmpresa, IdActivoFijo);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Modificar(Af_Activo_fijo_Info model)
        {
            model.IdUsuarioUltMod = Session["IdUsuario"].ToString();
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.modificarDB(model))
            {
                cargar_combos(model.IdEmpresa);
                return View(model);
            }
            return RedirectToAction("Index");
        }

        public ActionResult Anular(int IdEmpresa = 0, int IdActivoFijo = 0)
        {
            Af_Activo_fijo_Info model = bus_activo.get_info(IdEmpresa, IdActivoFijo);
            if (model == null)
                return RedirectToAction("Index");
            model.IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession);
            model.LstDet = bus_cta_cble.GetList(IdEmpresa, IdActivoFijo);
            List_det.set_list(model.LstDet, model.IdTransaccionSession);
            cargar_combos(IdEmpresa);
            return View(model);
        }

        [HttpPost]
        public ActionResult Anular(Af_Activo_fijo_Info model)
        {
            model.IdUsuarioUltAnu = Session["IdUsuario"].ToString();
            model.LstDet = List_det.get_list(model.IdTransaccionSession);
            if (!bus_activo.anularDB(model))
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

            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual)
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult Importar(Af_Activo_fijo_Info model)
        {
            var Lista_Tipo = ListaTipo.get_list(model.IdTransaccionSession);
            foreach (var item in Lista_Tipo)
            {
                bus_tipo.guardarDB(item);
            }

            var Lista_Categoria = ListaCategoria.get_list(model.IdTransaccionSession);
            foreach (var item in Lista_Categoria)
            {
                bus_categoria.guardarDB(item);
            }

            var Lista_Departamento = ListaDepartamento.get_list(model.IdTransaccionSession);
            foreach (var item in Lista_Departamento)
            {
                bus_dep.GuardarDB(item);
            }

            var Lista_Catalogo = ListaCatalogo.get_list(model.IdTransaccionSession);
            foreach (var item in Lista_Catalogo)
            {
                bus_catalogo.guardarDB(item);
            }

            var Lista_ActivoFijo = ListaActivoFijo.get_list(model.IdTransaccionSession);
            var Lista_ActivoFijo_CtaCble = List_det.get_list(model.IdTransaccionSession);
            
            foreach (var item in Lista_ActivoFijo)
            {
                item.LstDet = Lista_ActivoFijo_CtaCble.Where(q=>q.IdActivoFijo == item.IdActivoFijo).ToList();

                var secuencia = 1;
                foreach (var item2 in item.LstDet)
                {
                    item2.Secuencia = secuencia++;
                }

                bus_activo.guardarDB(item);
            }
            return RedirectToAction("Index");
        }
        public ActionResult GridViewPartial_tipoAF_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaTipo.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_tipoAF_importacion", model);
        }

        public ActionResult GridViewPartial_categoriaAF_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaCategoria.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_categoriaAF_importacion", model);
        }

        public ActionResult GridViewPartial_departamentoAF_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaDepartamento.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_departamentoAF_importacion", model);
        }

        public ActionResult GridViewPartial_catalogoAF_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaCatalogo.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_catalogoAF_importacion", model);
        }

        public ActionResult GridViewPartial_ActivoFijo_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = ListaActivoFijo.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_ActivoFijo_importacion", model);
        }

        public ActionResult GridViewPartial_ActivoFijo_CtaCble_importacion()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_ActivoFijo_CtaCble_importacion", model);
        }

        public JsonResult ActualizarVariablesSession(int IdEmpresa = 0, decimal IdTransaccionSession = 0)
        {
            string retorno = string.Empty;
            SessionFixed.IdEmpresa = IdEmpresa.ToString();
            SessionFixed.IdTransaccionSession = IdTransaccionSession.ToString();
            SessionFixed.IdTransaccionSessionActual = IdTransaccionSession.ToString();
            return Json(retorno, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Json
        public JsonResult cargar_categoria(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_Categoria_Bus bus_categoria = new Af_Activo_fijo_Categoria_Bus();
            var resultado = bus_categoria.get_list(IdEmpresa, IdActivoFijoTipo, false);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }

        public JsonResult get_info_tipo(int IdActivoFijoTipo = 0)
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();
            var resultado = bus_tipo.get_info(IdEmpresa, IdActivoFijoTipo);

            return Json(resultado, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Detalle
        private void cargar_combos_Detalle()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            var lst_departamento = bus_dep.GetList(IdEmpresa, false);
            ViewBag.lst_departamento = lst_departamento;
        }
        [ValidateInput(false)]
        public ActionResult GridViewPartial_activo_fijo_ctacble(int IdActivoFijo = 0)
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            cargar_combos_Detalle();
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] Af_Activo_fijo_CtaCble_Info info_det)
        {
            var cuenta = bus_plancta.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdCtaCble);
            if (cuenta != null)
                info_det.pc_Cuenta = cuenta.pc_Cuenta;
            if (ModelState.IsValid)
                List_det.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] Af_Activo_fijo_CtaCble_Info info_det)
        {
            var cuenta = bus_plancta.get_info(Convert.ToInt32(SessionFixed.IdEmpresa), info_det.IdCtaCble);
            if (cuenta != null)
                info_det.pc_Cuenta = cuenta.pc_Cuenta;

            if (ModelState.IsValid)
                List_det.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }
        public ActionResult EditingDelete(int Secuencia)
        {
            List_det.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            Af_Activo_fijo_Info model = new Af_Activo_fijo_Info();
            model.LstDet = List_det.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            cargar_combos_Detalle();
            return PartialView("_GridViewPartial_activo_fijo_ctacble", model);
        }
        #endregion
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
            #region Variables
            ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
            Af_Activo_fijo_tipo_Bus bus_tipo = new Af_Activo_fijo_tipo_Bus();

            Af_Activo_fijo_tipo_List ListaTipo = new Af_Activo_fijo_tipo_List();
            List<Af_Activo_fijo_tipo_Info> Lista_Tipo = new List<Af_Activo_fijo_tipo_Info>();
            Af_Activo_fijo_Categoria_List ListaCategoria = new Af_Activo_fijo_Categoria_List();
            List<Af_Activo_fijo_Categoria_Info> Lista_Categoria = new List<Af_Activo_fijo_Categoria_Info>();
            Af_Departamento_List ListaDepartamento = new Af_Departamento_List();
            List<Af_Departamento_Info> Lista_Departamento = new List<Af_Departamento_Info>();
            Af_Catalogo_List ListaCatalogo = new Af_Catalogo_List();
            List<Af_Catalogo_Info> Lista_Catalogo = new List<Af_Catalogo_Info>();
            Af_Activo_fijo_List ListaActivoFijo = new Af_Activo_fijo_List();
            List<Af_Activo_fijo_Info> Lista_ActivoFijo = new List<Af_Activo_fijo_Info>();
            Af_Activo_fijo_CtaCble_List ListaActivoFijoCtaCble = new Af_Activo_fijo_CtaCble_List();
            List<Af_Activo_fijo_CtaCble_Info> Lista_ActivoFijoCtaCble = new List<Af_Activo_fijo_CtaCble_Info>();


            int cont = 0;
            decimal IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual);
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            #endregion


            Stream stream = new MemoryStream(e.UploadedFile.FileBytes);
            if (stream.Length > 0)
            {
                IExcelDataReader reader = null;
                reader = ExcelReaderFactory.CreateOpenXmlReader(stream);

                #region Tipo                
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        Af_Activo_fijo_tipo_Info info = new Af_Activo_fijo_tipo_Info
                        {
                            IdEmpresa = IdEmpresa,
                            IdActivoFijoTipo = Convert.ToInt32(reader.GetValue(0)),
                            CodActivoFijo = reader.GetString(1),
                            Af_Descripcion = reader.GetString(2),
                            Af_Porcentaje_depre = Convert.ToDouble(reader.GetValue(3)),
                            Af_anio_depreciacion = Convert.ToInt32(reader.GetValue(4)),
                            IdCtaCble_Activo = Convert.ToString(reader.GetValue(6)),
                            IdCtaCble_Dep_Acum = Convert.ToString(reader.GetValue(7)),
                            IdCtaCble_Gastos_Depre = Convert.ToString(reader.GetValue(8)),
                            Se_Deprecia = reader.GetString(5) == "SI" ? true : false,
                            IdCtaCble_CostoVenta = Convert.ToString(reader.GetValue(9)),
                            IdCtaCble_Mejora = Convert.ToString(reader.GetValue(10)),
                            IdCtaCble_Baja = Convert.ToString(reader.GetValue(11)),
                            IdCtaCble_Retiro = Convert.ToString(reader.GetValue(12)),
                            IdUsuario = SessionFixed.IdUsuario
                        };
                        Lista_Tipo.Add(info);
                    }
                    else
                        cont++;
                }
                ListaTipo.set_list(Lista_Tipo, IdTransaccionSession);
                #endregion

                cont = 0;
                //Para avanzar a la siguiente hoja de excel
                reader.NextResult();

                #region Categoria                
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        Af_Activo_fijo_Categoria_Info info = new Af_Activo_fijo_Categoria_Info
                        {
                            IdEmpresa = IdEmpresa,
                            IdActivoFijoTipo = Convert.ToInt32(reader.GetValue(1)),
                            CodCategoriaAF = string.IsNullOrEmpty(Convert.ToString(reader.GetValue(2)))?null: Convert.ToString(reader.GetValue(2)),
                            Descripcion = Convert.ToString(reader.GetValue(3)),
                            IdUsuario = SessionFixed.IdUsuario
                        };
                        Lista_Categoria.Add(info);
                    }
                    else
                        cont++;
                }
                ListaCategoria.set_list(Lista_Categoria, IdTransaccionSession);
                #endregion

                cont = 0;
                reader.NextResult();

                #region Departamento                
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        Af_Departamento_Info info = new Af_Departamento_Info
                        {
                            IdEmpresa = IdEmpresa,
                            Descripcion = Convert.ToString(reader.GetValue(1)),
                            IdUsuarioCreacion = SessionFixed.IdUsuario
                        };
                        Lista_Departamento.Add(info);
                    }
                    else
                        cont++;
                }
                ListaDepartamento.set_list(Lista_Departamento, IdTransaccionSession);
                #endregion

                cont = 0;
                reader.NextResult();

                #region Catalogo                
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        Af_Catalogo_Info info = new Af_Catalogo_Info
                        {
                            IdCatalogo = Convert.ToString(reader.GetValue(0)),
                            IdTipoCatalogo = Convert.ToString(reader.GetValue(1)),
                            Descripcion = Convert.ToString(reader.GetValue(2)),
                            IdUsuario = SessionFixed.IdUsuario
                        };
                        Lista_Catalogo.Add(info);
                    }
                    else
                        cont++;
                }
                ListaCatalogo.set_list(Lista_Catalogo, IdTransaccionSession);
                #endregion

                cont = 0;
                reader.NextResult();

                #region ActivoFijo   
                var ListaEmpleado = bus_empleado.get_list_combo(IdEmpresa);
                ro_empleado_info_list Lista_Empleado = new ro_empleado_info_list();
                Lista_Empleado.set_list(ListaEmpleado);

                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        var IdTipo = Convert.ToInt32(reader.GetValue(5));
                        var ini_depre = Convert.ToDateTime(reader.GetValue(15));
                        var info_empleado_custodio = Lista_Empleado.get_list().Where(q => q.pe_cedulaRuc == Convert.ToString(reader.GetValue(12))).FirstOrDefault();
                        var info_empleado_encargado = Lista_Empleado.get_list().Where(q => q.pe_cedulaRuc == Convert.ToString(reader.GetValue(13))).FirstOrDefault();
                        var info_tipo_activofijo = ListaTipo.get_list(IdTransaccionSession).Where(q => q.IdActivoFijoTipo == IdTipo).FirstOrDefault(); ;

                        Af_Activo_fijo_Info info = new Af_Activo_fijo_Info
                        {
                            IdEmpresa = IdEmpresa,
                            IdUsuario = SessionFixed.IdUsuario,
                            IdActivoFijo = Convert.ToInt32(reader.GetValue(0)),
                            CodActivoFijo = string.IsNullOrEmpty(Convert.ToString(reader.GetValue(1)))?null: Convert.ToString(reader.GetValue(1)),
                            Af_Codigo_Barra = string.IsNullOrEmpty(Convert.ToString(reader.GetValue(2)))?null: Convert.ToString(reader.GetValue(2)),
                            Af_Nombre = Convert.ToString(reader.GetValue(3)),
                            IdCategoriaAF = Convert.ToInt32(reader.GetValue(4)),
                            IdActivoFijoTipo = Convert.ToInt32(reader.GetValue(5)),
                            IdSucursal = Convert.ToInt32(reader.GetValue(6)),
                            IdDepartamento = Convert.ToInt32(reader.GetValue(7)),
                            IdCatalogo_Marca = Convert.ToString(reader.GetValue(8)),
                            IdCatalogo_Modelo = Convert.ToString(reader.GetValue(9)),
                            IdCatalogo_Color = Convert.ToString(reader.GetValue(10)),
                            IdTipoCatalogo_Ubicacion = Convert.ToString(reader.GetValue(11)),
                            IdEmpleadoCustodio = info_empleado_custodio.IdEmpleado,
                            IdEmpleadoEncargado = info_empleado_encargado.IdEmpleado,
                            Af_fecha_compra = Convert.ToDateTime(reader.GetValue(14)),
                            Af_fecha_ini_depre = ini_depre,                            
                            Af_costo_compra = Convert.ToDouble(reader.GetValue(16)),
                            Af_Depreciacion_acum = Convert.ToDouble(reader.GetValue(17)),
                            Af_ValorSalvamento = Convert.ToDouble(reader.GetValue(18)),
                            Af_NumSerie = string.IsNullOrEmpty(Convert.ToString(reader.GetValue(19)))?null: Convert.ToString(reader.GetValue(19)),
                            Af_NumPlaca = string.IsNullOrEmpty(Convert.ToString(reader.GetValue(20)))?null: Convert.ToString(reader.GetValue(20)),
                            Estado_Proceso = "TIP_ESTADO_AF_ACTIVO",
                            Af_fecha_fin_depre = ini_depre.AddYears(info_tipo_activofijo.Af_anio_depreciacion),
                            Af_Meses_depreciar = (info_tipo_activofijo.Af_anio_depreciacion * 12),
                            Af_porcentaje_deprec = info_tipo_activofijo.Af_Porcentaje_depre,
                            Af_Vida_Util = info_tipo_activofijo.Af_anio_depreciacion,
                        };

                        Lista_ActivoFijo.Add(info);
                    }
                    else
                        cont++;
                }
                ListaActivoFijo.set_list(Lista_ActivoFijo, IdTransaccionSession);
                #endregion

                cont = 0;                
                reader.NextResult();

                #region ActivoFijo_CtaCble                
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0) && cont > 0)
                    {
                        Af_Activo_fijo_CtaCble_Info info = new Af_Activo_fijo_CtaCble_Info
                        {
                            IdEmpresa = IdEmpresa,
                            IdActivoFijo = Convert.ToInt32(reader.GetValue(0)),
                            IdDepartamento = Convert.ToInt32(reader.GetValue(1)),
                            IdCtaCble = Convert.ToString(reader.GetValue(2)),
                            Porcentaje = Convert.ToDouble(reader.GetValue(3))
                        };
                        Lista_ActivoFijoCtaCble.Add(info);
                    }
                    else
                        cont++;
                }
                ListaActivoFijoCtaCble.set_list(Lista_ActivoFijoCtaCble, IdTransaccionSession);
                #endregion
            }
        }
    }

    public class Af_Activo_fijo_CtaCble_List
    {
        string Variable = "Af_Activo_fijo_CtaCble_Info";
        public List<Af_Activo_fijo_CtaCble_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<Af_Activo_fijo_CtaCble_Info> list = new List<Af_Activo_fijo_CtaCble_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<Af_Activo_fijo_CtaCble_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<Af_Activo_fijo_CtaCble_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(Af_Activo_fijo_CtaCble_Info info_det, decimal IdTransaccionSession)
        {
            List<Af_Activo_fijo_CtaCble_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdDepartamento = info_det.IdDepartamento;
            info_det.IdCtaCble = info_det.IdCtaCble;
            info_det.Porcentaje = info_det.Porcentaje;
            info_det.pc_Cuenta = info_det.pc_Cuenta;


            list.Add(info_det);
        }

        public void UpdateRow(Af_Activo_fijo_CtaCble_Info info_det, decimal IdTransaccionSession)
        {
            Af_Activo_fijo_CtaCble_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdActivoFijo = info_det.IdActivoFijo;
            edited_info.IdCtaCble = info_det.IdCtaCble;
            edited_info.IdDepartamento = info_det.IdDepartamento;
            edited_info.Porcentaje = info_det.Porcentaje;
            edited_info.pc_Cuenta = info_det.pc_Cuenta;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<Af_Activo_fijo_CtaCble_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }

    public class Af_Activo_fijo_List
    {
        string Variable = "Af_Activo_fijo_Info";
        public List<Af_Activo_fijo_Info> get_list(decimal IdTransaccionSession)
        {
            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<Af_Activo_fijo_Info> list = new List<Af_Activo_fijo_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<Af_Activo_fijo_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<Af_Activo_fijo_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }
    }
}