using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Facturacion
{
    public class fa_factura_det_Data
    {
        public List<fa_factura_det_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta)
        {
            try
            {
                List<fa_factura_det_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.fa_factura_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdBodega == IdBodega
                             && q.IdCbteVta == IdCbteVta
                             select new fa_factura_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 IdProducto = q.IdProducto,
                                 vt_cantidad = q.vt_cantidad,
                                 vt_DescUnitario = q.vt_DescUnitario,
                                 vt_PrecioFinal = q.vt_PrecioFinal,
                                 vt_Precio = q.vt_Precio,
                                 vt_Subtotal = q.vt_Subtotal,
                                 vt_detallexItems = q.vt_detallexItems,
                                 vt_estado = q.vt_estado,
                                 vt_iva = q.vt_iva,
                                 vt_PorDescUnitario = q.vt_PorDescUnitario,
                                 vt_por_iva = q.vt_por_iva,
                                 vt_total = q.vt_total,
                                 IdCentroCosto = q.IdCentroCosto,
                                 IdCentroCosto_sub_centro_costo = q.IdCentroCosto_sub_centro_costo,
                                 IdCod_Impuesto_Ice = q.IdCod_Impuesto_Ice,
                                 IdCod_Impuesto_Iva = q.IdCod_Impuesto_Iva,
                                 IdEmpresa_pf = q.IdEmpresa_pf,
                                 IdProforma = q.IdProforma,
                                 IdPunto_Cargo = q.IdPunto_Cargo,
                                 IdPunto_cargo_grupo = q.IdPunto_cargo_grupo,
                                 IdSucursal_pf = q.IdSucursal_pf,
                                 Secuencia = q.Secuencia,
                                 Secuencia_pf = q.Secuencia_pf
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
