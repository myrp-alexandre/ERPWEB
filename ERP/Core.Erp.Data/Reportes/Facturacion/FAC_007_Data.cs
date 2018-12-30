using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_007_Data
    {
        public List<FAC_007_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta)
        {
            try
            {
                List<FAC_007_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWFAC_007
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdBodega == IdBodega
                             && q.IdCbteVta == IdCbteVta
                             select new FAC_007_Info
                             {
                                 cli_cedulaRuc = q.cli_cedulaRuc,
                                 cli_correo = q.cli_correo,
                                 cli_direccion = q.cli_direccion,
                                 cli_Nombre = q.cli_Nombre,
                                 cli_Telefonos = q.cli_Telefonos,
                                 DescuentoTotal = q.DescuentoTotal,
                                 Fecha_Autorizacion = q.Fecha_Autorizacion,
                                 FormaDePago = q.FormaDePago,
                                 IdBodega = q.IdBodega,
                                 IdCatalogo_FormaPago = q.IdCatalogo_FormaPago,
                                 IdCbteVta = q.IdCbteVta,
                                 IdEmpresa = q.IdEmpresa,
                                 IdProducto = q.IdProducto,
                                 IdSucursal = q.IdSucursal,
                                 pr_descripcion = q.pr_descripcion,
                                 Secuencia = q.Secuencia,
                                 SubtotalConDscto = q.SubtotalConDscto,
                                 SubtotalIVA = q.SubtotalIVA,
                                 SubtotalSinDscto = q.SubtotalSinDscto,
                                 SubtotalSinIVA = q.SubtotalSinIVA,
                                 Su_Descripcion = q.Su_Descripcion,
                                 Su_Direccion = q.Su_Direccion,
                                 Su_Telefonos = q.Su_Telefonos,
                                 vt_autorizacion = q.vt_autorizacion,
                                 vt_Cambio = q.vt_Cambio,
                                 vt_cantidad = q.vt_cantidad,
                                 vt_fecha = q.vt_fecha,
                                 vt_iva = q.vt_iva,
                                 vt_NumFactura = q.vt_NumFactura,
                                 vt_por_iva = q.vt_por_iva,
                                 vt_Precio = q.vt_Precio,
                                 vt_Total = q.vt_Total,
                                 vt_ValorEfectivo = q.vt_ValorEfectivo



                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
