using Core.Erp.Data.Compras;
using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Compras
{
   public class com_ordencompra_local_Bus
    {
        com_ordencompra_local_Data odata = new com_ordencompra_local_Data();
        public List<com_ordencompra_local_Info> get_list(int IdEmpresa, bool mostrar_anulados)
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
        public com_ordencompra_local_Info get_info(int IdEmpresa, int IdSucursal, decimal IdOrdenCompra)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdSucursal, IdOrdenCompra);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(com_ordencompra_local_Info info)
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
        public bool modificarDB(com_ordencompra_local_Info info)
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
        public bool anularDB(com_ordencompra_local_Info info)
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
