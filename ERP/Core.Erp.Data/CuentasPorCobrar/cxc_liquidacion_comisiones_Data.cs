using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_liquidacion_comisiones_Data
    {
        public List<cxc_liquidacion_comisiones_Info> get_list (int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<cxc_liquidacion_comisiones_Info> Lista;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {if(mostrar_anulados)
                        Lista = (from q in Context.cxc_liquidacion_comisiones
                                 where q.IdEmpresa == IdEmpresa
                                 select new cxc_liquidacion_comisiones_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdLiquidacion = q.IdLiquidacion,
                                     IdVendedor = q.IdVendedor,
                                     Observacion = q.Observacion,
                                     Fecha = q.Fecha,
                                     Estado = q.Estado
                                 }).ToList();
                    else
                    Lista = (from q in Context.cxc_liquidacion_comisiones
                             where q.IdEmpresa == IdEmpresa
                             select new cxc_liquidacion_comisiones_Info
                             {
                             IdEmpresa = q.IdEmpresa,
                             IdLiquidacion = q.IdLiquidacion,
                             IdVendedor = q.IdVendedor,
                             Observacion = q.Observacion,
                             Fecha = q.Fecha,
                             Estado = true
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cxc_liquidacion_comisiones_Info get_info(int IdEmpresa , decimal IdLiquidacion)
        {
            try
            {
                cxc_liquidacion_comisiones_Info info = new cxc_liquidacion_comisiones_Info();
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_liquidacion_comisiones Entity = Context.cxc_liquidacion_comisiones.Where(q => q.IdEmpresa == IdEmpresa && q.IdLiquidacion == IdLiquidacion).FirstOrDefault();
                    if (Entity == null) return null;
                    info = new cxc_liquidacion_comisiones_Info
                    {
                    IdEmpresa = Entity.IdEmpresa,
                    IdLiquidacion = Entity.IdLiquidacion,
                    IdVendedor = Entity.IdVendedor,
                    Observacion = Entity.Observacion,
                    Fecha = Entity.Fecha,
                    Estado = Entity.Estado
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal Id = 1;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    var lst = from q in Context.cxc_liquidacion_comisiones
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        Id = lst.Max(q => q.IdLiquidacion) + 1 ;
                }
                return Id;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(cxc_liquidacion_comisiones_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_liquidacion_comisiones Entity = new cxc_liquidacion_comisiones
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdLiquidacion = info.IdLiquidacion=get_id(info.IdEmpresa),
                        IdVendedor = info.IdVendedor,
                        Observacion = info.Observacion,
                        Fecha = info.Fecha.Date,
                        Estado = true,
                        IdUsuario = info.IdUsuario,
                        FechaTransac = DateTime.Now
                    };
                    Context.cxc_liquidacion_comisiones.Add(Entity);

                    foreach (var item in info.lst_det)
                    {
                        cxc_liquidacion_comisiones_det det = new cxc_liquidacion_comisiones_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdLiquidacion = info.IdLiquidacion,
                            Secuencia = item.Secuencia,
                            IdVendedor = item.IdVendedor,
                            PorcentajeComision = item.PorcentajeComision,
                            SubtotalFactura = item.SubtotalFactura,
                            IvaFactura = item.IvaFactura,
                            TotalFactura = item.TotalFactura,
                            TotalCobrado = item.TotalCobrado,
                            BaseComision = item.BaseComision,
                            TotalAComisionar = item.TotalAComisionar,
                            TotalComisionado = item.TotalComisionado,
                            TotalLiquidacion = item.TotalLiquidacion,
                            NoComisiona = item.NoComisiona,
                            fa_IdBodega = item.fa_IdBodega,
                            fa_IdCbteVta = item.fa_IdCbteVta,
                            fa_IdEmpresa = item.fa_IdEmpresa,
                            fa_IdSucursal = item.fa_IdSucursal

                        };
                        Context.cxc_liquidacion_comisiones_det.Add(det);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(cxc_liquidacion_comisiones_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_liquidacion_comisiones Entity = Context.cxc_liquidacion_comisiones.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdLiquidacion == info.IdLiquidacion).FirstOrDefault();
                    if (Entity == null) return false;
                    
                    Entity.Observacion = info.Observacion;
                    Entity.Fecha = info.Fecha.Date;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.FechaUltMod = DateTime.Now;

                    var lst = Context.cxc_liquidacion_comisiones_det.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdLiquidacion == info.IdLiquidacion);
                    Context.cxc_liquidacion_comisiones_det.RemoveRange(lst);

                    foreach (var item in info.lst_det)
                    {
                        cxc_liquidacion_comisiones_det det = new cxc_liquidacion_comisiones_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdLiquidacion = info.IdLiquidacion,
                            Secuencia = item.Secuencia,
                            IdVendedor = item.IdVendedor,
                            PorcentajeComision = item.PorcentajeComision,
                            SubtotalFactura = item.SubtotalFactura,
                            IvaFactura = item.IvaFactura,
                            TotalFactura = item.TotalFactura,
                            TotalCobrado = item.TotalCobrado,
                            BaseComision = item.BaseComision,
                            TotalAComisionar = item.TotalAComisionar,
                            TotalComisionado = item.TotalComisionado,
                            TotalLiquidacion = item.TotalLiquidacion,
                            NoComisiona = item.NoComisiona,
                            fa_IdBodega = item.fa_IdBodega,
                            fa_IdCbteVta = item.fa_IdCbteVta,
                            fa_IdEmpresa = item.fa_IdEmpresa,
                            fa_IdSucursal = item.fa_IdSucursal

                        };
                        Context.cxc_liquidacion_comisiones_det.Add(det);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(cxc_liquidacion_comisiones_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_liquidacion_comisiones Entity = Context.cxc_liquidacion_comisiones.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdLiquidacion == info.IdLiquidacion).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Estado = false;
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.FechaUltAnu = DateTime.Now;
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
