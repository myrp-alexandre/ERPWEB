using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_SancionesPorMarcaciones_Data
    {
        public List<ro_SancionesPorMarcaciones_Info> get_list(int IdEmpresa, DateTime Fechainicio, DateTime FechaFin)
        {
            try
            {
                List<ro_SancionesPorMarcaciones_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    
                        Lista = (from q in Context.vwro_SancionesPorMarcaciones
                                 where q.IdEmpresa == IdEmpresa
                                 select new ro_SancionesPorMarcaciones_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdAjuste = q.IdEmpresa,
                                     IdNomina_Tipo = q.IdNomina_Tipo,
                                     IdNomina_TipoLiqui = q.IdNomina_TipoLiqui,
                                     FechaInicio = q.FechaInicio,
                                     FecaFin = q.FecaFin,
                                     Observacion = q.Observacion,
                                     Descripcion=q.Descripcion,
                                     DescripcionProcesoNomina=q.DescripcionProcesoNomina
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                using (Entities_rrhh Context=new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = new ro_SancionesPorMarcaciones
                    {
                        IdEmpresa=info.IdEmpresa,
                        IdAjuste=get_id(info.IdEmpresa),
                        IdNomina_Tipo=info.IdNomina_Tipo,
                        IdNomina_TipoLiqui=info.IdNomina_TipoLiqui,
                        FechaInicio=info.FechaInicio, FecaFin=info.FecaFin,
                        Observacion=info.Observacion,
                        Fecha_Transac=DateTime.Now,
                        Estado=true

                    };
                    Context.ro_SancionesPorMarcaciones.Add(entity);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdAjuste == info.IdAjuste).FirstOrDefault();
                    if (entity == null)
                        return false;
                    entity.FechaInicio = info.FechaInicio;
                    entity.FecaFin = info.FecaFin;
                    entity.Observacion = info.Observacion;
                    entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
               
                        }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_SancionesPorMarcaciones_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {

                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == info.IdEmpresa && v.IdAjuste == info.IdAjuste).FirstOrDefault();
                    if (entity == null)
                        return false;
                    entity.Estado =false;
                    entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();

                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_SancionesPorMarcaciones_Info get_info(int IdEmpresa, int IdAjuste)
        {
            try
            {
                using (Entities_rrhh Context=new Entities_rrhh())
                {
                    ro_SancionesPorMarcaciones entity = Context.ro_SancionesPorMarcaciones.Where(v => v.IdEmpresa == IdEmpresa && v.IdAjuste == IdAjuste).FirstOrDefault();

                    if (entity == null)
                        return new ro_SancionesPorMarcaciones_Info();

                    ro_SancionesPorMarcaciones_Info info = new ro_SancionesPorMarcaciones_Info
                    {
                        IdEmpresa = entity.IdEmpresa,
                        IdAjuste = entity.IdEmpresa,
                        IdNomina_Tipo = entity.IdNomina_Tipo,
                        IdNomina_TipoLiqui = entity.IdNomina_TipoLiqui,
                        FechaInicio = entity.FechaInicio,
                        FecaFin = entity.FecaFin,
                        Observacion = entity.Observacion,
                    };

                    return info;

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        public int get_id(int IdEmpresa)
        {
            try
            {
                using (Entities_rrhh Context=new Entities_rrhh())
                {
                    var select = (from q in Context.ro_SancionesPorMarcaciones
                                  where q.IdEmpresa == IdEmpresa
                                  select q
                                );
                    if (select.Count() == 0)
                        return 1;
                    else
                        return select.Count() + 1;

                }

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
