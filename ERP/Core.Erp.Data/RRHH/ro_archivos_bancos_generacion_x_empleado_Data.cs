using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
   public class ro_archivos_bancos_generacion_x_empleado_Data
    {
        public List<ro_archivos_bancos_generacion_x_empleado_Info> get_list(int IdEmpresa, decimal IdArchivo)
        {
            try
            {
                List<ro_archivos_bancos_generacion_x_empleado_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_archivos_bancos_generacion_x_empleado
                             where q.IdEmpresa == IdEmpresa
                                   && q.IdArchivo == IdArchivo
                             select new ro_archivos_bancos_generacion_x_empleado_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdArchivo = q.IdArchivo,
                                 IdEmpleado = q.IdEmpleado,
                                 IdSucursal = q.IdSucursal,
                                 Valor = q.Valor,
                                  pagacheque=q.pagacheque
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_archivos_bancos_generacion_x_empleado_Info> info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    foreach (var item in info)
                    {
                        ro_archivos_bancos_generacion_x_empleado Entity = new ro_archivos_bancos_generacion_x_empleado
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdArchivo = item.IdArchivo,
                            IdSucursal = item.IdSucursal,
                            IdEmpleado = item.IdEmpleado,
                            Valor = item.Valor,
                            pagacheque = item.pagacheque,
                        };
                        Context.ro_archivos_bancos_generacion_x_empleado.Add(Entity);
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
        public bool eliminarDB(ro_archivos_bancos_generacion_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    string sql = "delete ro_archivos_bancos_generacion_x_empleado where IdEmpresa='" + info.IdEmpresa + "' and IdArchivo='" + info.IdArchivo + "'";
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
