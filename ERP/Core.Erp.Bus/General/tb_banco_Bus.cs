using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.General
{
    public class tb_banco_Bus
    {
        tb_banco_Data odata = new tb_banco_Data();

        public List<tb_banco_Info> get_list(bool mostrar_anulados)
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
        public tb_banco_Info get_info(int IdBanco)
        {
            try
            {
                return odata.get_info(IdBanco);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(tb_banco_Info info)
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

        public bool modificarDB(tb_banco_Info info)
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
        public bool anularDB(tb_banco_Info info)
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
