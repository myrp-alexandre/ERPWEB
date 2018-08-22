using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_003_Data
    {
        public List<FAC_003_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta, bool mostrar_cuotas)
        {
            try
            {
                List<FAC_003_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    if(!mostrar_cuotas)
                    {

                        Lista = (from q in Context.VWFAC_003
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal == IdSucursal
                                 && q.IdBodega == IdBodega
                                 && q.IdCbteVta == IdCbteVta
                                 select new FAC_003_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdBodega = q.IdBodega,
                                     IdCbteVta = q.IdCbteVta,
                                     Secuencia = q.Secuencia,
                                     vt_cantidad = q.vt_cantidad,
                                     vt_DescUnitario = q.vt_DescUnitario,
                                     vt_fecha = q.vt_fecha,
                                     vt_fech_venc = q.vt_fech_venc,
                                     vt_iva = q.vt_iva,
                                     vt_NumFactura = q.vt_NumFactura,
                                     vt_PorDescUnitario = q.vt_PorDescUnitario,
                                     vt_por_iva = q.vt_por_iva,
                                     vt_Precio = q.vt_Precio,
                                     vt_PrecioFinal = q.vt_PrecioFinal,
                                     vt_serie1 = q.vt_serie1,
                                     vt_serie2 = q.vt_serie2,
                                     vt_Subtotal = q.vt_Subtotal,
                                     vt_tipoDoc = q.vt_tipoDoc,
                                     vt_total = q.vt_total,
                                     Ve_Vendedor = q.Ve_Vendedor,
                                     Estado = q.Estado,
                                     IdCliente = q.IdCliente,
                                     IdProducto = q.IdProducto,
                                     pr_descripcion = q.pr_descripcion,
                                     pr_descripcion_2 = q.pr_descripcion_2,
                                     pe_cedulaRuc = q.pe_cedulaRuc,
                                     pe_direccion = q.pe_direccion,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     pe_razonSocial = q.pe_razonSocial,
                                     pe_telefonoOfic = q.pe_telefonoOfic,
                                     Observacion_central = q.Observacion_central,
                                     Observacion_x_item = q.Observacion_x_item,
                                     dia = q.dia,
                                     mes = q.mes,
                                     anio = q.anio,
                                     Codigo = q.Codigo,
                                     forma_pago_DINERO_ELECTRONICO = q.forma_pago_DINERO_ELECTRONICO,
                                     forma_pago_CHEQUE_TRANSFERENCIA = q.forma_pago_CHEQUE_TRANSFERENCIA,
                                     forma_pago_EFECTIVO = q.forma_pago_EFECTIVO,
                                     forma_pago_TARJETA_CRE_DEB = q.forma_pago_TARJETA_CRE_DEB,
                                     Descripcion_Ciudad = q.Descripcion_Ciudad,
                                     descto = q.descto,
                                     lote_fecha_fab = q.lote_fecha_fab,
                                     lote_fecha_vcto = q.lote_fecha_vcto,
                                     lote_num_lote = q.lote_num_lote,
                                     subtotal_0 = q.subtotal_0,
                                     subtotal_iva = q.subtotal_iva



                                 }).ToList();
                    }
                    else
                    {
                        Lista = (from q in Context.VWFAC_003_cuotas
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal == IdSucursal
                                 && q.IdBodega == IdBodega
                                 && q.IdCbteVta == IdCbteVta
                                 select new FAC_003_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdBodega = q.IdBodega,
                                     IdCbteVta = q.IdCbteVta,
                                     Secuencia = q.Secuencia,
                                     vt_cantidad = q.vt_cantidad,
                                     vt_DescUnitario = q.vt_DescUnitario,
                                     vt_fecha = q.vt_fecha,
                                     vt_fech_venc = q.vt_fech_venc,
                                     vt_iva = q.vt_iva,
                                     vt_NumFactura = q.vt_NumFactura,
                                     vt_PorDescUnitario = q.vt_PorDescUnitario,
                                     vt_por_iva = q.vt_por_iva,
                                     vt_Precio = q.vt_Precio,
                                     vt_PrecioFinal = q.vt_PrecioFinal,
                                     vt_serie1 = q.vt_serie1,
                                     vt_serie2 = q.vt_serie2,
                                     vt_Subtotal = q.vt_Subtotal,
                                     vt_tipoDoc = q.vt_tipoDoc,
                                     vt_total = q.vt_total,
                                     Ve_Vendedor = q.Ve_Vendedor,
                                     Estado = q.Estado,
                                     IdCliente = q.IdCliente,
                                     IdProducto = q.IdProducto,
                                     pr_descripcion = q.pr_descripcion,
                                     pr_descripcion_2 = q.pr_descripcion_2,
                                     pe_cedulaRuc = q.pe_cedulaRuc,
                                     pe_direccion = q.pe_direccion,
                                     pe_nombreCompleto = q.pe_nombreCompleto,
                                     pe_razonSocial = q.pe_razonSocial,
                                     pe_telefonoOfic = q.pe_telefonoOfic,
                                     Observacion_central = q.Observacion_central,
                                     Observacion_x_item = q.Observacion_x_item,
                                     dia = q.dia,
                                     mes = q.mes,
                                     anio = q.anio,
                                     Codigo = q.Codigo,
                                     forma_pago_DINERO_ELECTRONICO = q.forma_pago_DINERO_ELECTRONICO,
                                     forma_pago_CHEQUE_TRANSFERENCIA = q.forma_pago_CHEQUE_TRANSFERENCIA,
                                     forma_pago_EFECTIVO = q.forma_pago_EFECTIVO,
                                     forma_pago_TARJETA_CRE_DEB = q.forma_pago_TARJETA_CRE_DEB,
                                     Descripcion_Ciudad = q.Descripcion_Ciudad,
                                     descto = q.descto,
                                     lote_fecha_fab = q.lote_fecha_fab,
                                     lote_fecha_vcto = q.lote_fecha_vcto,
                                     lote_num_lote = q.lote_num_lote,
                                     subtotal_0 = q.subtotal_0,
                                     subtotal_iva = q.subtotal_iva,
                                     orden = q.orden


                                 }).ToList();
                    }
                }
                return Lista.OrderBy(q => q.Secuencia).ThenBy(q => q.orden).ToList();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
