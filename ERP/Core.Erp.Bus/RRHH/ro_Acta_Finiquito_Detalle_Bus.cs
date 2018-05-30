using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using Core.Erp.Data.RRHH;
namespace Core.Erp.Bus.RRHH
{
   public class ro_Acta_Finiquito_Detalle_Bus
    {

        #region variables
        ro_Acta_Finiquito_Info _Info = new ro_Acta_Finiquito_Info();
        List<ro_Acta_Finiquito_Detalle_Info> lst_valores_x_indegnizacion = new List<ro_Acta_Finiquito_Detalle_Info>();
        ro_Acta_Finiquito_Detalle_Data odata = new ro_Acta_Finiquito_Detalle_Data();
        ro_contrato_Bus bus_contrato = new ro_contrato_Bus();
        ro_empleado_novedad_Bus bus_noveddes = new ro_empleado_novedad_Bus();
        
        #endregion
        public List<ro_Acta_Finiquito_Detalle_Info> get_list(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdEmpleado, IdNovedad);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_Acta_Finiquito_Detalle_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad, int Secuencia)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado, IdNovedad, Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_Acta_Finiquito_Detalle_Info> info)
        {
            try
            {
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_Acta_Finiquito_Info info)
        {
            try
            {
                return odata.eliminarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        private bool ObtenerIndemnizacion(ro_Acta_Finiquito_Info info)
        {
            try
            {
                _Info.UltimaRemuneracion = bus_contrato.get_ultimo_sueldo(_Info.IdEmpresa, _Info.IdEmpleado);

                _Info = info;
                switch (_Info.IdCausaTerminacion)
                {
                    case "144": //Por las causas legalmente previstas en el contrato
                        ObtenerIndemnizacionXDesahucio();
                        break;

                    case "145": //Por acuerdo de las partes (Renuncia)
                        ObtenerIndemnizacionXDesahucio();
                        break;

                    case "147": //Por muerte o incapacidad del empleador o extinción de la persona jurídica contratante
                        ObtenerIndemnizacionXDespidoIntempestivo();
                        ObtenerIndemnizacionXDesahucio();
                        break;

                    case "151": //Por voluntad del trabajador previo visto bueno
                        ObtenerIndemnizacionXDespidoIntempestivo();
                        ObtenerIndemnizacionXDesahucio();
                        break;

                    case "152": //Por desahucio
                        ObtenerIndemnizacionXDesahucio();
                        break;
                }

                info.lst_detalle = lst_valores_x_indegnizacion;
                return true;
            }
            catch (Exception )
            {
                throw;
            }

        }

        //ART.185 DESAHUCIO
        private Boolean ObtenerIndemnizacionXDesahucio()
        {
            try
            {
                int anioTrabajados = 0;
                double totalRubroAcumulado = 0;
                totalRubroAcumulado = _Info.UltimaRemuneracion * 0.25 * anioTrabajados;


                TimeSpan dias;
                dias = _Info.FechaSalida - _Info.FechaIngreso;

                if (dias.TotalDays < 360)
                    return false;

                anioTrabajados =Convert.ToInt32( Math.Floor(dias.TotalDays / 360));

                if (anioTrabajados < 1)

                    return false;


                //CORRESPONDE EL 25% X CADA AÑO/FRACCION DE AÑO DE TRABAJO


                if (totalRubroAcumulado > 0)
                {
                    ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();
                    item.IdEmpresa = _Info.IdEmpresa;
                    item.IdEmpleado = _Info.IdEmpleado;
                    item.IdActaFiniquito = _Info.IdActaFiniquito;
                    item.Observacion = "Bonificación por Desahucio según Art.185";
                    item.Valor = totalRubroAcumulado;

                    lst_valores_x_indegnizacion.Add(item);
                }

                return true;
            }
            catch (Exception ex)
            {
                throw;

            }
        }
        //ART.188 INDEMNIZACION POR DESPIDO INTEMPESTIVO
        private bool ObtenerIndemnizacionXDespidoIntempestivo()
        {
            try
            {


                int anioTrabajados = 0;
                double totalRubroAcumulado = 0;


                anioTrabajados =Math.Abs(_Info.FechaSalida.Year - _Info.FechaIngreso.Year);


                if (anioTrabajados <= 3)
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 3; //HASTA 3 AÑOS DE TRABAJO RECIBE 3 MESES DE REMUNERACION

                }
                else
                {
                    if (anioTrabajados <= 25)
                    {//PUEDE ACUMULAR UNICAMENTE HASTA 25 MESES DE REMUNERACION X CADA AÑO DE TRABAJO
                        totalRubroAcumulado = _Info.UltimaRemuneracion * anioTrabajados;
                    }
                }

                if (totalRubroAcumulado > 0)
                {
                    ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();

                    item.IdEmpresa = _Info.IdEmpresa;
                    item.IdEmpleado = _Info.IdEmpleado;
                    item.IdActaFiniquito = _Info.IdActaFiniquito;
                    item.Observacion = "Indemnización por Despido Intempestivo según Art.188";
                    item.Valor = totalRubroAcumulado;
                }



                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }
        //ART.187 INDEMNIZACION POR GARANTIA PARA DIRIGENTES SINDICALES
        private Boolean ObtenerIndemnizacionXDespidoDirigenteSindical()
        {
            try
            {

                double totalRubroAcumulado = 0;

                //VERIFICA SI ES DIRIGENTE SINDICAL
                if (Convert.ToBoolean(_Info.EsDirigenteSindical))
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 12;//EQUIVALE A 1 AÑO DE REMUNERACION

                    if (totalRubroAcumulado > 0)
                    {
                        ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();

                        item.IdEmpresa = _Info.IdEmpresa;
                        item.IdEmpleado = _Info.IdEmpleado;
                        item.IdActaFiniquito = _Info.IdActaFiniquito;
                        item.Observacion = "Indemnización por Garantía Dirigentes Sindicales según Art.187";
                        item.Valor = totalRubroAcumulado;
                        lst_valores_x_indegnizacion.Add(item);

                    }

                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }
        //ART.187 INDEMNIZACION POR GARANTIA PARA MUJER EMBARAZADA
        private Boolean ObtenerIndemnizacionXDespidoMujerEmbarazada()
        {
            try
            {

                double totalRubroAcumulado = 0;

                //VERIFICA SI ES MUJER EMBARAZADA
                if (Convert.ToBoolean(_Info.EsMujerEmbarazada))
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 12;//EQUIVALE A 1 AÑO DE REMUNERACION

                    if (totalRubroAcumulado > 0)
                    {
                        ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();

                        item.IdEmpresa = _Info.IdEmpresa;
                        item.IdEmpleado = _Info.IdEmpleado;
                        item.IdActaFiniquito = _Info.IdActaFiniquito;
                        item.Observacion = "Indemnización por despido y declaratoria de ineficaz de la trabajadora embarazada";
                        item.Valor = totalRubroAcumulado;

                        lst_valores_x_indegnizacion.Add(item);
                    }

                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }
        //ART.51 INDEMNIZACION POR ESTABILIDAD LABORAL - LEY DE DISCAPACIDAD
        private Boolean ObtenerIndemnizacionXDespidoDiscapacitado()
        {
            try
            {

                double totalRubroAcumulado = 0;

                //VERIFICA SI ES DISCAPACITADO
                if (Convert.ToBoolean(_Info.EsPorDiscapacidad))
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 18;//EQUIVALE A 18 MESES DE REMUNERACION DEL MEJOR SUELDO

                    if (totalRubroAcumulado > 0)
                    {
                        ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();

                        item.IdEmpresa = _Info.IdEmpresa;
                        item.IdEmpleado = _Info.IdEmpleado;
                        item.IdActaFiniquito = _Info.IdActaFiniquito;
                        item.Observacion = "Indemnización por Estabilidad Laboral Art.51 - Ley de Discapacidad";
                        item.Valor = totalRubroAcumulado;

                        lst_valores_x_indegnizacion.Add(item);
                    }

                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }
        //ART.179 INDEMNIZACION POR NO RECIBIR AL TRABAJADOR EN CASO DE ENFERMEDAD NO PROFESIONAL
        private Boolean ObtenerIndemnizacionXDespidoEnfermedadNoProfesional()
        {
            try
            {

                double totalRubroAcumulado = 0;

                //VERIFICA SI ES CASO DE ENFERMEDAD NO PROFESIONAL
                if (Convert.ToBoolean(_Info.EsPorEnfermedadNoProfesional))
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 6;//EQUIVALE A 6 MESES DE REMUNERACION

                    if (totalRubroAcumulado > 0)
                    {
                        ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();

                        item.IdEmpresa = _Info.IdEmpresa;
                        item.IdEmpleado = _Info.IdEmpleado;
                        item.IdActaFiniquito = _Info.IdActaFiniquito;
                        item.Observacion = "Indemnización por NO recibir al trabajador en caso de enfermedad no Profesional según Art.175 y 179";
                        item.Valor = totalRubroAcumulado;
                        lst_valores_x_indegnizacion.Add(item);

                    }

                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }

        private Boolean ObtenerNovedadesPendientes()
        {
            try
            {

                double totalRubroAcumulado = 0;

                //VERIFICA SI ES CASO DE ENFERMEDAD NO PROFESIONAL
                if (Convert.ToBoolean(_Info.EsPorEnfermedadNoProfesional))
                {
                    totalRubroAcumulado = _Info.UltimaRemuneracion * 6;//EQUIVALE A 6 MESES DE REMUNERACION
                    if (totalRubroAcumulado > 0)
                    {
                        ro_Acta_Finiquito_Detalle_Info item = new ro_Acta_Finiquito_Detalle_Info();
                        item.IdEmpresa = _Info.IdEmpresa;
                        item.IdEmpleado = _Info.IdEmpleado;
                        item.IdActaFiniquito = _Info.IdActaFiniquito;
                        item.Observacion = "Indemnización por NO recibir al trabajador en caso de enfermedad no Profesional según Art.175 y 179";
                        item.Valor = totalRubroAcumulado;
                        lst_valores_x_indegnizacion.Add(item);

                    }

                }
                return true;
            }
            catch (Exception)
            {
                throw;

            }
        }


    }
}
