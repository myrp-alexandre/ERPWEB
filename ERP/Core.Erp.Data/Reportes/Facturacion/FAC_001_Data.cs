using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_001_Data
    {
         public List<FAC_001_Info> get_list(int IdEmpresa, int IdSucursal, int IdVendedor, decimal IdCliente, int IdCliente_contacto, decimal IdProducto, decimal IdProducto_padre, DateTime fecha_ini, DateTime fecha_fin, bool mostrar_anulados)
        {
            try
            {
                List<FAC_001_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWFAC_001
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdVendedor == IdVendedor
                             && q.IdCliente == IdCliente
                             && q.IdProducto == IdProducto
                             && q.IdProducto_padre == IdProducto_padre
                             select new FAC_001_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 Secuencia = q.Secuencia,
                                 IdProducto = q.IdProducto,
                                 IdProducto_padre = q.IdProducto_padre,
                                 vt_NumFactura = q.vt_NumFactura,
                                 IdCliente = q.IdCliente,
                                 IdContacto = q.IdContacto,
                                 NombreContacto = q.NombreContacto,
                                 IdVendedor = q.IdVendedor,
                                 Ve_Vendedor = q.Ve_Vendedor,
                                 NombreCliente = q.NombreCliente,
                                 pr_descripcion = q.pr_descripcion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 vt_cantidad = q.vt_cantidad,
                                 vt_DesctTotal = q.vt_DesctTotal,
                                 vt_iva = q.vt_iva,
                                 vt_PorDescUnitario = q.vt_PorDescUnitario,
                                 vt_Precio = q.vt_Precio,
                                 vt_PrecioFinal = q.vt_PrecioFinal,
                                 vt_Subtotal = q.vt_Subtotal,
                                 vt_total = q.vt_total, 
                                 Estado = q.Estado,
                                 Su_Descripcion = q.Su_Descripcion
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
