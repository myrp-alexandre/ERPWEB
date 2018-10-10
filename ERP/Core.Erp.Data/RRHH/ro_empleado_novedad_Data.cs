using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;

namespace Core.Erp.Data.RRHH
{
  public  class ro_empleado_novedad_Data
    {
        public List<ro_empleado_novedad_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                fecha_inicio = fecha_inicio.Date;
                fecha_fin = fecha_fin.Date;
                List<ro_empleado_novedad_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                        Lista = (from q in Context.vwro_empleado_Novedad
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Fecha >= fecha_inicio
                                 && q.Fecha <= fecha_fin
                                 select new ro_empleado_novedad_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdNovedad = q.IdNovedad,
                                     IdNomina_Tipo = q.IdNomina_Tipo,
                                     IdNomina_TipoLiqui = q.IdNomina_TipoLiqui,
                                     IdEmpleado = q.IdEmpleado,
                                     Fecha = q.Fecha,
                                     Fecha_PrimerPago = q.Fecha_PrimerPago,
                                     Estado = q.Estado,
                                     Descripcion = q.Descripcion,
                                     DescripcionProcesoNomina = q.DescripcionProcesoNomina,
                                     pe_cedulaRuc = q.pe_cedulaRuc,
                                     pe_nombreCompleto = q.pe_apellido + " " + q.pe_nombre,
                                     Observacion = q.Observacion,
                                     TotalValor = q.TotalValor,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_empleado_novedad_Info get_info(int IdEmpresa,decimal IdEmpleado, decimal IdNovedad)
        {
            try
            {
                ro_empleado_novedad_Info info = new ro_empleado_novedad_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_Novedad Entity = Context.ro_empleado_Novedad.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado==IdEmpleado && q.IdNovedad == IdNovedad);
                    if (Entity == null) return null;

                    info = new ro_empleado_novedad_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdNovedad = Entity.IdNovedad ,
                        IdNomina_Tipo = Entity.IdNomina_Tipo,
                        IdNomina_TipoLiqui = Entity.IdNomina_TipoLiqui,
                        IdEmpleado = Entity.IdEmpleado,
                        Fecha = Entity.Fecha,
                        Fecha_PrimerPago = Entity.Fecha_PrimerPago,
                        Estado = Entity.Estado,
                        Observacion=Entity.Observacion
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public decimal get_id(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                decimal ID = 1;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_empleado_Novedad
                              where q.IdEmpresa == IdEmpresa
                              && q.IdEmpleado==IdEmpleado
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdNovedad) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_empleado_novedad_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_Novedad Entity = new ro_empleado_Novedad
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdNovedad = info.IdNovedad = get_id(info.IdEmpresa, info.IdEmpleado),
                        IdNomina_Tipo = info.IdNomina_Tipo,
                        IdNomina_TipoLiqui=info.IdNomina_TipoLiqui,
                        IdEmpleado=info.IdEmpleado,
                        Fecha=info.Fecha.Date,
                        TotalValor=info.TotalValor,
                        Fecha_PrimerPago=info.Fecha_PrimerPago,
                        Observacion=info.Observacion,                     
                        Estado = info.Estado = "A",
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.ro_empleado_Novedad.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(ro_empleado_novedad_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_Novedad Entity = Context.ro_empleado_Novedad.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.IdNovedad==info.IdNovedad);
                    if (Entity == null)
                        return false;
                    Entity.IdNomina_Tipo = info.IdNomina_Tipo;
                    Entity.IdNomina_TipoLiqui = info.IdNomina_TipoLiqui;
                    Entity.Observacion =( info.Observacion)==null?"": info.Observacion;
                    Entity.Fecha = info.Fecha.Date;
                    Entity.NumCoutas = info.NumCoutas;
                    Entity.TotalValor = info.TotalValor;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_empleado_novedad_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_Novedad Entity = Context.ro_empleado_Novedad.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdEmpleado == info.IdEmpleado && q.IdNovedad == info.IdNovedad);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = "I";
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

  
    }
}
