using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
  public  class ro_prestamo_Data
    {
        ro_Parametros_Data odata = new ro_Parametros_Data();
        public List<ro_prestamo_Info> get_list(int IdEmpresa, DateTime fechaInicio, DateTime fechaFin)
        {
            try
            {

                DateTime fi = Convert.ToDateTime(fechaInicio.ToShortDateString());
                DateTime ff = Convert.ToDateTime(fechaFin.ToShortDateString());

                List<ro_prestamo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.vwRo_Prestamo
                             where q.IdEmpresa == IdEmpresa
                             && q.Fecha>=fi
                             &&q.Fecha<=ff
                             select new ro_prestamo_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdPrestamo = q.IdPrestamo,
                                 descuento_mensual = q.descuento_mensual,
                                 descuento_men_quin = q.descuento_men_quin,
                                 descuento_quincena=q.descuento_quincena,
                                 IdEmpleado = q.IdEmpleado,
                                 IdRubro = q.IdRubro,
                                 Estado = q.Estado,
                                 Fecha = q.Fecha,
                                 MontoSol = q.MontoSol,
                                 NumCuotas = q.NumCuotas,
                                 Fecha_PriPago = q.Fecha_PriPago,
                                 Observacion = q.Observacion,
                                 IdTipoCbte = q.IdTipoCbte,
                                 IdCbteCble = q.IdCbteCble,
                                 IdOrdenPago = q.IdOrdenPago,
                                 pe_nombre_completo=q.pe_apellido+" "+q.pe_nombre,
                                 Valor_pendiente=q.Valor_pendiente,
                                 TotalCobrado=q.TotalCobrado,
                                 ru_descripcion=q.ru_descripcion,

                                 EstadoBool = q.Estado


                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<ro_prestamo_Info> get_list_aprobacion(int IdEmpresa, DateTime fechaInicio, DateTime fechaFin)
        {
            try
            {
                DateTime fi = Convert.ToDateTime(fechaInicio.ToShortDateString());
                DateTime ff = Convert.ToDateTime(fechaFin.ToShortDateString());

                List<ro_prestamo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.vwRo_Prestamo
                             where q.IdEmpresa == IdEmpresa
                             && q.Fecha >= fi
                             && q.Fecha <= ff
                             select new ro_prestamo_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdPrestamo = q.IdPrestamo,
                                 descuento_mensual = q.descuento_mensual,
                                 descuento_men_quin = q.descuento_men_quin,
                                 descuento_quincena = q.descuento_quincena,
                                 IdEmpleado = q.IdEmpleado,
                                 IdRubro = q.IdRubro,
                                 Estado = q.Estado,
                                 Fecha = q.Fecha,
                                 MontoSol = q.MontoSol,
                                 NumCuotas = q.NumCuotas,
                                 Fecha_PriPago = q.Fecha_PriPago,
                                 Observacion = q.Observacion,
                                 IdTipoCbte = q.IdTipoCbte,
                                 IdCbteCble = q.IdCbteCble,
                                 IdOrdenPago = q.IdOrdenPago,
                                 pe_nombre_completo = q.pe_apellido + " " + q.pe_nombre,
                                 Valor_pendiente = q.Valor_pendiente,
                                 TotalCobrado = q.TotalCobrado,
                                 ru_descripcion = q.ru_descripcion,

                                 EstadoBool = q.Estado


                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool aprobar_prestamo(int IdEmpresa, string[] Lista, string IdUsuarioAprueba)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    foreach (var item in Lista)
                    {
                        var IdPrestamo = Convert.ToDecimal(item);
                        ro_prestamo Entity = Context.ro_prestamo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdPrestamo == IdPrestamo);
                        if (Entity != null)
                        {
                            Entity.IdUsuarioAprueba = IdUsuarioAprueba;
                            Entity.EstadoAprob = "APROB";
                        }
                        Context.SaveChanges();
                    }
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ro_prestamo_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdPrestamo)
        {
            try
            {
                ro_prestamo_Info info = new ro_prestamo_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo Entity = Context.ro_prestamo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado && q.IdPrestamo == IdPrestamo);
                    if (Entity == null) return null;

                    info = new ro_prestamo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdPrestamo = Entity.IdPrestamo,
                        descuento_mensual = Entity.descuento_mensual,
                        descuento_men_quin = Entity.descuento_men_quin,
                        descuento_quincena = Entity.descuento_quincena,
                        IdEmpleado = Entity.IdEmpleado,
                        IdRubro = Entity.IdRubro,
                        Estado = Entity.Estado,
                        Fecha = Entity.Fecha,
                        MontoSol = Entity.MontoSol,
                        NumCuotas = Entity.NumCuotas,
                        Fecha_PriPago = Entity.Fecha_PriPago,
                        Observacion = Entity.Observacion,
                        IdTipoCbte = Entity.IdTipoCbte,
                        IdCbteCble = Entity.IdCbteCble,
                        IdOrdenPago = Entity.IdOrdenPago
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_prestamo
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdPrestamo) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_prestamo_Info info)
        {
            try
            {
                var ro_parametro = odata.get_info(info.IdEmpresa);
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo Entity = new ro_prestamo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdPrestamo = info.IdPrestamo = get_id(info.IdEmpresa),
                        descuento_mensual = info.descuento_mensual,
                        descuento_men_quin = info.descuento_men_quin,
                        descuento_quincena = info.descuento_quincena,
                        IdEmpleado = info.IdEmpleado,
                        IdRubro = info.IdRubro,
                        Fecha = info.Fecha.Date,
                        MontoSol = info.MontoSol,
                        NumCuotas = info.NumCuotas,
                        Fecha_PriPago = info.Fecha_PriPago.Date,
                        Observacion = info.Observacion,
                        Estado = info.Estado = true,
                        EstadoAprob = ro_parametro.EstadoCreacionPrestamos,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.ro_prestamo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_prestamo_Info info)
        {
            try
            {
                var ro_parametro = odata.get_info(info.IdEmpresa);
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo Entity = Context.ro_prestamo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.IdPrestamo == info.IdPrestamo);
                    if (Entity == null)
                        return false;
                        Entity.descuento_mensual = info.descuento_mensual;
                        Entity.descuento_men_quin = info.descuento_men_quin;
                        Entity.descuento_quincena = info.descuento_quincena;
                        Entity.IdEmpleado = info.IdEmpleado;
                        Entity.IdRubro = info.IdRubro;
                        Entity.Fecha = info.Fecha.Date;
                        Entity.MontoSol = info.MontoSol;
                        Entity.NumCuotas = info.NumCuotas;
                        Entity.Fecha_PriPago = info.Fecha_PriPago.Date;
                        Entity.Observacion = info.Observacion;
                        Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                        Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                        Entity.EstadoAprob = ro_parametro.EstadoCreacionPrestamos;
                        Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_prestamo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo Entity = Context.ro_prestamo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.IdPrestamo == info.IdPrestamo);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = false;
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool Abono(ro_prestamo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_prestamo Entity = Context.ro_prestamo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.IdPrestamo == info.IdPrestamo);
                    if (Entity == null)
                        return false;
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
                    foreach (var item in info.lst_detalle)
                    {
                        ro_prestamo_detalle Entity_det = Context.ro_prestamo_detalle.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdPrestamo == info.IdPrestamo
                        && q.NumCuota == item.NumCuota);
                        Entity_det.EstadoPago = item.EstadoPago;
                        Entity_det.TotalCuota = item.ValorAplicado;
                        Context.SaveChanges();

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
    }
}
