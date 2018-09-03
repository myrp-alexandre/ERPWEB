using Core.Erp.Data.Compras;
using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Compras
{
   public class com_Motivo_Orden_Compra_Bus
    {
        com_Motivo_Orden_Compra_Data odata = new com_Motivo_Orden_Compra_Data();
        public List<com_Motivo_Orden_Compra_Info> get_list(int IdEmpresa, bool mostrar_anulados)
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

        public com_Motivo_Orden_Compra_Info get_info(int IdEmpresa, int IdMotivo)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdMotivo);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(com_Motivo_Orden_Compra_Info info)
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

        public bool modificarDB(com_Motivo_Orden_Compra_Info info)
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

        public bool anularDB(com_Motivo_Orden_Compra_Info info)
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
