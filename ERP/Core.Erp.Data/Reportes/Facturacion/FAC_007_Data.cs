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
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 Secuencia = q.Secuencia,
                                 IdProducto = q.IdProducto,
                                 pr_descripcion = q.pr_descripcion,
                                 nom_presentacion = q.nom_presentacion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 vt_cantidad = q.vt_cantidad,
                                 vt_fecha = q.vt_fecha,
                                 vt_fech_venc = q.vt_fech_venc,
                                 vt_iva = q.vt_iva,
                                 vt_NumFactura = q.vt_NumFactura,
                                 vt_PorDescUnitario = q.vt_PorDescUnitario,
                                 vt_por_iva = q.vt_por_iva,
                                 vt_Precio = q.vt_Precio,
                                 vt_Subtotal = q.vt_Subtotal,
                                 vt_Subtotal0 = q.vt_Subtotal0,
                                 vt_SubtotalIVA = q.vt_SubtotalIVA,
                                 vt_total = q.vt_total,
                                 DescTotal = q.DescTotal,
                                 Nombres = q.Nombres,
                                 nom_TerminoPago = q.nom_TerminoPago,
                                 Num_Coutas = q.Num_Coutas,
                                 Su_Descripcion = q.Su_Descripcion,
                                 Ve_Vendedor = q.Ve_Vendedor,
                                 vt_Observacion = q.vt_Observacion
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
