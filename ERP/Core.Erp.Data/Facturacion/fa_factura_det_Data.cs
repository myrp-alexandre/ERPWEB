using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_factura_det_Data
    {
        public List<fa_factura_det_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta, int Secuencia)
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
                             && q.Secuencia == Secuencia
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
                                 Secuencia_pf = q.Secuencia

                             }).ToList();
                }
                return Lista;
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
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    string comando = "delete fa_factura_det where IdEmpresa = " + IdEmpresa + " and IdSucursal = " + IdSucursal+ " and IdBodega = " + IdBodega + " and IdCbteVta = " + IdCbteVta + "and Secuencia = " + Secuencia;
                    Context.Database.ExecuteSqlCommand(comando);
                }

                return true;
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
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_factura_det Entity = new fa_factura_det
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdCbteVta = info.IdCbteVta,
                        IdProducto = info.IdProducto,
                        vt_cantidad = info.vt_cantidad,
                        vt_DescUnitario = info.vt_DescUnitario,
                        vt_PrecioFinal = info.vt_PrecioFinal,
                        vt_Precio = info.vt_Precio,
                        vt_Subtotal = info.vt_Subtotal,
                        vt_detallexItems = info.vt_detallexItems,
                        vt_estado = info.vt_estado,
                        vt_iva = info.vt_iva,
                        vt_PorDescUnitario = info.vt_PorDescUnitario,
                        vt_por_iva = info.vt_por_iva,
                        vt_total = info.vt_total,
                        IdCentroCosto = info.IdCentroCosto,
                        IdCentroCosto_sub_centro_costo = info.IdCentroCosto_sub_centro_costo,
                        IdCod_Impuesto_Ice = info.IdCod_Impuesto_Ice,
                        IdCod_Impuesto_Iva = info.IdCod_Impuesto_Iva,
                        IdEmpresa_pf = info.IdEmpresa_pf,
                        IdProforma = info.IdProforma,
                        IdPunto_Cargo = info.IdPunto_Cargo,
                        IdPunto_cargo_grupo = info.IdPunto_cargo_grupo,
                        IdSucursal_pf = info.IdSucursal_pf,
                        Secuencia = info.Secuencia,
                        Secuencia_pf = info.Secuencia
                    };
                    Context.fa_factura_det.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
