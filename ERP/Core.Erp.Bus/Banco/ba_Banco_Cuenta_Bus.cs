using Core.Erp.Data.Banco;
using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Banco
{
    public class ba_Banco_Cuenta_Bus
    {
        ba_Banco_Cuenta_Data odata = new ba_Banco_Cuenta_Data();
    
        public List<ba_Banco_Cuenta_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ba_Banco_Cuenta_Info get_info(int IdEmpresa, int idBanco)
        {
            try
            {
                return odata.get_info(IdEmpresa, idBanco);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ba_Banco_Cuenta_Info info)
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
        public bool modificarDB(ba_Banco_Cuenta_Info info)
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

        public bool anularDB(ba_Banco_Cuenta_Info info)
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
