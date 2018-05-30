using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_DocumentoxEmp_Data
    {

        public List<ro_DocumentoxEmp_Info> get_list(int IdEmpresa)
        {
            try
            {
                List<ro_DocumentoxEmp_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_DocumentoxEmp
                             where q.IdEmpresa == IdEmpresa
                             select new ro_DocumentoxEmp_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 IdDocumento = q.IdDocumento,
                                 Documento = q.Documento,
                                 Dc_Descripcion=q.Dc_Descripcion,
                                 Dc_Nombre=q.Dc_Nombre,
                                 Estado=q.Estado,
                                 tipo=q.tipo
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public ro_DocumentoxEmp_Info get_info(int IdEmpresa, int IdEmpleado, int IdDocumento)
        {
            try
            {
                ro_DocumentoxEmp_Info info = new ro_DocumentoxEmp_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_DocumentoxEmp Entity = Context.ro_DocumentoxEmp.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado == IdEmpleado && q.IdDocumento == IdDocumento);
                    if (Entity == null) return null;

                    info = new ro_DocumentoxEmp_Info
                    {

                        IdEmpresa = Entity.IdEmpresa,
                        IdEmpleado = Entity.IdEmpleado,
                        IdDocumento = Entity.IdDocumento,
                        Documento = Entity.Documento,
                        Dc_Descripcion = Entity.Dc_Descripcion,
                        Dc_Nombre = Entity.Dc_Nombre,
                        Estado = Entity.Estado,
                        tipo = Entity.tipo
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ro_DocumentoxEmp_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_DocumentoxEmp Entity = new ro_DocumentoxEmp
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdEmpleado = info.IdEmpleado,
                        IdDocumento = info.IdDocumento,
                        Documento = info.Documento,
                        Dc_Descripcion = info.Dc_Descripcion,
                        Dc_Nombre = info.Dc_Nombre,
                        Estado = info.Estado,
                        tipo = info.tipo,
                        FechaReg = info.FechaReg
                    };
                    Context.ro_DocumentoxEmp.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(ro_DocumentoxEmp_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Context.Database.ExecuteSqlCommand("delete  ro_DocumentoxEmp where idEmpresa='" + info.IdEmpresa + "' and IdEmpleado='" + info.IdEmpleado + "' ");
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
