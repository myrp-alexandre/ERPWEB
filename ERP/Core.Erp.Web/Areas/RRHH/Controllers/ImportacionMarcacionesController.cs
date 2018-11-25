using Core.Erp.Bus.General;
using Core.Erp.Bus.RRHH;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using Core.Erp.Web.Helps;
using DevExpress.DataAccess.Excel;
using DevExpress.Web.Mvc;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ExcelDataReader;

namespace Core.Erp.Web.Areas.RRHH.Controllers
{
    public class ImportacionMarcacionesController : Controller
    {
        #region Variables
        ro_marcaciones_x_empleado_Bus bus_marcaciones = new ro_marcaciones_x_empleado_Bus();
        ro_EmpleadoNovedadCargaMasiva_det_Bus bus_novedad_detalle_bus = new ro_EmpleadoNovedadCargaMasiva_det_Bus();
        ro_marcaciones_x_empleado_detLis_Info detalle = new ro_marcaciones_x_empleado_detLis_Info();
        ro_empleado_Bus bus_empleado = new ro_empleado_Bus();
        List<ro_rubro_tipo_Info> lst_rubros = new List<ro_rubro_tipo_Info>();
        tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
        ro_empleado_info_list empleado_info_list = new ro_empleado_info_list();

        int IdEmpresa = 0;
        #endregion


        #region Vistas
       

        [ValidateInput(false)]
        public ActionResult GridViewPartial_importacion_marcaciones_det()
        {
            List<ro_marcaciones_x_empleado_Info> model = new List<ro_marcaciones_x_empleado_Info>();

            model = detalle.get_list();
            return PartialView("_GridViewPartial_importacion_marcaciones_det", model);
        }
        #endregion

        #region acciones
        public ActionResult Nuevo()
        {
            empleado_info_list.set_list(bus_empleado.get_list_combo(Convert.ToInt32(SessionFixed.IdEmpresa)));

            ro_marcaciones_x_empleado_Info model = new ro_marcaciones_x_empleado_Info
            {
                IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa),
                Fecha_Transac = DateTime.Now,
                IdNomina = 1,
                
            };
            model.detalle = new List<ro_marcaciones_x_empleado_Info>();
            detalle.set_list(model.detalle);
            cargar_combos();
            return View(model);
        }

        [HttpPost]
        public ActionResult Nuevo(ro_marcaciones_x_empleado_Info model)
        {



            model.detalle = detalle.get_list();
            if (model.detalle == null || model.detalle.Count() == 0)
            {
                ViewBag.mensaje = "No existe detalle para la novedad";
                cargar_combos();
                return View(model);
            }



            model.IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            model.IdUsuario = SessionFixed.IdUsuario;
            if (!bus_marcaciones.guardarDB(model.detalle, model.IdEmpresa))
            {
                cargar_combos();
                return View(model);
            }
            return RedirectToAction("Index");
        }

        #endregion

        #region cargar combos

        private void cargar_combos()
        {
            tb_sucursal_Bus bus_sucursal = new tb_sucursal_Bus();
            IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            ViewBag.lst_sucursal = bus_sucursal.get_list(Convert.ToInt32(SessionFixed.IdEmpresa), false);

        }
        #endregion

        #region funciones del detalle

       
        #endregion


        public ActionResult UploadControlUpload()
        {
            UploadControlExtension.GetUploadedFiles("UploadControlFile", UploadControlSettings_marcaciones.UploadValidationSettings, UploadControlSettings_marcaciones.FileUploadComplete_marcaciones);
            return null;
        }

    }
    public class UploadControlSettings_marcaciones
    {
        public static DevExpress.Web.UploadControlValidationSettings UploadValidationSettings = new DevExpress.Web.UploadControlValidationSettings()
        {
            AllowedFileExtensions = new string[] { ".xlsx" },
            MaxFileSize = 40000000
        };
        public static void FileUploadComplete_marcaciones(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            int cont = 0;
            ro_empleado_info_list empleado_info_list = new ro_empleado_info_list();
            ro_marcaciones_x_empleado_detLis_Info EmpleadoNovedadCargaMasiva_detLis_Info = new ro_marcaciones_x_empleado_detLis_Info();
            List<ro_marcaciones_x_empleado_Info> lista_novedades = new List<ro_marcaciones_x_empleado_Info>();

            Stream stream = new MemoryStream(e.UploadedFile.FileBytes);
            if (stream.Length > 0)
            {
                IExcelDataReader reader = null;
                reader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                DateTime Fecha_registro;
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0))
                    {
                        if (cont != 0)
                        {
                            string cedua = reader.GetString(0);
                            var empleado = empleado_info_list.get_list().Where(v => v.pe_cedulaRuc == cedua).FirstOrDefault();
                            if (empleado != null)
                            {
                                if (!reader.IsDBNull(2))// si tiene fehca de marcacion
                                {
                                    Fecha_registro =Convert.ToDateTime( reader.GetString(2));
                                    if (!reader.IsDBNull(3))// si tiene entrada del primer turno
                                    {
                                        ro_marcaciones_x_empleado_Info info = new ro_marcaciones_x_empleado_Info
                                        {   IdEmpleado=empleado.IdEmpleado,
                                            IdEmpresa=empleado.IdEmpresa,
                                            es_fechaRegistro=Fecha_registro,
                                            es_anio=Fecha_registro.Year,
                                            es_mes=Fecha_registro.Month,
                                            es_idDia=Fecha_registro.Day,
                                            es_Hora=new TimeSpan(Fecha_registro.Hour,Fecha_registro.Minute,0),
                                            IdTipoMarcaciones=cl_enumeradores.eTipoMarcacionRRHH.IN1.ToString()
                                            
                                        };
                                        lista_novedades.Add(info);
                                    }


                                    if (!reader.IsDBNull(4))// si tiene salida del primer turno
                                    {
                                        ro_marcaciones_x_empleado_Info info = new ro_marcaciones_x_empleado_Info
                                        {
                                            IdEmpleado = empleado.IdEmpleado,
                                            IdEmpresa = empleado.IdEmpresa,
                                            es_fechaRegistro = Fecha_registro,
                                            es_anio = Fecha_registro.Year,
                                            es_mes = Fecha_registro.Month,
                                            es_idDia = Fecha_registro.Day,
                                            es_Hora = new TimeSpan(Fecha_registro.Hour, Fecha_registro.Minute, 0),
                                            IdTipoMarcaciones = cl_enumeradores.eTipoMarcacionRRHH.IN1.ToString()

                                        };
                                        lista_novedades.Add(info);
                                    }

                                    if (!reader.IsDBNull(5))// si tiene entrada del segundo turno
                                    {
                                        ro_marcaciones_x_empleado_Info info = new ro_marcaciones_x_empleado_Info
                                        {
                                            IdEmpleado = empleado.IdEmpleado,
                                            IdEmpresa = empleado.IdEmpresa,
                                            es_fechaRegistro = Fecha_registro,
                                            es_anio = Fecha_registro.Year,
                                            es_mes = Fecha_registro.Month,
                                            es_idDia = Fecha_registro.Day,
                                            es_Hora = new TimeSpan(Fecha_registro.Hour, Fecha_registro.Minute, 0),
                                            IdTipoMarcaciones = cl_enumeradores.eTipoMarcacionRRHH.IN1.ToString()

                                        };
                                        lista_novedades.Add(info);
                                    }


                                    if (reader.IsDBNull(6))// si tiene salida del segundo turno
                                    {
                                        ro_marcaciones_x_empleado_Info info = new ro_marcaciones_x_empleado_Info
                                        {
                                            IdEmpleado = empleado.IdEmpleado,
                                            IdEmpresa = empleado.IdEmpresa,
                                            es_fechaRegistro = Fecha_registro,
                                            es_anio = Fecha_registro.Year,
                                            es_mes = Fecha_registro.Month,
                                            es_idDia = Fecha_registro.Day,
                                            es_Hora = new TimeSpan(Fecha_registro.Hour, Fecha_registro.Minute, 0),
                                            IdTipoMarcaciones = cl_enumeradores.eTipoMarcacionRRHH.IN1.ToString()

                                        };
                                        lista_novedades.Add(info);
                                    }
                                }

                                
                            }
                        }
                        cont++;

                    }

                }
                EmpleadoNovedadCargaMasiva_detLis_Info.set_list(lista_novedades);
            }
        }


        
    }
    public class ro_marcaciones_x_empleado_detLis_Info
    {
        public List<ro_marcaciones_x_empleado_Info> get_list()
        {
            if (HttpContext.Current.Session["ro_marcaciones_x_empleado_Info"] == null)
            {
                List<ro_marcaciones_x_empleado_Info> list = new List<ro_marcaciones_x_empleado_Info>();

                HttpContext.Current.Session["ro_marcaciones_x_empleado_Info"] = list;
            }
            return (List<ro_marcaciones_x_empleado_Info>)HttpContext.Current.Session["ro_marcaciones_x_empleado_Info"];
        }

        public void set_list(List<ro_marcaciones_x_empleado_Info> list)
        {
            HttpContext.Current.Session["ro_marcaciones_x_empleado_Info"] = list;
        }
    }


}