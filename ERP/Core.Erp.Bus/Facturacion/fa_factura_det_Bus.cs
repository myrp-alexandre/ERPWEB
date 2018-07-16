using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Facturacion
{
   public class fa_factura_det_Bus
    {
        fa_factura_det_Data odata = new fa_factura_det_Data();
        public List<fa_factura_det_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta, int Secuencia)
        {
            try
            {
              return   odata.get_list(IdEmpresa, IdSucursal, IdBodega, IdCbteVta, Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta, int Secuencia)
        {
            try
            {
                return odata.eliminarDB(IdEmpresa, IdSucursal, IdBodega, IdCbteVta, Secuencia);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_factura_det_Info info)
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
    }
}
