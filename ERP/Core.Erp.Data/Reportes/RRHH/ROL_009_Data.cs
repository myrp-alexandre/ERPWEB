using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
   public class ROL_009_Data
    {
        public List<ROL_009_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                fecha_inicio = fecha_inicio.Date;
                fecha_fin = fecha_fin.Date;

                List<ROL_009_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                   
                    Lista = (from q in Context.VWROL_009
                             where q.IdEmpresa == IdEmpresa
                             && q.FechaPago>=fecha_inicio
                             && q.FechaPago<=fecha_fin
                             select new ROL_009_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 CedulaRuc = q.CedulaRuc,
                                 IdRubro = q.IdRubro,
                                 FechaPago = q.FechaPago,
                                 Valor = q.Valor,
                                 EstadoCobro = q.EstadoCobro,
                                 RubroDescripcion = q.RubroDescripcion,
                                 Division = q.Division,
                                 Departamento = q.Departamento,
                                 IdEmpleado = q.IdEmpleado,
                                 IdDepartamento = q.IdDepartamento,
                                 IdDivision = q.IdDivision,
                                 CodigoEmpleado = q.CodigoEmpleado,
                                 pe_apellido = q.pe_apellido,
                                 pe_nombre = q.pe_nombre,
                                 Num_Horas = q.Num_Horas,
                                 ca_descripcion = q.ca_descripcion, 
                                 NombreCompleto = q.NombreCompleto
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
