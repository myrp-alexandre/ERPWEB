using Core.Erp.Data.General;
using Core.Erp.Info.General;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.General
{
    public class tb_bodega_Bus
    {
        tb_bodega_Data odata = new tb_bodega_Data();

        public List<tb_bodega_Info> get_list(int IdEmpresa, int IdSucursal, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, IdSucursal, mostrar_anulados);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public List<tb_bodega_Info> get_list(int IdEmpresa, bool mostrar_anulados)
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

        public tb_bodega_Info get_info(int IdEmpresa, int IdSucursal, int IdBodega)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdSucursal, IdBodega);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(tb_bodega_Info info)
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

        public bool modificarDB(tb_bodega_Info info)
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

        public bool anularDB(tb_bodega_Info info)
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
