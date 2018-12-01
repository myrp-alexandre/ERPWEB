using Core.Erp.Data.RRHH;
using Core.Erp.Info.Helps;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.RRHH
{
   public class ro_archivos_bancos_generacion_Bus
    {
        ro_archivos_bancos_generacion_Data odata = new ro_archivos_bancos_generacion_Data();
        public List<ro_archivos_bancos_generacion_Info> get_list(int IdEmpresa, DateTime Fechainicio, DateTime fechafin, bool estado)
        {
            try
            {
                return odata.get_list(IdEmpresa,Fechainicio, fechafin, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_archivos_bancos_generacion_Info get_info(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdArchivo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_archivos_bancos_generacion_Info info)
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

        public bool modificarDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {

                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string GetArchivo(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                string Archivo = "";
                switch (info.TipoFile)
                {
                    case cl_enumeradores.eTipoProcesoBancario.NCR:

                        return get_NCR(info);
                  
                    case cl_enumeradores.eTipoProcesoBancario.ROL_ELECTRONICO:

                        break;
                    
                    default:
                        break;
                }

                return Archivo;
            }
            catch (Exception)
            {

                throw;
            }
        }
        #region Archivos para el banco de guayaquil

        private string get_NCR(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                string File = "";
                foreach (var item in info.detalle)
                {
                    double valor = Convert.ToDouble(item.Valor);
                    double valorEntero = Math.Floor(valor);
                    double valorDecimal = Convert.ToDouble((valor - valorEntero).ToString("N2")) * 100;

                    if (item.em_tipoCta == "COR" || item.em_tipoCta == "AHO")
                    {
                        File += "A";
                        if (item.em_tipoCta == "AHO")
                            File += "A";
                        else
                            File += "C";
                        File += item.em_NumCta.PadLeft(10, '0');
                        File +=  (valorEntero.ToString()+valorDecimal.ToString()).PadLeft(15,'0');
                        File+="EI";
                        File += "Y";
                        File +=  "01";
                        File +=  cl_funciones.QuitarTildes(item.pe_apellido + item.pe_nombre);
                        File += "\n";
                    }

                }

                return File;
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion

    }
}
