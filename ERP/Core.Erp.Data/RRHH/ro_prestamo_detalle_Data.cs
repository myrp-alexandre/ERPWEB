using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_prestamo_detalle_Data
    {
        public List<ro_prestamo_detalle_Info> get_list(int IdEmpresa, decimal IdPrestamo)
        {
            try
            {
                List<ro_prestamo_detalle_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_prestamo_detalle
                             where q.IdEmpresa == IdEmpresa
                                   & q.IdPrestamo == IdPrestamo
                             select new ro_prestamo_detalle_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdPrestamo = q.IdPrestamo,
                                 NumCuota = q.NumCuota,
                                 SaldoInicial = q.SaldoInicial,
                                 Interes = q.Interes,
                                 AbonoCapital = q.AbonoCapital,
                                 TotalCuota = q.TotalCuota,
                                 Saldo = q.Saldo,
                                 FechaPago = q.FechaPago,
                                 EstadoPago = q.EstadoPago,
                                 Observacion_det=q.Observacion_det,
                                 IdNominaTipoLiqui = q.IdNominaTipoLiqui
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public double get_valor_cuotas_pendientes(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                double valor_cuotas = 0;
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                  var  query = (from q in Context.ro_prestamo_detalle
                                 join p in Context.ro_prestamo
                                 on new { q.IdEmpresa, q.IdPrestamo } equals new { p.IdEmpresa, p.IdPrestamo }
                                 where q.IdEmpresa == IdEmpresa
                                       & q.IdPrestamo == IdEmpleado
                                 select q.TotalCuota);
                    if (query.Count() > 0)
                        valor_cuotas = query.Sum();
                }

                return valor_cuotas;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_prestamo_detalle_Info get_info(int IdEmpresa, decimal IdPrestamo, int Secuencia)
        {
            try
            {
                ro_prestamo_detalle_Info info = new ro_prestamo_detalle_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo_detalle Entity = Context.ro_prestamo_detalle.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdPrestamo == IdPrestamo && q.IdPrestamo == IdPrestamo);
                    if (Entity == null) return null;

                    info = new ro_prestamo_detalle_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdPrestamo = Entity.IdPrestamo,
                        NumCuota = Entity.NumCuota,
                        SaldoInicial = Entity.SaldoInicial,
                        Interes = Entity.Interes,
                        AbonoCapital = Entity.AbonoCapital,
                        TotalCuota = Entity.TotalCuota,
                        Saldo = Entity.Saldo,
                        FechaPago = Entity.FechaPago,
                        EstadoPago = Entity.EstadoPago,
                        Observacion_det = Entity.Observacion_det
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_prestamo_detalle_Info> info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    foreach (var item in info)
                    {
                        ro_prestamo_detalle Entity = new ro_prestamo_detalle
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdPrestamo = item.IdPrestamo,
                            NumCuota = item.NumCuota,
                            SaldoInicial = item.SaldoInicial,
                            Interes = item.Interes,
                            AbonoCapital = item.AbonoCapital,
                            TotalCuota = item.TotalCuota,
                            Saldo = item.Saldo,
                            FechaPago = item.FechaPago,
                            EstadoPago = item.EstadoPago = "PEN",
                            Observacion_det = item.Observacion_det,
                            IdNominaTipoLiqui = item.IdNominaTipoLiqui,
                            Estado = item.Estado = "A",
                        };
                        Context.ro_prestamo_detalle.Add(Entity);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception )
            {

                throw;
            }
        }
        public bool eliminarDB(ro_prestamo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    string sql = "delete ro_prestamo_detalle where IdEmpresa='" + info.IdEmpresa + "'  and IdPrestamo='" + info.IdPrestamo + "'";
                    Context.Database.ExecuteSqlCommand(sql);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool AnularD(ro_prestamo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    string sql = "update ro_prestamo_detalle set Estado='I' where IdEmpresa='" + info.IdEmpresa + "'  and IdPrestamo='" + info.IdPrestamo + "'";
                    Context.Database.ExecuteSqlCommand(sql);
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
