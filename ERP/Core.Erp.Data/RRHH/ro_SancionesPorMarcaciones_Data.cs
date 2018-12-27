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
                    entity.Fecha_UltMod=DateTime.Now,
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
