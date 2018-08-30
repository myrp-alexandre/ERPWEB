using Core.Erp.Data.Compras;
using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Compras
{
    public class com_TerminoPago_Bus
    {
        com_TerminoPago_Data odata = new com_TerminoPago_Data();
        public List<com_TerminoPago_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public com_TerminoPago_Info get_info(string IdTerminoPago)
        {
            try
            {
                return odata.get_info(IdTerminoPago);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool validar_existe_idTermino(string IdTerminoPago)
        {
            try
            {
                return odata.validar_existe_idTermino(IdTerminoPago);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(com_TerminoPago_Info info)
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

        public bool modificarDB(com_TerminoPago_Info info)
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

        public bool anularDB(com_TerminoPago_Info info)
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

    }
}
