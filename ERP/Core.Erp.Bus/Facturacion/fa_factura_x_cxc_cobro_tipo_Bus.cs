using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Facturacion
{
    public class fa_factura_x_cxc_cobro_tipo_Bus
    {
        fa_factura_x_cxc_cobro_tipo_Data odata = new fa_factura_x_cxc_cobro_tipo_Data();

        public List<fa_factura_x_cxc_cobro_tipo_Info> GetList(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta)
        {
            try
            {
                return odata.GetList(IdEmpresa, IdSucursal, IdBodega, IdCbteVta);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
