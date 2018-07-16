using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
   public class fa_factura_Data
    {
        public List<fa_factura_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<fa_factura_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.fa_factura
                             where q.IdEmpresa == IdEmpresa
                             select new fa_factura_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 CodCbteVta = q.CodCbteVta,
                                 vt_tipoDoc = q.vt_tipoDoc,
                                 vt_serie1 = q.vt_serie1,
                                 vt_serie2 = q.vt_serie2,
                                 vt_NumFactura = q.vt_NumFactura,
                                 Fecha_Autorizacion = q.fecha_primera_cuota,
                                 vt_anio = q.vt_anio,
                                 vt_autorizacion = q.vt_autorizacion,
                                 vt_fecha = q.vt_fecha,
                                 vt_fech_venc = q.vt_fech_venc,
                                 vt_mes = q.vt_mes,
                                 IdCliente = q.IdCliente,
                                 IdContacto = q.IdContacto,
                                 IdVendedor = q.IdVendedor,
                                 vt_plazo = q.vt_plazo,
                                 vt_Observacion = q.vt_Observacion,
                                 IdPeriodo = q.IdPeriodo,
                                 vt_tipo_venta = q.vt_tipo_venta,
                                 IdCaja = q.IdCaja,
                                 IdPuntoVta = q.IdPuntoVta,
                                 fecha_primera_cuota = q.fecha_primera_cuota,
                                 Fecha_Transaccion = q.fecha_primera_cuota,
                                 Estado = q.Estado,
                                 esta_impresa = q.esta_impresa,
                                 valor_abono = q.valor_abono
                                 

                             }).ToList();
                    else Lista = (from q in Context.fa_factura
                                  where q.IdEmpresa == IdEmpresa
                                  && q.Estado == "A"
                                  select new fa_factura_Info
                                  {

                                      IdEmpresa = q.IdEmpresa,
                                      IdSucursal = q.IdSucursal,
                                      IdBodega = q.IdBodega,
                                      IdCbteVta = q.IdCbteVta,
                                      CodCbteVta = q.CodCbteVta,
                                      vt_tipoDoc = q.vt_tipoDoc,
                                      vt_serie1 = q.vt_serie1,
                                      vt_serie2 = q.vt_serie2,
                                      vt_NumFactura = q.vt_NumFactura,
                                      Fecha_Autorizacion = q.fecha_primera_cuota,
                                      vt_anio = q.vt_anio,
                                      vt_autorizacion = q.vt_autorizacion,
                                      vt_fecha = q.vt_fecha,
                                      vt_fech_venc = q.vt_fech_venc,
                                      vt_mes = q.vt_mes,
                                      IdCliente = q.IdCliente,
                                      IdContacto = q.IdContacto,
                                      IdVendedor = q.IdVendedor,
                                      vt_plazo = q.vt_plazo,
                                      vt_Observacion = q.vt_Observacion,
                                      IdPeriodo = q.IdPeriodo,
                                      vt_tipo_venta = q.vt_tipo_venta,
                                      IdCaja = q.IdCaja,
                                      IdPuntoVta = q.IdPuntoVta,
                                      fecha_primera_cuota = q.fecha_primera_cuota,
                                      Fecha_Transaccion = q.fecha_primera_cuota,
                                      Estado = q.Estado,
                                      esta_impresa = q.esta_impresa,
                                      valor_abono = q.valor_abono
                                  }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public fa_factura_Info get_info(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCbteVta)
        {
            try
            {
                fa_factura_Info info = new fa_factura_Info();
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_factura Entity = Context.fa_factura.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdBodega == IdBodega && q.IdCbteVta == IdCbteVta);
                    if (Entity == null) return null;
                    info = new fa_factura_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdBodega = Entity.IdBodega,
                        IdCbteVta = Entity.IdCbteVta,
                        CodCbteVta = Entity.CodCbteVta,
                        vt_tipoDoc = Entity.vt_tipoDoc,
                        vt_serie1 = Entity.vt_serie1,
                        vt_serie2 = Entity.vt_serie2,
                        vt_NumFactura = Entity.vt_NumFactura,
                        Fecha_Autorizacion = Entity.fecha_primera_cuota,
                        vt_anio = Entity.vt_anio,
                        vt_autorizacion = Entity.vt_autorizacion,
                        vt_fecha = Entity.vt_fecha,
                        vt_fech_venc = Entity.vt_fech_venc,
                        vt_mes = Entity.vt_mes,
                        IdCliente = Entity.IdCliente,
                        IdContacto = Entity.IdContacto,
                        IdVendedor = Entity.IdVendedor,
                        vt_plazo = Entity.vt_plazo,
                        vt_Observacion = Entity.vt_Observacion,
                        IdPeriodo = Entity.IdPeriodo,
                        vt_tipo_venta = Entity.vt_tipo_venta,
                        IdCaja = Entity.IdCaja,
                        IdPuntoVta = Entity.IdPuntoVta,
                        fecha_primera_cuota = Entity.fecha_primera_cuota,
                        Fecha_Transaccion = Entity.fecha_primera_cuota,
                        Estado = Entity.Estado,
                        esta_impresa = Entity.esta_impresa,
                        valor_abono = Entity.valor_abono
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa, int IdSucursal, int IdBodega)
        {
            try
            {
                decimal ID = 1;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var lst = from q in Context.fa_factura
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == IdSucursal
                              && q.IdBodega == IdBodega
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdCbteVta) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_factura_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_factura Entity = new fa_factura
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdCbteVta = info.IdCbteVta=get_id(info.IdEmpresa, info.IdSucursal, info.IdBodega),
                        CodCbteVta = info.CodCbteVta,
                        vt_tipoDoc = info.vt_tipoDoc,
                        vt_serie1 = info.vt_serie1,
                        vt_serie2 = info.vt_serie2,
                        vt_NumFactura = info.vt_NumFactura,
                        Fecha_Autorizacion = info.fecha_primera_cuota,
                        vt_anio = info.vt_anio,
                        vt_autorizacion = info.vt_autorizacion,
                        vt_fecha = info.vt_fecha,
                        vt_fech_venc = info.vt_fech_venc,
                        vt_mes = info.vt_mes,
                        IdCliente = info.IdCliente,
                        IdContacto = info.IdContacto,
                        IdVendedor = info.IdVendedor,
                        vt_plazo = info.vt_plazo,
                        vt_Observacion = info.vt_Observacion,
                        IdPeriodo = info.IdPeriodo,
                        vt_tipo_venta = info.vt_tipo_venta,
                        IdCaja = info.IdCaja,
                        IdPuntoVta = info.IdPuntoVta,
                        fecha_primera_cuota = info.fecha_primera_cuota,
                        Fecha_Transaccion = info.fecha_primera_cuota,
                        Estado = info.Estado="A",
                        esta_impresa = info.esta_impresa,
                        valor_abono = info.valor_abono,
                        
                        IdUsuario = info.IdUsuario
                        
                    };
                    Context.fa_factura.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(fa_factura_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_factura Entity = Context.fa_factura.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdBodega == info.IdBodega && q.IdCbteVta == info.IdCbteVta);
                    if (Entity == null) return false;

                    Entity.CodCbteVta = info.CodCbteVta;
                    Entity.vt_tipoDoc = info.vt_tipoDoc;
                    Entity.vt_serie1 = info.vt_serie1;
                    Entity.vt_serie2 = info.vt_serie2;
                    Entity.vt_NumFactura = info.vt_NumFactura;
                    Entity.Fecha_Autorizacion = info.fecha_primera_cuota;
                    Entity.vt_anio = info.vt_anio;
                    Entity.vt_autorizacion = info.vt_autorizacion;
                    Entity.vt_fecha = info.vt_fecha;
                    Entity.vt_fech_venc = info.vt_fech_venc;
                    Entity.vt_mes = info.vt_mes;
                    Entity.IdCliente = info.IdCliente;
                    Entity.IdContacto = info.IdContacto;
                    Entity.IdVendedor = info.IdVendedor;
                    Entity.vt_plazo = info.vt_plazo;
                    Entity.vt_Observacion = info.vt_Observacion;
                    Entity.IdPeriodo = info.IdPeriodo;
                    Entity.vt_tipo_venta = info.vt_tipo_venta;
                    Entity.IdCaja = info.IdCaja;
                    Entity.IdPuntoVta = info.IdPuntoVta;
                    Entity.fecha_primera_cuota = info.fecha_primera_cuota;
                    Entity.Fecha_Transaccion = info.fecha_primera_cuota;
                    Entity.esta_impresa = info.esta_impresa;
                    Entity.valor_abono = info.valor_abono;
                    Entity.IdUsuario = info.IdUsuario;
                        
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(fa_factura_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_factura Entity = Context.fa_factura.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdBodega == info.IdBodega && q.IdCbteVta == info.IdCbteVta);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

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
