using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_historial_Sueldo_Data
    {
        public List<ro_empleado_historial_Sueldo_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_empleado_historial_Sueldo_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.ro_empleado_historial_Sueldo
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_empleado_historial_Sueldo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdEmpleado = q.IdEmpleado,
                                     Secuencia =q.Secuencia,
                                     SueldoAnterior = q.SueldoAnterior,
                                     SueldoActual = q.SueldoActual,
                                     PorIncrementoSueldo = q.PorIncrementoSueldo,
                                     ValorIncrementoSueldo = q.ValorIncrementoSueldo,
                                     Motivo = q.Motivo,
                                     Fecha = q.Fecha,
                                     idUsuario = q.idUsuario,
                                     de_descripcion=q.de_descripcion,
                                     ca_descripcion=q.ca_descripcion,
                                     IdCentroCosto=q.IdCentroCosto,
                                     Fecha_Transac = q.Fecha_Transac

                                 }).ToList();
                   
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_historial_Sueldo_Info get_info(int IdEmpresa, decimal IdEmpleado,  int Secuencia)
        {
            try
            {
                ro_empleado_historial_Sueldo_Info info = new ro_empleado_historial_Sueldo_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_historial_Sueldo Entity = Context.ro_empleado_historial_Sueldo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa 
                                                                                                               && q.IdEmpleado == IdEmpleado
                                                                                                               && q.Secuencia==Secuencia);
                    if (Entity == null) return null;

                    info = new ro_empleado_historial_Sueldo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        Secuencia = Entity.Secuencia,
                        SueldoAnterior = Entity.SueldoAnterior,
                        SueldoActual = Entity.SueldoActual,
                        PorIncrementoSueldo = Entity.PorIncrementoSueldo,
                        ValorIncrementoSueldo = Entity.ValorIncrementoSueldo,
                        Motivo = Entity.Motivo,
                        Fecha = Entity.Fecha,
                        idUsuario = Entity.idUsuario,
                        de_descripcion = Entity.de_descripcion,
                        ca_descripcion = Entity.ca_descripcion,
                        IdCentroCosto = Entity.IdCentroCosto,
                        Fecha_Transac = Entity.Fecha_Transac
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                int ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_empleado_historial_Sueldo
                              where q.IdEmpresa == IdEmpresa
                              && q.IdEmpleado == IdEmpleado
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.Secuencia) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_empleado_historial_Sueldo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_historial_Sueldo Entity = new ro_empleado_historial_Sueldo
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        Secuencia = info.Secuencia,
                        SueldoAnterior = info.SueldoAnterior,
                        SueldoActual = info.SueldoActual,
                        PorIncrementoSueldo = info.PorIncrementoSueldo,
                        ValorIncrementoSueldo = info.ValorIncrementoSueldo,
                        Motivo = info.Motivo,
                        Fecha = info.Fecha,
                        idUsuario = info.idUsuario,
                        de_descripcion = info.de_descripcion,
                        ca_descripcion = info.ca_descripcion,
                        IdCentroCosto = info.IdCentroCosto,
                        Fecha_Transac = info.Fecha_Transac
                    };
                    Context.ro_empleado_historial_Sueldo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_empleado_historial_Sueldo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_historial_Sueldo Entity = Context.ro_empleado_historial_Sueldo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa 
                                                                                                                 && q.IdEmpleado==info.IdEmpleado
                                                                                                                 && q.Secuencia == info.Secuencia);
                    if (Entity == null)
                        return false;
                    Entity.SueldoAnterior = info.SueldoAnterior;
                    Entity.SueldoActual = info.SueldoActual;
                    Entity.PorIncrementoSueldo = info.PorIncrementoSueldo;
                    Entity.ValorIncrementoSueldo = info.ValorIncrementoSueldo;
                    Entity.Motivo = info.Motivo;
                    Entity.Fecha = info.Fecha;
                    Entity.idUsuario = info.idUsuario;
                    Entity.de_descripcion = info.de_descripcion;
                    Entity.ca_descripcion = info.ca_descripcion;
                    Entity.IdCentroCosto = info.IdCentroCosto;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_empleado_historial_Sueldo_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_historial_Sueldo Entity = Context.ro_empleado_historial_Sueldo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa
                                                                                                                                    && q.IdEmpleado == info.IdEmpleado
                                                                                                                                    && q.Secuencia == info.Secuencia);
                    if (Entity == null)
                        return false;
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
