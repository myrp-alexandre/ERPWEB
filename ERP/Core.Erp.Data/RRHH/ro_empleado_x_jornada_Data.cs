using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.RRHH
{
    public class ro_empleado_x_jornada_Data
    {
        public List<ro_empleado_x_jornada_Info> GetList(int IdEmpresa, int IdJornada)
        {
            try
            {
                List<ro_empleado_x_jornada_Info> Lista;
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = Context.ro_empleado_x_jornada.Where(q => q.IdEmpresa == IdEmpresa
                    && q.IdJornada == IdJornada
                    ).Select(q => new ro_empleado_x_jornada_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdEmpleado = q.IdEmpleado,
                        IdJornada = q.IdJornada,
                        MaxNumHoras = q.MaxNumHoras,
                        Secuencia = q.Secuencia,
                        ValorHora = q.ValorHora
                    }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
