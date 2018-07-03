using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.General
{
    public class tb_sucursal_Bus
    {
        tb_sucursal_Data odata = new tb_sucursal_Data();
        public List<tb_sucursal_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa,mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public tb_sucursal_Info get_info(int IdEmpresa, int IdSucursal)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdSucursal);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(tb_sucursal_Info info)
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

        public bool modificarDB(tb_sucursal_Info info)
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

        public bool anularDB(tb_sucursal_Info info)
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
