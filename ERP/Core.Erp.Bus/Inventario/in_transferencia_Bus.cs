using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
using Core.Erp.Data.Inventario;
namespace Core.Erp.Bus.Inventario
{
   public class in_transferencia_Bus
    {
       in_transferencia_Data odata = new in_transferencia_Data();

        public List<in_transferencia_Info> get_list(int IdEmpresa)
        {
            try
            {
                return odata.get_list(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public in_transferencia_Info get_info(int IdEmpresa, int IdSucursa, int IdBodega, decimal IdTransferencia)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdSucursa,IdBodega,IdTransferencia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_transferencia_Info info)
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
        public bool modificarDB(in_transferencia_Info info)
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
        public bool anularDB(in_transferencia_Info info)
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


        public string validar(in_transferencia_Info info)
        {
            string mensaje = "";
            if (info.list_detalle.Count == 0)
            {
                mensaje = "Debe ingresar al menos un producto";
            }
            return mensaje;

        }
    }
}
