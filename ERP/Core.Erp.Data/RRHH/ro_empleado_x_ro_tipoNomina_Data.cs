using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_x_ro_tipoNomina_Data
    {
        public List< ro_empleado_x_ro_tipoNomina_Info> get_list(int IdEmpresa)
        {
            try
            {
                List< ro_empleado_x_ro_tipoNomina_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context. ro_empleado_x_ro_tipoNomina
                             where q.IdEmpresa == IdEmpresa
                             select new  ro_empleado_x_ro_tipoNomina_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 IdTipoNomina = q.IdTipoNomina,
                                 observacion = q.observacion


                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public  ro_empleado_x_ro_tipoNomina_Info get_info(int IdEmpresa, int IdEmpleado, int IdNominaTipo)
        {
            try
            {
                 ro_empleado_x_ro_tipoNomina_Info info = new  ro_empleado_x_ro_tipoNomina_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                     ro_empleado_x_ro_tipoNomina Entity = Context. ro_empleado_x_ro_tipoNomina.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado && q.IdTipoNomina==IdNominaTipo);
                    if (Entity == null) return null;

                    info = new  ro_empleado_x_ro_tipoNomina_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        IdTipoNomina = Entity.IdTipoNomina,
                        observacion = Entity.observacion
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB( ro_empleado_x_ro_tipoNomina_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                     ro_empleado_x_ro_tipoNomina Entity = new  ro_empleado_x_ro_tipoNomina
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        IdTipoNomina = info.IdTipoNomina,
                        observacion = info.observacion
                       
                    };
                    Context. ro_empleado_x_ro_tipoNomina.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB( ro_empleado_x_ro_tipoNomina_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.Database.ExecuteSqlCommand("delete  ro_empleado_x_ro_tipoNomina where idEmpresa='" + info.IdEmpresa + "' and IdEmpleado='" + info.IdEmpleado + "' ");
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
